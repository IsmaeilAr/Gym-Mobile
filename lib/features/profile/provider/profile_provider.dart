import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym/components/widgets/snackBar.dart';
import 'package:gym/features/profile/models/player_metrics_model.dart';
import 'package:gym/utils/helpers/api/api_helper.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../authentication/models/init_status_model.dart';
import '../models/user_model.dart';


class ProfileProvider extends ChangeNotifier {
  bool isDeviceConnected = false;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isLoadingEditMetrics = false;

  bool get isLoadingEditMetrics => _isLoadingEditMetrics;

  set isLoadingEditMetrics(bool value) {
    _isLoadingEditMetrics = value;
    notifyListeners();
  }

  bool _isLoadingEditInfo = false;

  bool get isLoadingEditInfo => _isLoadingEditInfo;

  set isLoadingEditInfo(bool value) {
    _isLoadingEditInfo = value;
    notifyListeners();
  }

  bool _isLoadingProfileInfo = false;

  bool get isLoadingProfileInfo => _isLoadingProfileInfo;

  set isLoadingProfileInfo(bool value) {
    _isLoadingProfileInfo = value;
    notifyListeners();
  }

  UserModel _profileInfo = UserModel(
    id: 0,
    name: "name",
    phoneNumber: "0999999999",
    birthDate: DateTime(2023),
    role: "Player",
    description: "",
    rate: 0,
    expiration: DateTime.now(),
    finance: 0,
    isPaid: false,
    images: [],
  );

  UserModel get profileInfo => _profileInfo;

  set profileInfo(UserModel value) {
    _profileInfo = value;
    notifyListeners();
  }

  bool _isLoadingPersonalMetrics = false;

  bool get isLoadingPersonalMetrics => _isLoadingPersonalMetrics;

  set isLoadingPersonalMetrics(bool value) {
    _isLoadingPersonalMetrics = value;
    notifyListeners();
  }

  PlayerMetricsModel _personalMetrics = PlayerMetricsModel(
    id: 1,
    gender: 'male',
    birthDate: DateTime.parse('2001-12-03'),
    age: 22,
    weight: 50,
    waistMeasurement: 20,
    neck: 13,
    height: 65,
    bfp: 16.58,
  );

  PlayerMetricsModel get personalMetrics => _personalMetrics;

  set personalMetrics(PlayerMetricsModel value) {
    _personalMetrics = value;
    notifyListeners();
  }



  bool _isLoadingProgramStatus = false;

  bool get isLoadingStatus => _isLoadingProgramStatus;

  set isLoadingStatus(bool value) {
    _isLoadingProgramStatus = value;
    notifyListeners();
  }

  InitStatusModel _status = InitStatusModel(hasCoach: false, hasProgram: false, programType: [], coachId: 0);

  InitStatusModel get status => _status;

  set status(InitStatusModel value) {
    _status = value;
    notifyListeners();
  }

  bool _hasCoach = false;

  bool get hasCoach => _hasCoach;

  set hasCoach(bool value) {
    _hasCoach = value;
    notifyListeners();
  }

  bool _hasProgram = false;

  bool get hasProgram => _hasProgram;

  set hasProgram(bool value) {
    _hasProgram = value;
    notifyListeners();
  }


