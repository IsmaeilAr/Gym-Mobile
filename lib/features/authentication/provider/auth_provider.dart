import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym/components/widgets/snack_bar.dart';
import 'package:gym/utils/helpers/api/api_helper.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../utils/helpers/cache.dart';
import '../../profile/models/user_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthProvider extends ChangeNotifier {
  bool isDeviceConnected = false;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // late UserModel _playerModel;
  UserModel _playerModel = UserModel(
      id: 0,
      name: "name",
      phoneNumber: "phoneNumber",
      birthDate: DateTime(1999),
      role: 'player ',
      description: 'description',
      rate: 0,
      expiration: DateTime(2000),
      finance: 10000,
      isPaid: false,
      images: []);

  UserModel get playerModel => _playerModel;

  set playerModel(UserModel value) {
    _playerModel = value;
    notifyListeners();
  }

  SharedPreferencesService prefsService = SharedPreferencesService.instance;

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
            playerModel = UserModel.fromJson(userData);
            await prefsService.setValue(Cache.token, uToken);
            await prefsService.setValue(Cache.isAuth, true);
            await prefsService.setValue(Cache.userId, playerModel.id);
            await prefsService.setValue(Cache.userName, playerModel.name);
            await prefsService.setValue(Cache.userPhone, phone);
            await prefsService.setValue(Cache.userPassword, password);
            // if (playerModel.images != null) {
            //   await prefsService.setValue(Cache.userImage, playerModel.images[0].image); }
            await prefsService.setValue(Cache.user, user);
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
      showMessage(AppLocalizations.of(context)!.noInternet, false);
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
              await prefsService.setValue(Cache.token, '');
              await prefsService.setValue(Cache.userPassword, '');
              await prefsService.setValue(Cache.userPhone, '');
              await prefsService.setValue(Cache.user, '');
              await prefsService.setValue(Cache.userName, '');
              await prefsService.setValue(Cache.userId, 0);
              await prefsService.setValue(Cache.isAuth, false);
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
      showMessage(AppLocalizations.of(context)!.noInternet, false);
      isLoading = false;
      return false;
    }
  }


}
