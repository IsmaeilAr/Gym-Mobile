import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym/components/widgets/snack_bar.dart';
import 'package:gym/features/programs/model/category_model.dart';
import 'package:gym/features/programs/model/category_model.dart';
import 'package:gym/utils/helpers/api/api_helper.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../model/premium_status_model.dart';
import '../model/program_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProgramProvider extends ChangeNotifier {
  bool isDeviceConnected = false;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isLoadingPrograms = false;

  bool get isLoadingPrograms => _isLoadingPrograms;

  set isLoadingPrograms(bool value) {
    _isLoadingPrograms = value;
    notifyListeners();
  }

  List<ProgramModel> _sportProgramList = [];

  List<ProgramModel> get sportProgramList => _sportProgramList;

  set sportProgramList(List<ProgramModel> value) {
    _sportProgramList = value;
    notifyListeners();
  }

  List<ProgramModel> _nutritionProgramList = [];

  List<ProgramModel> get nutritionProgramList => _nutritionProgramList;

  set nutritionProgramList(List<ProgramModel> value) {
    _nutritionProgramList = value;
    notifyListeners();
  }

  List<ProgramModel> _premiumProgramList = [];

  List<ProgramModel> get premiumProgramList => _premiumProgramList;

  set premiumProgramList(List<ProgramModel> value) {
    _premiumProgramList = value;
    notifyListeners();
  }

  bool _isLoadingPremiumStatus = false;

  bool get isLoadingPremiumStatus => _isLoadingPremiumStatus;

  set isLoadingPremiumStatus(bool value) {
    _isLoadingPremiumStatus = value;
    notifyListeners();
  }

  List<PremiumStatusModel> _premiumStatusList = [];

  List<PremiumStatusModel> get premiumStatusList => _premiumStatusList;

  set premiumStatusList(List<PremiumStatusModel> value) {
    _premiumStatusList = value;
    notifyListeners();
  }

  bool _isLoadingCategories = false;

  bool get isLoadingCategories => _isLoadingCategories;

  set isLoadingCategories(bool value) {
    _isLoadingCategories = value;
    notifyListeners();
  }

  List<TrainingCategoryModel> _sportCategoriesList = [];

  List<TrainingCategoryModel> get sportCategoriesList => _sportCategoriesList;

  set sportCategoriesList(List<TrainingCategoryModel> value) {
    _sportCategoriesList = value;
    notifyListeners();
  }

  List<TrainingCategoryModel> _nutritionCategoriesList = [];

  List<TrainingCategoryModel> get nutritionCategoriesList => _nutritionCategoriesList;

  set nutritionCategoriesList(List<TrainingCategoryModel> value) {
    _nutritionCategoriesList = value;
    notifyListeners();
  }


  bool _isLoadingRecommendedProgram = false;

  bool get isLoadingRecommendedProgram => _isLoadingRecommendedProgram;

  set isLoadingRecommendedProgram(bool value) {
    _isLoadingRecommendedProgram = value;
    notifyListeners();
  }

  List<ProgramModel> _recommendedProgramList = [];

  List<ProgramModel> get recommendedProgramList => _recommendedProgramList;

  set recommendedProgramList(List<ProgramModel> value) {
    _recommendedProgramList = value;
    notifyListeners();
  }

  List<ProgramModel> _myCoachProgram = [];

  List<ProgramModel> get myCoachPrograms => _myCoachProgram;

  set myCoachPrograms(List<ProgramModel> value) {
    _myCoachProgram = value;
    notifyListeners();
  }

  bool _isLoadingSearch = false;

  bool get isLoadingSearch => _isLoadingSearch;

  set isLoadingSearch(bool value) {
    _isLoadingSearch = value;
    notifyListeners();
  }

  List<ProgramModel> _searchedPrograms = [];

  List<ProgramModel> get searchedPrograms => _searchedPrograms;

  set searchedPrograms(List<ProgramModel> value) {
    _searchedPrograms = value;
    notifyListeners();
  }

  ////////////////////////////////////////////////////////////////////
  Future<void> getProgramsList(
      BuildContext context, String type, int categoryID) async {
    isLoadingPrograms = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (isDeviceConnected) {
      try {
        Either<String, Response> results =
            await ApiHelper().getAllProgramsApi(type, categoryID);
        isLoadingPrograms = false;
        results.fold((l) {
          isLoadingPrograms = false;
           showMessage(l, false);
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("data $data");
            List<dynamic> list = data;
            type == "sport"
                ? {
                    sportProgramList = [],
                    sportProgramList =
                        list.map((e) => ProgramModel.fromJson(e)).toList()
                  }
                : {
                    nutritionProgramList = [],
                    nutritionProgramList =
                        list.map((e) => ProgramModel.fromJson(e)).toList()
                  };
            isLoadingPrograms = false;
          } else {
            isLoadingPrograms = false;
            log("## ${response.data}");
          }
        });
      } on Exception catch (e) {
        log("Exception get $type programs : $e");
        showMessage("$e", false);
        isLoadingPrograms = false;
      }
    } else {
      showMessage(AppLocalizations.of(context)!.noInternet, false);
      isLoadingPrograms = false;
    }
    notifyListeners();
  }

  Future<void> callSearchProgram(
      BuildContext context, String programName) async {
    searchedPrograms = [];
    (programName.isEmpty) ? {} : isLoadingSearch = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (isDeviceConnected) {
      try {
        Either<String, Response> results =
            await ApiHelper().searchProgramsApi(programName);
        isLoadingSearch = false;
        results.fold((l) {
          isLoadingSearch = false;
          showMessage(l, false);
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"][0];
            log("data $data");
            List<dynamic> list = data;
            searchedPrograms =
                list.map((e) => ProgramModel.fromJson(e)).toList();
            isLoadingSearch = false;
          } else {
            isLoadingSearch = false;
            log("## ${response.data}");
          }
        });
      } on Exception catch (e) {
        log("Exception get search programs : $e");
        showMessage("$e", false);
        isLoadingSearch = false;
      }
    } else {
      showMessage(AppLocalizations.of(context)!.noInternet, false);
      isLoadingSearch = false;
    }
    notifyListeners();
  }

  Future<void> getPremiumProgramsList(
    BuildContext context,
    String type,
  ) async {
    isLoading = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (isDeviceConnected) {
      try {
        Either<String, Response> results =
            await ApiHelper().getPremiumProgramsApi(
          type,
        );
        isLoading = false;
        results.fold((l) {
          isLoading = false;
          showMessage(l, false);
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("data $data");
            List<dynamic> list = data;
            premiumProgramList =
                list.map((e) => ProgramModel.fromJson(e)).toList();
            isLoading = false;
          } else {
            isLoading = false;
            log("## ${response.data}");
          }
        });
      } on Exception catch (e) {
        log("Exception get premium $type programs : $e");
         showMessage("$e", false);
        isLoading = false;
      }
    } else {
      showMessage(AppLocalizations.of(context)!.noInternet, false);
      isLoading = false;
    }
    notifyListeners();
  }

  Future<void> getPremiumStatus(
    // todo use this
    BuildContext context,
    String genre,
  ) async {
    isLoadingPremiumStatus = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (isDeviceConnected) {
      try {
        Either<String, Response> results = await ApiHelper().getMyOrderApi(
          genre,
        );
        isLoadingPremiumStatus = false;
        results.fold((l) {
          isLoadingPremiumStatus = false;
          showMessage(l, false);
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            List<dynamic> data = response.data["data"];
            log("data $data");
            premiumStatusList =
                data.map((e) => PremiumStatusModel.fromJson(e)).toList();
            isLoadingPremiumStatus = false;
          } else {
            isLoadingPremiumStatus = false;
            log("## ${response.data}");
          }
        });
      } on Exception catch (e) {
        log("Exception get premium $genre status : $e");
        showMessage("$e", false);
        isLoadingPremiumStatus = false;
      }
    } else {
      showMessage(AppLocalizations.of(context)!.noInternet, false);
      isLoadingPremiumStatus = false;
    }
    notifyListeners();
  }

  void getMyCoachPrograms (BuildContext context, String type, myCoachId){
    myCoachPrograms = [];
    type == "sport"
        ? myCoachPrograms = sportProgramList.where((item) => item.coachId == myCoachId).toList() :
    myCoachPrograms = nutritionProgramList.where((item) => item.coachId == myCoachId).toList();
  }

  Future<void> getCategoriesList(BuildContext context, String type) async {
    isLoadingCategories = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (isDeviceConnected) {
      try {
        Either<String, Response> results =
            await ApiHelper().getAllCategoriesApi(type);
        isLoadingCategories = false;
        results.fold((l) {
          isLoadingCategories = false;
           showMessage(l, false);
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("data $data");
            List<dynamic> list = data;
            type == "sport"
                ? _sportCategoriesList =
                    list.map((e) => TrainingCategoryModel.fromJson(e)).toList()
                : _nutritionCategoriesList =
                    list.map((e) => TrainingCategoryModel.fromJson(e)).toList();
            isLoadingCategories = false;
          } else {
            isLoadingCategories = false;
            log("## ${response.data}");
          }
        });
      } on Exception catch (e) {
        log("Exception get $type categories : $e");
         showMessage("$e", false);
        isLoadingCategories = false;
      }
    } else {
      showMessage(AppLocalizations.of(context)!.noInternet, false);
      isLoadingCategories = false;
    }
    notifyListeners();
  }

  Future<void> callSetProgram(BuildContext context, int programId) async {
    isLoading = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (isDeviceConnected) {
      try {
        Either<String, Response> results =
            await ApiHelper().setProgramApi(programId);
        isLoading = false;
        results.fold((l) {
          isLoading = false;
           showMessage(l, false);
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("## $data");
            isLoading = false;
          } else {
            isLoading = false;
            log("## ${response.data}");
          }
        });
      } on Exception catch (e) {
        log("Exception set program : $e");
        showMessage("$e", false);
        isLoading = false;
      }
    } else {
      showMessage(AppLocalizations.of(context)!.noInternet, false);
      isLoading = false;
    }
    notifyListeners();
  }

  Future<void> callUnSetProgram(BuildContext context, int programId) async {
    isLoading = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (isDeviceConnected) {
      try {
        Either<String, Response> results =
            await ApiHelper().unsetProgramApi(programId);
        isLoading = false;
        results.fold((l) {
          isLoading = false;
          showMessage(l, false);
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("## $data");
            isLoading = false;
          } else {
            isLoading = false;
            log("## ${response.data}");
          }
        });
      } on Exception catch (e) {
        log("Exception Unset program : $e");
        showMessage("$e", false);
        isLoading = false;
      }
    } else {
      showMessage(AppLocalizations.of(context)!.noInternet, false);
      isLoading = false;
    }
    notifyListeners();
  }

  Future<void> callRequestPremiumProgram(
      BuildContext context, int coachId, String genre) async {
    isLoading = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (isDeviceConnected) {
      try {
        Either<String, Response> results =
            await ApiHelper().requestPremiumProgramApi(coachId, genre);
        isLoading = false;
        results.fold((l) {
          isLoading = false;
          showMessage(l, false);
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("## $data");
            isLoading = false;
          } else {
            isLoading = false;
            log("## ${response.data}");
          }
        });
      } on Exception catch (e) {
        log("Exception request premium program : $e");
        showMessage("$e", false);
        isLoading = false;
      }
    } else {
      showMessage(AppLocalizations.of(context)!.noInternet, false);
      isLoading = false;
    }
    notifyListeners();
  }

  Future<void> callCancelOrder(
    BuildContext context,
    int orderId,
  ) async {
    isLoading = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (isDeviceConnected) {
      try {
        Either<String, Response> results = await ApiHelper().cancelOrderApi(
          orderId,
        );
        isLoading = false;
        results.fold((l) {
          isLoading = false;
          showMessage(l, false);
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("## $data");
            isLoading = false;
            showMessage('order canceled', true);
          } else {
            isLoading = false;
            log("## ${response.data}");
          }
        });
      } on Exception catch (e) {
        log("Exception cancel order : $e");
        showMessage("$e", false);
        isLoading = false;
      }
    } else {
      showMessage(AppLocalizations.of(context)!.noInternet, false);
      isLoading = false;
    }
    notifyListeners();
  }
}
