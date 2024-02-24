import 'dart:async';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym/components/widgets/snack_bar.dart';
import 'package:gym/features/home/models/active_players_model.dart';
import 'package:gym/features/profile/models/user_model.dart';
import 'package:gym/utils/helpers/api/api_helper.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeProvider extends ChangeNotifier {
  bool isDeviceConnected = false;

  bool _isLoadingCheckIn = false;

  bool get isLoadingCheckIn => _isLoadingCheckIn;

  set isLoadingCheckIn(bool value) {
    _isLoadingCheckIn = value;
    notifyListeners();
  }

  bool _isCheckIn = false;

  bool get isCheckIn => _isCheckIn;

  set isCheckIn(bool value) {
    _isCheckIn = value;
    notifyListeners();
  }

  bool _showCheckInSuccess  = false;

  bool get showCheckInSuccess  => _showCheckInSuccess ;

  set showCheckInSuccess (bool value) {
    _showCheckInSuccess = value;
    notifyListeners();
  }

  bool _isLoadingActivePlayers = false;

  bool get isLoadingActivePlayers => _isLoadingActivePlayers;

  set isLoadingActivePlayers(bool value) {
    _isLoadingActivePlayers = value;
    notifyListeners();
  }

  List<UserModel> _activePlayersList = [];

  List<UserModel> get activePlayersList => _activePlayersList;

  set activePlayersList(List<UserModel> value) {
    _activePlayersList = value;
    notifyListeners();
  }

  bool _isBusy = false;

  bool get isBusy => _isBusy;

  set isBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  List<dynamic> _playersList = [];

  List<dynamic> get playersList => _playersList;

  set playersList(List<dynamic> value) {
    _playersList = value;
    notifyListeners();
  }


  Future<void> getActivePlayersApi(BuildContext context,) async {
    isLoadingActivePlayers = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (isDeviceConnected) {
      try {
        Either<String, Response> results = await ApiHelper().activePlayerApi();
        isLoadingActivePlayers = false;
        results.fold((l) {
          isLoadingActivePlayers = false;
          showMessage(l, false);
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("data $data");
            isBusy = data['isTraffic'] == true;
            // if (data['isTraffic'] == true) isBusy = true;
            var list = data["activePlayer"];
            (list.isNotEmpty) ?
            playersList = list.map((e) => ActivePlayer.fromJson(e)).toList() : playersList= [];
            isLoadingActivePlayers = false;
          } else {
            isLoadingActivePlayers = false;
            log("## ${response.data}");
          }
        });
      } on Exception catch (e) {
        log("Exception get Active players : $e");
        showMessage("$e", false);
        isLoadingActivePlayers = false;
      }
    } else {
      showMessage(AppLocalizations.of(context)!.noInternet, false);
      isLoadingActivePlayers = false;
    }
    notifyListeners();
  }

  Future<bool> callCheckInApi(BuildContext context,) async {
    isLoadingCheckIn = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    bool repoStatus = false;
    if (isDeviceConnected) {
      try {
        var time = DateTime.now().toString();
        int day = DateTime.now().day;
        String content = time;
        debugPrint(time);
        Either<String, Response> results = await ApiHelper().checkInApi(
          content,
          day,
        );
        isLoadingCheckIn = false;
        await results.fold((l) {
          isLoadingCheckIn = false;
          showMessage(l, false);
          repoStatus = false;
        }, (r) async {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("## $data");
            isLoadingCheckIn = false;
            repoStatus = true;
            onCheckIn();
          } else {
            isLoadingCheckIn = false;
            log("## ${response.statusCode}");
            log("## ${response.data}");
          }
        });
        return repoStatus;
      } on Exception catch (e) {
        showMessage("$e", false);
        isLoadingCheckIn = false;
        return false;
      }
    } else {
      showMessage(AppLocalizations.of(context)!.noInternet, false);
      isLoadingCheckIn = false;
      return false;
    }
  }

  Future<void> onCheckIn() async {
    showCheckInSuccess = true;
    isCheckIn = true;
    Timer(const Duration(seconds: 2), () {
      showCheckInSuccess = false;
    });
  }

  Future<bool> callCheckOutApi(
    BuildContext context,
  ) async {
    isLoadingCheckIn = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    bool repoStatus = false;
    if (isDeviceConnected) {
      try {
        var time = DateTime.now().toString();
        String content = time;
        Either<String, Response> results = await ApiHelper().checkOutApi(
          content,
        );
        isLoadingCheckIn = false;
        await results.fold((l) {
          isLoadingCheckIn = false;
          showMessage(l, false);
          repoStatus = false;
        }, (r) async {
          Response response = r;
          if (response.statusCode == 200) {
            // var data = response.data["data"];
            // log("## $data");
            isLoadingCheckIn = false;
            repoStatus = true;
          } else {
            isLoadingCheckIn = false;
            log("## ${response.statusCode}");
            log("## ${response.data}");
          }
        });
        return repoStatus;
      } on Exception catch (e) {
        showMessage("$e", false);
        isLoadingCheckIn = false;
        return false;
      }
    } else {
      showMessage(AppLocalizations.of(context)!.noInternet, false);
      isLoadingCheckIn = false;
      return false;
    }
  }

}
