import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym/features/authentication/models/user_model.dart';
import 'package:gym/main.dart';
import 'package:gym/utils/helpers/Cache.dart';
import 'package:gym/utils/helpers/api/api_helper.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


class AuthProvider extends ChangeNotifier {
  bool isDeviceConnected = false;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }


  // dynamic _userInfo ;
  //
  // get userInfo => _userInfo;
  //
  // set userInfo(var value) {
  //   _userInfo = value;
  //   notifyListeners();
  // }

  // List<UserModel> _usersList = [];
  //
  // List<UserModel> get usersList => _usersList;
  //
  // set usersList(List<UserModel> value) {
  //   _usersList = value;
  //   notifyListeners();
  // }



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
            var data = response.data;
            String user = response.data["data"]["data"]["user"].toString();
            var userData = response.data["data"]["data"]["user"];
            log(data.toString());
            log(user);
            String uToken = "Bearer ${data["data"]["data"]['token']}";
            UserModel userModel = UserModel.fromJson(userData);
            await prefs.setString(Cache.token, uToken);
            await prefs.setString(Cache.userPassword, password);
            await prefs.setString(Cache.userPhone, phone);
            await prefs.setString(Cache.user, user);
            await prefs.setString(Cache.userName, userModel.name);
            await prefs.setBool(Cache.isAuth, true);
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

}
