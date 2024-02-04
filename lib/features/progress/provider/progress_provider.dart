import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym/components/widgets/snackBar.dart';
import 'package:gym/features/progress/models/monthly_model.dart';
import 'package:gym/utils/helpers/api/api_helper.dart';
import 'package:gym/utils/services/week_days_check.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ProgressProvider extends ChangeNotifier {
  bool isDeviceConnected = false;

  bool _isLoadingMonthlyProgress = false;

  bool get isLoadingMonthlyProgress => _isLoadingMonthlyProgress;

  set isLoadingMonthlyProgress(bool value) {
    _isLoadingMonthlyProgress = value;
    notifyListeners();
  }

  MonthlyProgressModel _monthProgress = MonthlyProgressModel(dates: []);

  MonthlyProgressModel get monthProgress => _monthProgress;

  set monthProgress(MonthlyProgressModel value) {
    _monthProgress = value;
    notifyListeners();
  }

  bool _isLoadingWeeklyProgress = false;

  bool get isLoadingWeeklyProgress => _isLoadingWeeklyProgress;

  set isLoadingWeeklyProgress(bool value) {
    _isLoadingWeeklyProgress = value;
    notifyListeners();
  }

  List<int> doneDaysList = [];

  Future<void> getMonthlyProgress(BuildContext context,) async {
    isLoadingMonthlyProgress = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (isDeviceConnected) {
      try {
        Either<String, Response> results = await ApiHelper().getMonthlyProgressApi();
        isLoadingMonthlyProgress = false;
        results.fold((l) {
          isLoadingMonthlyProgress = false;
          showMessage(l, false);
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("data $data");
            // List<dynamic> list = data;
            monthProgress = MonthlyProgressModel.fromJson(data);
            isLoadingMonthlyProgress = false;
          } else {
            isLoadingMonthlyProgress = false;
            log("## ${response.data}");
          }
        });
      } on Exception catch (e) {
        log("Exception get month Progress : $e");
        showMessage("$e", false);
        isLoadingMonthlyProgress = false;
      }
    } else {
      showMessage("no_internet_connection", false);
      isLoadingMonthlyProgress = false;
    }
    notifyListeners();
  }

  Future<void> getWeeklyProgressApi(BuildContext context,) async {
    isLoadingWeeklyProgress = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (isDeviceConnected) {
      try {
        Either<String, Response> results = await ApiHelper().getWeeklyProgressApi();
        isLoadingWeeklyProgress = false;
        results.fold((l) {
          isLoadingWeeklyProgress = false;
          showMessage(l, false);
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("data $data");
            List<dynamic> list = data;
            List<String> namedDaysList = list.map((item) => item.toString()).toList();
            doneDaysList = getNumericCheckList(namedDaysList);
            isLoadingWeeklyProgress = false;
          } else {
            isLoadingWeeklyProgress = false;
            log("## ${response.data}");
          }
        });
      } on Exception catch (e) {
        log("Exception get weekly progress : $e");
        showMessage("$e", false);
        isLoadingWeeklyProgress = false;
      }
    } else {
      showMessage("no_internet_connection", false);
      isLoadingWeeklyProgress = false;
    }
    notifyListeners();
  }


}