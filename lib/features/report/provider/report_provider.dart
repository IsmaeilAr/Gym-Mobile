import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym/components/widgets/snack_bar.dart';
import 'package:gym/utils/helpers/api/api_helper.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../model/report_model.dart';

class ReportProvider extends ChangeNotifier {
  bool isDeviceConnected = false;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isLoadingReports = false;

  bool get isLoadingReports => _isLoadingReports;

  set isLoadingReports(bool value) {
    _isLoadingReports = value;
    notifyListeners();
  }

  List<ReportModel> _reportList = [];

  List<ReportModel> get reportList => _reportList;

  set reportList(List<ReportModel> value) {
    _reportList = value;
    notifyListeners();
  }



  Future<bool> callSubmitReportApi(
      BuildContext context,
      String content,
      ) async {
    isLoading = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    bool repoStatus = false;
    if (isDeviceConnected) {
      try {
        Either<String, Response> results = await ApiHelper().submitReportApi(
          content,
        );
        isLoading = false;
        await results.fold((l) {
          isLoading = false;
           showMessage(l, false);
          repoStatus = false;
        }, (r) async {
          Response response = r;
          if (response.statusCode == 200) {
            var responseData = response.data["data"];
            log("## $responseData");
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


  Future<void> callGetReports(BuildContext context, int userId) async {
    isLoadingReports = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (isDeviceConnected) {
      try {
        Either<String, Response> results = await ApiHelper().getChatMessagesApi(userId);
        isLoadingReports = false;
        results.fold((l) {
          isLoadingReports = false;
           showMessage(l, false);
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("data $data");
            List<dynamic> list = data;
            reportList = list.map((e) => ReportModel.fromJson(e)).toList();
            isLoadingReports = false;
          } else {
            isLoadingReports = false;
            log("## ${response.data}");
          }
        });
      } on Exception catch (e) {
        log("Exception get chat : $e");
         showMessage("$e", false);
        isLoadingReports = false;
      }
    } else {
      showMessage(AppLocalizations.of(context)!.noInternet, false);
      isLoadingReports = false;
    }
    notifyListeners();
  } // not in use yet

}
