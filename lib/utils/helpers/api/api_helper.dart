import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym/components/widgets/snackBar.dart';
import 'package:gym/utils/helpers/api/session_expired_interceptor.dart';
import 'package:gym/utils/helpers/cache.dart';
import 'package:gym/utils/helpers/api/dio_exceptions.dart';


class ApiHelper {
  // static String serverUrl = "http://91.144.20.117:6002/";
  static String serverUrl = "http://192.168.2.138:808/";
  static String baseUrl = "${serverUrl}api/";
  static String imageUrl = "${serverUrl}uploads/images/";

  String loginUrl = "${baseUrl}login";
  String logoutUrl = "${baseUrl}logout";
  String initStatusUrl = "${baseUrl}status";
  String activePlayersUrl = "${baseUrl}activePlayers";
  String getMyProfileInfoUrl = "${baseUrl}showPlayer";
  String addInfoUrl = "${baseUrl}addInfo";
  String editInfoUrl = "${baseUrl}update"; // todo fix Url
  String editMetricsUrl = "${baseUrl}updateInfo";
  String addProgramUrl = "${baseUrl}store";
  String editProgramUrl = "${baseUrl}store"; // todo fix Url
  String assignProgramUrl = "${baseUrl}store"; // todo fix Url
  String getChatsUrl = "${baseUrl}listChat";
  String checkInUrl = "${baseUrl}storeUserTime";
  String storeTimeUrl = "${baseUrl}storeTime";
  String checkOutUrl = "${baseUrl}endCounter";
  String weeklyUrl = "${baseUrl}weekly";
  String monthlyUrl = "${baseUrl}monthly";
  String programProgressUrl = "${baseUrl}programCommitment";
  String sendMessageUrl = "${baseUrl}sendMessage";
  String setRateUrl = "${baseUrl}setRate";
  String submitReportUrl = "${baseUrl}addReport";
  String orderProgramUrl = "${baseUrl}addOrder";
  String getMyOrderUrl = "${baseUrl}getMyOrder";
  String acceptOrderUrl = "${baseUrl}acceptOrder";
  String programSearchUrl = "${baseUrl}programSearch";
  String setProgramUrl = "${baseUrl}setProgram";
  String unsetProgramUrl = "${baseUrl}unsetProgram"; //todo fix url
  String requestProgramUrl = "${baseUrl}requestPrograme";
  String userSearchUrl = "${baseUrl}userSearch";
  String getNotificationsUrl = "${baseUrl}listNotification";
  String getArticlesUrl = "${baseUrl}allArticle";
  String addArticleUrl = "${baseUrl}addArticle";

  static String getProfileInfoUrl(
    int userId,
  ) {
    return "${baseUrl}playerInfo/$userId";
  }

  static String getPersonMetricsUrl(
      int userId,
      ) {
    return "${baseUrl}showInfo/$userId";
  }

  static String chatMessagesUrl(
      int userId,
      ) {
    return "${baseUrl}showChat/$userId";
  }

  static String allProgramsUrl(
      String type, int categoryID,
      ) {
      String url = "${baseUrl}show?type=$type" ;
      if (categoryID != 0)
      url = "${baseUrl}show?type=$type&categoryId=$categoryID";
    return  url ;
  }

  static String premiumProgramsUrl(
    String type,
  ) {
    return "${baseUrl}getPrograms?type=$type";
  }


  static String allCategoriesUrl(
      String type,
      ) {
    return "${baseUrl}getCategories?type=$type";
  }

  static String myProgramsUrl(
      String type,
      ) {
    return "${baseUrl}myprogram?type=$type";
  }

  static String assignUrl(
      int programId,
      ) {
    return "${baseUrl}asignprogram/$programId";
  }

  static String showCoachTimeUrl(
      int coachId,
      ) {
    return "${baseUrl}showCoachTime/$coachId";
  }

  static String showCoachInfoUrl(
      int coachId,
      ) {
    return "${baseUrl}showCoachInfo/$coachId";
  }
  static String getUserListUrl(
      String type,
      ) {
    return "${baseUrl}show$type";
  }

