import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym/components/widgets/snack_bar.dart';
import 'package:gym/features/articles/models/articles_model.dart';
import 'package:gym/features/coaches/model/coach_time_model.dart';
import 'package:gym/features/profile/models/user_model.dart';
import 'package:gym/utils/helpers/api/api_helper.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../utils/services/coach_week_days_check.dart';

class CoachProvider extends ChangeNotifier {
  bool isDeviceConnected = false;

  bool _isLoadingGetUsers = false;

  bool get isLoadingGetUsers => _isLoadingGetUsers;

  set isLoadingGetUsers(bool value) {
    _isLoadingGetUsers = value;
    notifyListeners();
  }

  List<UserModel> _coachList = [];

  List<UserModel> get coachList => _coachList;

  set coachList(List<UserModel> value) {
    _coachList = value;
    notifyListeners();
  }

  List<UserModel> _playerList = [];

  List<UserModel> get playerList => _playerList;

  set playerList(List<UserModel> value) {
    _playerList = value;
    notifyListeners();
  }

  bool _isLoadingSetCoach = false;

  bool get isLoadingSetCoach => _isLoadingSetCoach;

  set isLoadingSetCoach(bool value) {
    _isLoadingSetCoach = value;
    notifyListeners();
  }

  bool _isLoadingArticles = false;

  bool get isLoadingArticles => _isLoadingArticles;

  set isLoadingArticles(bool value) {
    _isLoadingArticles = value;
    notifyListeners();
  }

  List<ArticleModel> _articleList = [];

  List<ArticleModel> get articleList => _articleList;

  set articlesList(List<ArticleModel> value) {
    _articleList = value;
    notifyListeners();
  }

  bool _isLoadingCoachInfo = false;

  bool get isLoadingCoachInfo => _isLoadingCoachInfo;

  set isLoadingCoachInfo(bool value) {
    _isLoadingCoachInfo = value;
    notifyListeners();
  }

  UserModel _coachInfo = UserModel(
    id: 1,
    name: "John Doe",
    phoneNumber: "1234567890",
    birthDate: DateTime(1990, 10, 15),
    role: "user",
    description: "",
    rate: 4.5,
    expiration: DateTime(2023, 12, 31),
    finance: 1000000,
    isPaid: true,
    images: [
      ImageModel(id: 1, image: "image1.jpg"),
    ],
  );

  UserModel get coachInfo => _coachInfo;

  set coachInfo(UserModel value) {
    _coachInfo = value;
    notifyListeners();
  }

  bool _isLoadingCoachTime = false;

  bool get isLoadingCoachTime => _isLoadingCoachTime;

  set isLoadingCoachTime(bool value) {
    _isLoadingCoachTime = value;
    notifyListeners();
  }

  List<CoachTimeModel> _coachTimesList = [];

  List<CoachTimeModel> get coachTimesList => _coachTimesList;

  set coachTimesList(List<CoachTimeModel> value) {
    _coachTimesList = value;
    notifyListeners();
  }

  bool _isLoadingSearchCoach = false;

  bool get isLoadingSearchCoach => _isLoadingSearchCoach;

  set isLoadingSearchCoach(bool value) {
    _isLoadingSearchCoach = value;
    notifyListeners();
  }

  List<UserModel> _searchCoachList = [];

  List<UserModel> get searchCoachList => _searchCoachList;

  set searchCoachList(List<UserModel> value) {
    _searchCoachList = value;
    notifyListeners();
  }

