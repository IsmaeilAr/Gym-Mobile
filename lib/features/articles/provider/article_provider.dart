import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym/components/widgets/snack_bar.dart';
import 'package:gym/features/articles/models/articles_model.dart';
import 'package:gym/utils/helpers/api/api_helper.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ArticleProvider extends ChangeNotifier {
  bool isDeviceConnected = false;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
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

  List<ArticleModel> _filteredArticleList = [];

  List<ArticleModel> get foundArticleList => _filteredArticleList;

  set foundArticleList (List<ArticleModel> value) {
    _filteredArticleList = value;
    notifyListeners();
  }

  List<ArticleModel> _favouriteArticleList = [];

  List<ArticleModel> get favouriteArticleList => _favouriteArticleList;

  set favouriteArticleList (List<ArticleModel> value) {
    _favouriteArticleList = value;
    notifyListeners();
  }

  bool _isLoadingCoachArticles = false;

  bool get isLoadingCoachArticles => _isLoadingCoachArticles;

  set isLoadingCoachArticles(bool value) {
    _isLoadingCoachArticles = value;
    notifyListeners();
  }

  List<ArticleModel> _coachArticleList = [];

  List<ArticleModel> get coachArticleList => _coachArticleList;

  set coachArticleList (List<ArticleModel> value) {
    _coachArticleList = value;
    notifyListeners();
  }



  Future<bool> callAddArticleApi(
      BuildContext context,
      String title,
      String content,
      ) async {
    isLoading = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    bool repoStatus = false;
    if (isDeviceConnected) {
      try {
        Either<String, Response> results = await ApiHelper().addArticleApi(
          title,
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
      showMessage(AppLocalizations.of(context)!.noInternet, false);
      isLoading = false;
      return false;
    }
  }

  Future<void> callGetArticles(BuildContext context,) async {
    isLoadingArticles = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    if (isDeviceConnected) {
      try {
        Either<String, Response> results = await ApiHelper().getArticlesApi();
        isLoadingArticles = false;
        results.fold((l) {
          isLoadingArticles = false;
           showMessage(l, false);
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("data $data");
            List<dynamic> list = data;
            // articlesList = [];
            articlesList = list.map((e) => ArticleModel.fromJson(e)).toList();
            isLoadingArticles = false;
          } else {
            isLoadingArticles = false;
            log("## ${response.data}");
          }
        });
      } on Exception catch (e) {
        log("Exception get Articles programs : $e");
         showMessage("$e", false);
        isLoadingArticles = false;
      }
    } else {
      showMessage(AppLocalizations.of(context)!.noInternet, false);
      isLoadingArticles = false;
    }
    notifyListeners();
  }

  Future<void> callGetCoachArticles(BuildContext context, coachId) async {
    isLoadingCoachArticles = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (isDeviceConnected) {
      try {
        Either<String, Response> results =
            await ApiHelper().getCoachArticlesApi(coachId);
        isLoadingCoachArticles = false;
        results.fold((l) {
          isLoadingCoachArticles = false;
          showMessage(l, false);
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("data $data");
            List<dynamic> list = data;
            coachArticleList = list.map((e) => ArticleModel.fromJson(e)).toList();
            isLoadingCoachArticles = false;
          } else {
            isLoadingCoachArticles = false;
            log("## ${response.data}");
          }
        });
      } on Exception catch (e) {
        log("Exception get Articles list : $e");
         showMessage("$e", false);
        isLoadingCoachArticles = false;
      }
    } else {
      showMessage(AppLocalizations.of(context)!.noInternet, false);
      isLoadingCoachArticles = false;
    }
    notifyListeners();
  }


  Future<bool> callDeleteArticles(
      BuildContext context,
      int messageID,
      ) async {
    isLoading = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    bool repoStatus = false;
    if (isDeviceConnected) {
      try {
        Either<String, Response> results =
        await ApiHelper().deleteArticleApi(messageID);
        isLoading = false;
        results.fold((l) {
          isLoading = false;
           showMessage(l, false);
          repoStatus = false;
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data["data"];
            log("data $data");
            repoStatus = true;
             showMessage("delete_success", true);
            isLoading = false;
            repoStatus = true;
          } else {
            isLoading = false;
            log("## ${response.data}");
            repoStatus = false;
          }
        });
        return repoStatus;
      } on Exception catch (e) {
        log("Exception delete article: $e");
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

  Future<bool> changeArticleFav(
      BuildContext context,
      int articleId,
      bool isFav,
      ) async {
    isLoading = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    bool repoStatus = false;
    if (isDeviceConnected) {
      try {
        Either<String, Response> results = await ApiHelper().changeArticleFavApi(
          articleId,
          isFav,
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
            log("## changeArticleFav ${response.statusCode}");
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


}