  static String deleteMessageUrl(
      int messageID,
      ) {
    return "${baseUrl}deleteMessage/$messageID";
  }

  static String deleteArticleUrl(
      int articleID,
      ) {
    return "${baseUrl}deleteArticle/$articleID";
  }

  static String favArticleUrl(
      int articleID,
      ) {
    return "${baseUrl}makeFavouritre/$articleID";
  }

  static String getCoachArticlesUrl(
      int coachId,) {
    return "${baseUrl}coachArticle/$coachId";
  }

  static String deleteRateUrl(int rateId,) {
    return "${baseUrl}deleteRate?id=/$rateId";
  }

  SharedPreferencesService prefsService = SharedPreferencesService.instance;

  //###################################################################################################//

  static final BaseOptions options = BaseOptions(
    receiveDataWhenStatusError: true,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  );

  static final Dio _clientDio = Dio(options);

  static Duration connectionTimeoutValue = const Duration(seconds: 30);
  static Duration receiveTimeoutValue = const Duration(seconds: 30);

  static Dio get clientDio => _clientDio;

  static void setupInterceptors(BuildContext context) {
    _clientDio.interceptors.add(
      SessionExpiredInterceptor(context),
    );
  }

//###################################################################################################//

  // Auth
  Future<Either<String, Response>> loginApi(
    String phone,
    String password,
  ) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      var response = await _clientDio
          .post(
        loginUrl,
        data: {
          'phoneNumber': phone,
          'password': password,
        },
        options: Options(
          headers: {
                'Accept': 'application/json',
              },
        )
      )
          .timeout(const Duration(seconds: 25));
      log("## $Response login (API handler) : Good");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      showMessage(errorMessage, false);
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> logoutApi() async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;

    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio
          .post(
            logoutUrl,
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 25));
      log("## Response logout : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> initStatusApi() async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio
          .get(initStatusUrl,
              options: Options(
                headers: {
                  'Accept': 'application/json',
                  'Authorization': token,
                },
              ))
          .timeout(const Duration(seconds: 25));
      log("## $Response init status (API handler) : Good");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> activePlayerApi() async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio
          .get(activePlayersUrl,
              options: Options(
                headers: {
                  'Accept': 'application/json',
                  'Authorization': token,
                },
              ))
          .timeout(const Duration(seconds: 25));
      log("## $Response active player (API handler) : Good");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  // Profile
  Future<Either<String, Response>> getProfileInfoApi() async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      int playerId = prefsService.getValue(Cache.userId) ?? 0;
      log(playerId.toString());
      log(getProfileInfoUrl(playerId));
      var response = await _clientDio
          .get(
            getProfileInfoUrl(playerId),
            options: Options(
              headers: {
                'accept': 'application/json',
                'Authorization': token,
              },
            ),
      )
          .timeout(const Duration(seconds: 50));
      log("## Response Profile Info : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getPersonMetricsApi() async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      int playerId = prefsService.getValue(Cache.userId) ?? 0;
      log(playerId.toString());
      log(getPersonMetricsUrl(playerId));
      var response = await _clientDio
          .get(
            getPersonMetricsUrl(playerId),
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      log("## Response Profile Metrics : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> addInfoApi(
      String gender,
      String dob,
      double height,
      double weight,
      double waist,
      double neck,
  ) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        addInfoUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "gender": gender,
          "birthDate": dob,
          "height": height,
          "weight": weight,
          "waistMeasurement": waist,
          "neck": neck,
        },
      ).timeout(const Duration(seconds: 25));
      log("## Response addInfo (API handler) : Good ");
      log("## Response addInfo : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> editMetricsApi(
      // String gender,
      String dob,
      String height,
      String weight,
      String waist,
      String neck,
      ) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        editMetricsUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          // "gender": gender,
          "birthDate": dob,
          "height": height,
          "weight": weight,
          "waistMeasurement": waist,
          "neck": neck,
        },
      ).timeout(const Duration(seconds: 25));
      log("## Response edit metrics (API handler) : Good ");
      log("## Response edit metrics : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> editInfoApi(
    String name,
    String phoneNumber,
    File? image,
  ) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      // int playerId = prefsService.getValue(Cache.userId) ?? 0;
      var response = await _clientDio.post(
        editInfoUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "name": name,
          "phoneNumber": phoneNumber,
          image != null ? 'image' : await MultipartFile.fromFile(image!.path):
              null,
        },
      ).timeout(const Duration(seconds: 25));
      log("## Response edit info (API handler) : Good ");
      log("## Response edit info : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  // Programs
  Future<Either<String, Response>> getAllProgramsApi(String type, int categoryID) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            ApiHelper.allProgramsUrl(type, categoryID),
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      log("## Response get all programs : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getPremiumProgramsApi(
    String type,
  ) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            ApiHelper.premiumProgramsUrl(
              type,
            ),
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      log("## Response get premium programs : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getAllCategoriesApi(String type) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            ApiHelper.allCategoriesUrl(type),
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      log("## Response get all Categories : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getMyProgramsApi(String type) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            ApiHelper.myProgramsUrl(type),
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      log("## Response get my programs : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> addProgramApi(
      String name,
      String type,
      int categoryId,
      String file,
      ) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        addProgramUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "name": name,
          "type": type,
          "categoryId": categoryId,
          'file': await MultipartFile.fromFile("empFace.path", filename: "empCode"),

        },
      ).timeout(const Duration(seconds: 25));
      log("## Response edit Program (API handler) : Good ");
      log("## Response edit Program : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> setProgramApi(
      int programId,
      ) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        setProgramUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "programId": programId,
        },
      ).timeout(const Duration(seconds: 25));
      log("## Response set Program (API handler) : Good ");
      log("## Response set Program : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> unsetProgramApi(
    int programId,
  ) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        unsetProgramUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "programId": programId,
        },
      ).timeout(const Duration(seconds: 25));
      log("## Response unset Program (API handler) : Good ");
      log("## Response unset Program : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> requestProgramApi(
    int coachId,
  ) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        requestProgramUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "coachId": coachId,
        },
      ).timeout(const Duration(seconds: 25));
      log("## Response set Program (API handler) : Good ");
      log("## Response set Program : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> editProgramApi(
      int id,
      String name,
      String type,
      int categoryId,
      String file,
      ) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.put(
        editProgramUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "id": id,
          "name": name,
          "type": type,
          "categoryId": categoryId,
          'file': await MultipartFile.fromFile("empFace.path", filename: "empCode"),

        },
      ).timeout(const Duration(seconds: 25));
      log("## Response editProgram (API handler) : Good ");
      log("## Response editProgram : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> deleteProgramApi(
      int programID,
      ) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        deleteMessageUrl(programID),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "program_Id": programID,
        },
      ).timeout(const Duration(seconds: 25));
      log("## Response delete program (API handler) : Good ");
      log("## Response delete program : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> assignProgramApi(
      int playerId0,
      int playerId1,
      int days,
      String startDate,
      ) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        assignProgramUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "playerid[0]": playerId0,
          "playerid[1]": playerId1,
          "days": days,
          "startDate": startDate

        },
      ).timeout(const Duration(seconds: 25));
      log("## Response edit Program (API handler) : Good ");
      log("## Response edit Program : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  // Progress
  Future<Either<String, Response>> checkInApi(
    String content,
    int day,
  ) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        checkInUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "startTime": content,
          "dayId": day,
        },
      ).timeout(const Duration(seconds: 25));
      log("## Response checkIn (API handler) : Good ");
      log("## Response checkIn : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> checkOutApi( // todo check with backend
      String endTime,
      ) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        checkOutUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "endTime": endTime,
        },
      ).timeout(const Duration(seconds: 25));
      log("## Response checkOut (API handler) : Good ");
      log("## Response checkOut : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getWeeklyProgressApi() async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            weeklyUrl,
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      log("## Response get weekly list : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getMonthlyProgressApi() async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            monthlyUrl,
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      log("## Response get monthly progress : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getProgramProgressApi() async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            monthlyUrl,
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      log("## Response get monthly progress : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  // Coaches
  Future<Either<String, Response>> getUserListApi(String type) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            getUserListUrl(type),
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      log("## Response get ${type}s list : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getCoachInfoApi(int coachId) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            ApiHelper.showCoachInfoUrl(coachId),
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      log("## Response get Coach Info : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getCoachTimeApi(int coachId) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            ApiHelper.showCoachTimeUrl(coachId),
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      log("## Response get Coach Time list : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  // Chats
  Future<Either<String, Response>> getChatMessagesApi(userId) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            ApiHelper.chatMessagesUrl(userId),
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      log("## Response get chat : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getChatsApi() async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            getChatsUrl,
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      log("## Response get chat list : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> sendMessageApi(
      int receiverID,
      String content,
      ) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        sendMessageUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "content": content,
          "receiver_id": receiverID,
        },
      ).timeout(const Duration(seconds: 25));
      log("## Response send message (API handler) : Good ");
      log("## Response send message : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> deleteMessageApi(
      int messageID,
      ) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        deleteMessageUrl(messageID),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "message_id": messageID,
        },
      ).timeout(const Duration(seconds: 25));
      log("## Response delete message (API handler) : Good ");
      log("## Response delete message : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  // Order
  Future<Either<String, Response>> addOrderApi(
      int coachId,
      // int programId,
      ) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        orderProgramUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "coachId": coachId,
          // "programId": programId,
        },
      ).timeout(const Duration(seconds: 25));
      log("## Response add Order (API handler) : Good ");
      log("## Response add Order : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getMyOrderApi() async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            getMyOrderUrl,
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      log("## Response get order : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  // Rates
  Future<Either<String, Response>> setRateApi(
    int coachId,
    double rate,
  ) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        setRateUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "coachId": coachId,
          "rate": rate,
        },
      ).timeout(const Duration(seconds: 25));
      log("## Response set rate (API handler) : Good ");
      log("## Response set rate : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  // Reports
  Future<Either<String, Response>> submitReportApi(
      String content,
      ) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        submitReportUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "text": content,
        },
      ).timeout(const Duration(seconds: 25));
      log("## Response submit Report (API handler) : Good ");
      log("## Response submit Report : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  // Articles
  Future<Either<String, Response>> getArticlesApi() async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            getArticlesUrl,
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      log("## Response get Articles list : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getCoachArticlesApi(int coachId) async {
    //todo edit as backend
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            getCoachArticlesUrl(coachId), // todo url from backend
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      log("## Response get Coach Articles list : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> addArticleApi(
      String title,
      String content,
      ) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        addArticleUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "title": title,
          "content": content,
        },
      ).timeout(const Duration(seconds: 25));
      log("## Response add Article (API handler) : Good ");
      log("## Response add Article : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> deleteArticleApi(
      int articleID,
      ) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        deleteArticleUrl(articleID),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "articleID": articleID,
        },
      ).timeout(const Duration(seconds: 25));
      log("## Response Delete Article (API handler) : Good ");
      log("## Response Delete Article : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> changeArticleFavApi(
      int articleId,
      bool isFav,
      ) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        favArticleUrl(articleId),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          // "title": articleId,
        },
      ).timeout(const Duration(seconds: 25));
      log("## Response $isFav favourite Article (API handler) : Good ");
      log("## Response change fav Article : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  // Search
  Future<Either<String, Response>> searchProgramsApi(
      String content,
      ) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio.post(
        programSearchUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "search_text": content,
        },
      )
          .timeout(const Duration(seconds: 50));
      log("## Response search program : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> searchUsersApi(
      String content,
      ) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio.post(
        userSearchUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "search_text": content,
        },
      )
          .timeout(const Duration(seconds: 50));
      log("## Response search user : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  // Notifications
  Future<Either<String, Response>> getNotificationsApi() async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            getNotificationsUrl,
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      log("## Response get Notifications list : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }


}