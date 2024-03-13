import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym/components/widgets/snack_bar.dart';
import 'package:gym/utils/helpers/api/session_expired_interceptor.dart';
import 'package:gym/utils/helpers/cache.dart';
import 'package:gym/utils/helpers/api/dio_exceptions.dart';

import 'api_constants.dart';

class ApiHelper {


  SharedPreferencesService prefsService = SharedPreferencesService.instance;

  //###################################################################################################//

  static final BaseOptions options = BaseOptions(
    receiveDataWhenStatusError: true,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  );

  static final Dio _clientDio = Dio(options);

  // static Duration connectionTimeoutValue = const Duration(seconds: 30);
  // static Duration receiveTimeoutValue = const Duration(seconds: 30);

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
    late Either<String, Response> result;
    try {
      var response = await _clientDio
          .post(ApiConstants.loginUrl,
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

    late Either<String, Response> result;

    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio
          .post(
            ApiConstants.logoutUrl,
            options: Options(
              headers: {
                'Accept': 'application/json',
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
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio
          .get(ApiConstants.initStatusUrl,
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
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio
          .get(ApiConstants.activePlayersUrl,
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

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      int playerId = prefsService.getValue(Cache.userId) ?? 0;
      log(playerId.toString());
      log(ApiConstants.getProfileInfoUrl(playerId));
      var response = await _clientDio
          .get(
            ApiConstants.getProfileInfoUrl(playerId),
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

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      int playerId = prefsService.getValue(Cache.userId) ?? 0;
      log(playerId.toString());
      log(ApiConstants.getPersonMetricsUrl(playerId));
      var response = await _clientDio
          .get(
            ApiConstants.getPersonMetricsUrl(playerId),
            options: Options(
              headers: {
                'Accept': 'application/json',
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

  Future<Either<String, Response>> addMetricsApi(
    String gender,
    String? dob,
    double? height,
    double? weight,
    double? waist,
    double? neck,
  ) async {
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        ApiConstants.addInfoUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
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

  Future<Either<String, Response>> editMetricsApi(String gender,
      String dob,
      String height,
      String weight,
      String waist,
      String neck,
      ) async {
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        ApiConstants.editMetricsUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
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
    late Either<String, Response> result;
    var formData = FormData.fromMap({
      "name": name,
      "phoneNumber": phoneNumber,
      'image': (image != null)
          ? await MultipartFile.fromFile(
              image.path,
            )
          : null,
    });
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        ApiConstants.editInfoUrl,
        options: Options(
          headers: {
                'Accept': 'application/json',
                'Authorization': token,
          },
        ),
            data: formData,
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

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      String url = ApiConstants.allProgramsUrl(type, categoryID);
      log(url);
      var response = await _clientDio
          .get(
            ApiConstants.allProgramsUrl(type, categoryID),
            options: Options(
              headers: {
                'Accept': 'application/json',
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

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.premiumProgramsUrl(
              type,
            ),
            options: Options(
              headers: {
                'Accept': 'application/json',
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

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.allCategoriesUrl(type),
            options: Options(
              headers: {
                'Accept': 'application/json',
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

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.myProgramsUrl(type),
            options: Options(
              headers: {
                'Accept': 'application/json',
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
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        ApiConstants.addProgramUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
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
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        ApiConstants.setProgramUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "program_id": programId,
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
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        ApiConstants.setProgramUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "program_id": programId,
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

  Future<Either<String, Response>> requestPremiumProgramApi(
    int coachId,
    String genre,
  ) async {
    late Either<String, Response> result;
    log('$genre for $coachId');
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        ApiConstants.requestProgramUrl(coachId),
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "type": (genre == 'sport') ? 'sport' : 'food',
        },
      ).timeout(const Duration(seconds: 25));
      log("## Response request premium Program (API handler) : Good ");
      log("## Response request premium Program : $response");
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
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.put(
        ApiConstants.editProgramUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
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
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        ApiConstants.deleteMessageUrl(programID),
        options: Options(
          headers: {
            'Accept': 'application/json',
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
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        ApiConstants.assignProgramUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
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
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        ApiConstants.checkInUrl,
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
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        ApiConstants.checkOutUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
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

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.weeklyUrl,
            options: Options(
              headers: {
                'Accept': 'application/json',
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

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.monthlyUrl,
            options: Options(
              headers: {
                'Accept': 'application/json',
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

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.monthlyUrl,
            options: Options(
              headers: {
                'Accept': 'application/json',
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

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.getUserListUrl(type),
            options: Options(
              headers: {
                'Accept': 'application/json',
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

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.showCoachInfoUrl(coachId),
            options: Options(
              headers: {
                'Accept': 'application/json',
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

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.showCoachTimeUrl(coachId),
            options: Options(
              headers: {
                'Accept': 'application/json',
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

  Future<Either<String, Response>> requestCoachApi(
    int coachId,
  ) async {
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        ApiConstants.requestCoachUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': token,
          },
        ),
        data: {
          "coachId": coachId,
        },
      ).timeout(const Duration(seconds: 25));
      log("## Response Request Coach (API handler) : Good ");
      log("## Response Request Coach: $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> unsetCoachApi(int coachId) async {
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.unSetCoach(coachId),
            options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      log("## Response unset Coach : $response");
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

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.chatMessagesUrl(userId),
            options: Options(
              headers: {
                'Accept': 'application/json',
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

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.getChatsUrl,
            options: Options(
              headers: {
                'Accept': 'application/json',
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
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        ApiConstants.sendMessageUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
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
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        ApiConstants.deleteMessageUrl(messageID),
        options: Options(
          headers: {
            'Accept': 'application/json',
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

  Future<Either<String, Response>> cancelOrderApi(
    int orderId,
  ) async {
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
            ApiConstants.cancelOrderUrl(orderId),
            options: Options(
          headers: {
                'Accept': 'application/json',
                'Authorization': token,
          },
        ),
      ).timeout(const Duration(seconds: 25));
      log("## Response cancel Order (API handler) : Good ");
      log("## Response cancel Order : $response");
      result = Right(response);
      return result;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      log("## error message : $errorMessage");
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> getMyOrderApi(String genre) async {
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.getMyOrderUrl(genre),
            options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': token,
              },
            ),
          )
          .timeout(const Duration(seconds: 50));
      log("## Response get order $genre : $response");
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
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        ApiConstants.setRateUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
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
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        ApiConstants.submitReportUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
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

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.getArticlesUrl,
            options: Options(
              headers: {
                'Accept': 'application/json',
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

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.getCoachArticlesUrl(coachId), // todo url from backend
            options: Options(
              headers: {
                'Accept': 'application/json',
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
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        ApiConstants.addArticleUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
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
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        ApiConstants.deleteArticleUrl(articleID),
        options: Options(
          headers: {
            'Accept': 'application/json',
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
    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";
      var response = await _clientDio.post(
        ApiConstants.favArticleUrl(articleId),
        options: Options(
          headers: {
            'Accept': 'application/json',
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

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio.post(
        ApiConstants.programSearchUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
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

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio.post(
        ApiConstants.userSearchUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
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

    late Either<String, Response> result;
    try {
      String token = prefsService.getValue(Cache.token) ?? "";

      var response = await _clientDio
          .get(
            ApiConstants.getNotificationsUrl,
            options: Options(
              headers: {
                'Accept': 'application/json',
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