  //////////////////////////////////////////////////////////////////////////
  Future<bool> setCoach(
    BuildContext context,
    int coachId,
  ) async {
    isLoadingSetCoach = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    bool repoStatus = false;
    if (isDeviceConnected) {
      try {
        Either<String, Response> results = await ApiHelper().addOrderApi(
          coachId,
        );
        isLoadingSetCoach = false;
        await results.fold((l) {
          isLoadingSetCoach = false;
          showMessage(l, false);
          repoStatus = false;
        }, (r) async {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("## $data");
            isLoadingSetCoach = false;
            repoStatus = true;
          } else {
            isLoadingSetCoach = false;
            log("## ${response.statusCode}");
            log("## ${response.data}");
          }
        });
        return repoStatus;
      } on Exception catch (e) {
        showMessage("$e", false);
        isLoadingSetCoach = false;
        return false;
      }
    } else {
      showMessage(AppLocalizations.of(context)!.noInternet, false);
      isLoadingSetCoach = false;
      return false;
    }
  }

  Future<bool> unsetCoach(
    BuildContext context,
    int coachId,
  ) async {
    isLoadingSetCoach = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    bool repoStatus = false;
    if (isDeviceConnected) {
      try {
        Either<String, Response> results = await ApiHelper().addOrderApi(
          coachId,
        );
        isLoadingSetCoach = false;
        await results.fold((l) {
          isLoadingSetCoach = false;
           showMessage(l, false);
          repoStatus = false;
        }, (r) async {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("## $data");
            isLoadingSetCoach = false;
            repoStatus = true;
          } else {
            isLoadingSetCoach = false;
            log("## ${response.statusCode}");
            log("## ${response.data}");
          }
        });
        return repoStatus;
      } on Exception catch (e) {
         showMessage("$e", false);
        isLoadingSetCoach = false;
        return false;
      }
    } else {
      showMessage(AppLocalizations.of(context)!.noInternet, false);
      isLoadingSetCoach = false;
      return false;
    }
  }

  Future<void> getUsersList(BuildContext context, String type) async {
    isLoadingGetUsers = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (isDeviceConnected) {
      try {
        Either<String, Response> results = await ApiHelper().getUserListApi(type);
        isLoadingGetUsers = false;
        results.fold((l) {
          isLoadingGetUsers = false;
           showMessage(l, false);
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("data $data");
            List<dynamic> list = data;
            type == "Coach" ?
            coachList = list.map((e) => UserModel.fromJson(e)).toList():
            playerList = list.map((e) => UserModel.fromJson(e)).toList();
            isLoadingGetUsers = false;
          } else {
            isLoadingGetUsers = false;
            log("## ${response.data}");
          }
        });
      } on Exception catch (e) {
        log("Exception get $type programs : $e");
        showMessage("$e", false);
        isLoadingGetUsers = false;
      }
    } else {
      showMessage(AppLocalizations.of(context)!.noInternet, false);
      isLoadingGetUsers = false;
    }
    notifyListeners();
  }

  Future<void> searchUsers(BuildContext context, String userName) async {
    isLoadingSearchCoach = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (isDeviceConnected) {
      try {
        Either<String, Response> results =
            await ApiHelper().searchUsersApi(userName);
        isLoadingSearchCoach = false;
        results.fold((l) {
          isLoadingSearchCoach = false;
          showMessage(l, false);
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"][0];
            log("data $data");
            List<dynamic> list = data;
            searchCoachList = [];
            searchCoachList = list.map((e) => UserModel.fromJson(e)).toList();
            isLoadingSearchCoach = false;
          } else {
            isLoadingSearchCoach = false;
            log("## ${response.data}");
          }
        });
      } on Exception catch (e) {
        log("Exception get user search : $e");
        showMessage("$e", false);
        isLoadingSearchCoach = false;
      }
    } else {
      showMessage(AppLocalizations.of(context)!.noInternet, false);
      isLoadingSearchCoach = false;
    }
    notifyListeners();
  }

  Future<List<UserModel>> getCoachesList(
      BuildContext context, String type) async {
    isLoadingGetUsers = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (isDeviceConnected) {
      try {
        Either<String, Response> results =
            await ApiHelper().getUserListApi(type);
        isLoadingGetUsers = false;
        return results.fold<List<UserModel>>(
          (l) {
            isLoadingGetUsers = false;
            showMessage(l, false);
            return []; // Return an empty list in case of failure
          },
          (r) {
            Response response = r;
            if (response.statusCode == 200) {
              var data = response.data["data"];
              log("data $data");
              List<dynamic> list = data;
              isLoadingGetUsers = false;
              return list.map((e) => UserModel.fromJson(e)).toList();
            } else {
              isLoadingGetUsers = false;
              log("## ${response.data}");
              return []; // Return an empty list in case of failure
            }
          },
        );
      } catch (e) {
        log("Exception get $type programs : $e");
        showMessage("$e", false);
        isLoadingGetUsers = false;
        return []; // Return an empty list in case of exception
      }
    } else {
      showMessage(AppLocalizations.of(context)!.noInternet, false);
      isLoadingGetUsers = false;
      return []; // Return an empty list when there's no internet connection
    }
  }

  Future<void> getCoachInfo(BuildContext context, int coachId) async {
    isLoadingCoachInfo = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (isDeviceConnected) {
      try {
        Either<String, Response> results =
            await ApiHelper().getCoachInfoApi(coachId);
        isLoadingCoachInfo = false;
        results.fold((l) {
          isLoadingCoachInfo = false;
           showMessage(l, false);
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"][0];
            log("data $data");
            // List<dynamic> list = data;
            coachInfo = UserModel.fromJson(data);
            isLoadingCoachInfo = false;
          } else if (response.data["message"] == "Coach not found") {
            isLoadingCoachInfo = false;
            log("coach not set yet");
          } else {
            isLoadingCoachInfo = false;
            log("## ${response.data}");
          }
        });
      } on Exception catch (e) {
        log("Exception get profile info : $e");
         showMessage("$e", false);
        isLoadingCoachInfo = false;
      }
    } else {
      showMessage(AppLocalizations.of(context)!.noInternet, false);
      isLoadingCoachInfo = false;
    }
    notifyListeners();
  }

  Future<void> getCoachTime(BuildContext context, int coachId) async {
    isLoadingCoachTime = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    if (isDeviceConnected) {
      try {
        Either<String, Response> results =
        await ApiHelper().getCoachTimeApi(coachId);
        isLoadingCoachTime = false;
        results.fold((l) {
          isLoadingCoachTime = false;
           showMessage(l, false);
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("data $data");
            // List<dynamic> list = data;
            // List<String> namedDaysList = list.map((item) => item.toString()).toList();
            // doneDaysList = getNumericCheckList(namedDaysList);
            List<dynamic> list = data;
            List<CoachTimeModel> activeDaysList =
                list.map((e) => CoachTimeModel.fromJson(e)).toList();
            coachTimesList = getCoachDayList(activeDaysList);
            isLoadingCoachTime = false;
          } else {
            isLoadingCoachTime = false;
            log("## ${response.data}");
          }
        });
      } on Exception catch (e) {
        log("Exception get Coach Time programs : $e");
         showMessage("$e", false);
        isLoadingCoachTime = false;
      }
    } else {
      showMessage(AppLocalizations.of(context)!.noInternet, false);
      isLoadingCoachTime = false;
    }
    notifyListeners();
  }


}