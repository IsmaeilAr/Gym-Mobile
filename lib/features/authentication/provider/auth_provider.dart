import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym/components/widgets/snackBar.dart';
import 'package:gym/main.dart';
import 'package:gym/utils/helpers/api/api_helper.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../utils/helpers/cache.dart';
import '../../profile/models/user_model.dart';


class AuthProvider extends ChangeNotifier {
  bool isDeviceConnected = false;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }


   Future<bool> callLoginApi(
      BuildContext context,
      String phone,
      String password,
      ) async {
    isLoading = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    bool repoStatus = false;
    if (isDeviceConnected) {
      try {
        Either<String, Response> results = await ApiHelper().loginApi(
          phone,
          password,
        );
        isLoading = false;
        await results.fold((l) {
          isLoading = false;
          repoStatus = false;
        }, (r) async {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            String user = response.data["data"]["data"]["user"].toString();
            var userData = response.data["data"]["data"]["user"];
            log(data.toString());
            // log(user);
            String uToken = "Bearer ${data["data"]['token']}";
            // UserModel userModel = UserModel.fromJson(userData);
            UserModel playerModel = UserModel.fromJson(userData);
            await prefs.setString(Cache.token, uToken);
            await prefs.setBool(Cache.isAuth, true);
            await prefs.setInt(Cache.userId, playerModel.id);
            await prefs.setString(Cache.userName, playerModel.name);
            await prefs.setString(Cache.userPhone, phone);
            await prefs.setString(Cache.userPassword, password);
            await prefs.setString(Cache.userImage, "${ApiHelper.imageUrl}${playerModel.images[0].image}");
            await prefs.setString(Cache.user, user);
            // await prefs.setBool(Constants.firstOpen, true);
            // await prefs.setBool(Constants.isIphone, true);
            isLoading = false;
            repoStatus = true;
            log("login success $repoStatus");
          } else {
            isLoading = false;
            return false;
          }
        });
        return repoStatus;
      } on Exception catch (e) {
        log("Exception : $e");
        isLoading = false;
        return false;
      }
    } else {
      isLoading = false;
      return false;
    }
  }

  Future<bool> callLogoutApi(
      BuildContext context,
      ) async {
    isLoading = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    bool repoStatus = false;
    if (isDeviceConnected) {
      try {
        Either<String, Response> results = await ApiHelper().logoutApi();
        isLoading = false;
        results.fold((l) {
          isLoading = false;
           showMessage(l, false);
          repoStatus = false;
        }, (r) async {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            int? status = response.statusCode;
            String message = data['message'];
            log("## ${response.data}");
            if (status == 200) {
              isLoading = false;
              repoStatus = true;
              debugPrint("logged out");
              await prefs.setString(Cache.token, '');
              await prefs.setString(Cache.userPassword, '');
              await prefs.setString(Cache.userPhone, '');
              await prefs.setString(Cache.user, '');
              await prefs.setString(Cache.userName, '');
              await prefs.setInt(Cache.userId, 0);
              await prefs.setBool(Cache.isAuth, false);
              debugPrint("cleared cache");
            } else {
              isLoading = false;
               showMessage(message, false);
              repoStatus = false;
            }
          } else {
            isLoading = false;
            log("## ${response.data}");
            return false;
          }
        });
        return repoStatus;
      } on Exception catch (e) {
        log("Exception : $e");
         showMessage("$e", false);
        isLoading = false;
        return false;
      }
    } else {
       showMessage("LocaleKeys.txt_no_internet_connection.tr()2", false);
      isLoading = false;
      return false;
    }
  }


}
