import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym/components/widgets/snackBar.dart';
import 'package:gym/features/progress/models/monthly_model.dart';
import 'package:gym/utils/helpers/api/api_helper.dart';
import 'package:gym/utils/services/week_days_check.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  bool _isLoadingProgramProgress = false;

  bool get isLoadingProgramProgress => _isLoadingProgramProgress;

  set isLoadingProgramProgress(bool value) {
    _isLoadingProgramProgress = value;
    notifyListeners();
  }

  double _programProgress = 0;

  double get programProgress => _programProgress;

  set programProgress(double value) {
    _programProgress = value;
    notifyListeners();
  }

  Future<void> getMonthlyProgress(
    BuildContext context,
  ) async {
    isLoadingMonthlyProgress = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (isDeviceConnected) {
      try {
        Either<String, Response> results =
            await ApiHelper().getMonthlyProgressApi();
        isLoadingMonthlyProgress = false;
        results.fold((l) {
          isLoadingMonthlyProgress = false;
          showMessage(l, false);
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data;
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
      showMessage(AppLocalizations.of(context)!.noInternet, false);
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
      showMessage(AppLocalizations.of(context)!.noInternet, false);
      isLoadingWeeklyProgress = false;
    }
    notifyListeners();
  }

  Future<void> getProgramProgressApi(
    BuildContext context,
  ) async {
    isLoadingProgramProgress = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (isDeviceConnected) {
      try {
        Either<String, Response> results =
            await ApiHelper().getWeeklyProgressApi();
        isLoadingProgramProgress = false;
        results.fold((l) {
          isLoadingProgramProgress = false;
          showMessage(l, false);
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("data $data");
            int number = data;
            programProgress = number.toDouble();
            isLoadingProgramProgress = false;
          } else {
            isLoadingProgramProgress = false;
            log("## ${response.data}");
          }
        });
      } on Exception catch (e) {
        log("Exception get program progress : $e");
        showMessage("$e", false);
        isLoadingProgramProgress = false;
      }
    } else {
      showMessage(AppLocalizations.of(context)!.noInternet, false);
      isLoadingProgramProgress = false;
    }
    notifyListeners();
  }
}