import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gym/main.dart';
import 'package:gym/utils/helpers/Cache.dart';
import 'dio_exceptions.dart';

class ApiHelper{
  static String serverUrl = "http://192.168.2.138:800/api/";
  static String imageUrl = "http://192.168.2.138:800/uploads/images/";

  static String loginUrl = "${serverUrl}login";
  static String addInfoUrl = "${serverUrl}addInfo";

  //###################################################################################################//

  BaseOptions options = BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(milliseconds: 30 * 1000), // 30 seconds
      receiveTimeout: const Duration(milliseconds: 30 * 1000) // 30 seconds
  );

  final Dio _clientDio = Dio();

  Duration connectionTimeoutValue = const Duration(milliseconds: 30 * 1000);
  Duration receiveTimeoutValue = const Duration(milliseconds: 30 * 1000);

//###################################################################################################//

  Future<Either<String, Response>> loginApi(String phone, String password,
      {bool isPhone = false}) async {
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
//                 'Authorization': token,
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
      result = Left(errorMessage);
      return result;
    }
  }

  Future<Either<String, Response>> addInfoApi(
      String gender,
      // String dob,
      double height,
      double weight,
      double waist,
      double neck,
  ) async {
    _clientDio.options.connectTimeout = connectionTimeoutValue;
    _clientDio.options.receiveTimeout = receiveTimeoutValue;
    late Either<String, Response> result;
    try {
      String token = prefs.getString(Cache.token) ?? "";
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
          // "age": dob,
          "height": height,
          "weight": weight,
          "waistMeasurement": waist,
          "neck": neck,
        },
      ).timeout(const Duration(seconds: 25));
      log("## Response addInfo (API handler) : Good ");
      log("## Response register : $response");
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