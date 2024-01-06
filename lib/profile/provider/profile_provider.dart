import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym/authentication/models/user_model.dart';
import 'package:gym/utils/helpers/api/api_helper.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


class ProfileProvider extends ChangeNotifier {
  bool isDeviceConnected = false;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }


  String _gender = "" ;

  get gender => _gender;

  set gender(var value) {
    _gender = value;
    notifyListeners();
  }

  List<UserModel> _usersList = [];

  List<UserModel> get usersList => _usersList;

  set usersList(List<UserModel> value) {
    _usersList = value;
    notifyListeners();
  }



  Future<bool> callAddInfoApi(
      BuildContext context,
      String gender,
      // String dob,
      double height,
      double weight,
      double waist,
      double neck,
      ) async {
    isLoading = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    bool repoStatus = false;
    if (isDeviceConnected) {
      try {
        Either<String, Response> results = await ApiHelper().addInfoApi(
          gender,
          // dob,
          height,
          weight,
          waist,
          neck,
        );
        isLoading = false;
        await results.fold((l) {
          isLoading = false;
          // showMessage(l, false);
          repoStatus = false;
        }, (r) async {
          Response response = r;
          if (response.statusCode == 201) {
            var userData = response.data["admin"];
            log("## $userData");
            isLoading = false;
            repoStatus = true;
          } else {
            isLoading = false;
            log("## ${response.statusCode}");
            log("## ${response.data}");
          }
        });
        return repoStatus;
      } on Exception catch (e) {
        // showMessage("$e", false);
        isLoading = false;
        return false;
      }
    } else {
      // showMessage("no internet", false);
      isLoading = false;
      return false;
    }
  }


}