  Future<void> getStatus(BuildContext context,) async {
    isLoadingStatus = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (isDeviceConnected) {
      try {
        Either<String, Response> results = await ApiHelper().initStatusApi();
        isLoadingStatus = false;
        results.fold((l) {
          isLoadingStatus = false;
           showMessage(l, false);
        }, (r) async {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("data $data");
            // List<dynamic> list = data;
            status = InitStatusModel.fromJson(data);
            hasCoach = status.hasCoach;
            hasProgram = status.hasProgram;
            // await prefs.setBool(Cache.hasCoach, hasCoach);
            // await prefs.setBool(Cache.hasProgram, hasProgram);
            isLoadingStatus = false;
          } else {
            isLoadingStatus = false;
            log("## ${response.data}");
          }
        });
      } on Exception catch (e) {
        log("Exception get Active players : $e");
         showMessage("$e", false);
        isLoadingStatus = false;
      }
    } else {
       showMessage("no_internet_connection", false);
      isLoadingStatus = false;
    }
    notifyListeners();
  }


  Future<bool> callAddInfoApi(
    BuildContext context,
    String gender,
    String dob,
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
          dob,
          height,
          weight,
          waist,
          neck,
        );
        isLoading = false;
        await results.fold((l) {
          isLoading = false;
           showMessage(l, false);
          repoStatus = false;
        }, (r) async {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("## $data");
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
       showMessage("no internet", false);
      isLoading = false;
      return false;
    }
  }

  Future<void> getProfileInfo(
    BuildContext context,
  ) async {
    isLoadingProfileInfo = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (isDeviceConnected) {
      try {
        Either<String, Response> results =
            await ApiHelper().getProfileInfoApi();
        isLoadingProfileInfo = false;
        results.fold((l) {
          isLoadingProfileInfo = false;
           showMessage(l, false);
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("data $data");
            // List<dynamic> list = data;
            profileInfo = UserModel.fromJson(data);
            isLoadingProfileInfo = false;
          } else {
            isLoadingProfileInfo = false;
            log("## ${response.data}");
          }
        });
      } on Exception catch (e) {
        log("Exception get profile info : $e");
         showMessage("$e", false);
        isLoadingProfileInfo = false;
      }
    } else {
       showMessage("no_internet_connection", false);
      isLoadingProfileInfo = false;
    }
    notifyListeners();
  }

  Future<void> getPersonalMetrics(
      BuildContext context,
      ) async {
    isLoadingPersonalMetrics = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (isDeviceConnected) {
      try {
        Either<String, Response> results =
        await ApiHelper().getPersonMetricsApi();
        isLoadingPersonalMetrics = false;
        results.fold((l) {
          isLoadingPersonalMetrics = false;
           showMessage(l, false);
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("data $data");
            // List<dynamic> list = data;
            personalMetrics = PlayerMetricsModel.fromJson(data[0]);
            isLoadingPersonalMetrics = false;
          } else {
            isLoadingPersonalMetrics = false;
            log("## ${response.data}");
          }
        });
      } on Exception catch (e) {
        log("Exception get profile info : $e");
         showMessage("$e", false);
        isLoadingPersonalMetrics = false;
      }
    } else {
       showMessage("no_internet_connection", false);
      isLoadingProfileInfo = false;
    }
    notifyListeners();
  }

  Future<bool> callEditMetrics(
      BuildContext context,
      // String gender,
      String dob,
      String height,
      String weight,
      String waist,
      String neck,
      ) async {
    isLoading = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    bool repoStatus = false;
    if (isDeviceConnected) {
      try {
        Either<String, Response> results = await ApiHelper().editMetricsApi(
          // gender,
          dob,
          height,
          weight,
          waist,
          neck,
        );
        isLoading = false;
        await results.fold((l) {
          isLoading = false;
           showMessage(l, false);
          repoStatus = false;
        }, (r) async {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("## $data");
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
       showMessage("no internet", false);
      isLoading = false;
      return false;
    }
  }

  Future<bool> callEditInfo(
      BuildContext context,
      String name,
      String phoneNumber,
      ) async {
    isLoading = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    bool repoStatus = false;
    if (isDeviceConnected) {
      try {
        Either<String, Response> results = await ApiHelper().editInfoApi(
          name,
          phoneNumber,
        );
        isLoading = false;
        await results.fold((l) {
          isLoading = false;
           showMessage(l, false);
          repoStatus = false;
        }, (r) async {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("## $data");
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
       showMessage("no internet", false);
      isLoading = false;
      return false;
    }
  }

}
