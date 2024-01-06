// import 'dart:developer';
// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'dio_exceptions.dart';
//
// class ServiceApi {
//   static String serverUrl = "http://192.168.137.1:8000/api/admins/";
//
//   static String imageUrl = "http://192.168.2.138:800/uploads/images/";
//
//   static String loginUrl = "${serverUrl}login";
//   static String registerAdminUrl = "${serverUrl}register/admin";
//   static String registerDeliveryUrl = "${serverUrl}register/delivery_guy";
//   static String registerBranchOwnerUrl = "${serverUrl}register/branch_owner";
//   static String logoutUrl = "${serverUrl}logout";
//
//   static String getOrAddCitiesUrl = "${serverUrl}cities";
//   static String getOrAddCategoriesUrl = "${serverUrl}categories";
//   static String getOrAddShopsUrl = "${serverUrl}shops";
//   static String getBranchUrl = "${serverUrl}branches/all";
//   static String addBranchUrl = "${serverUrl}branches/add";
//   static String getProductsOfBranchUrl = "${serverUrl}products/all";
//   static String addProductToBranchUrl = "${serverUrl}products/add";
//   static String getOrAddAdsUrl = "${serverUrl}ads";
//   static String getOrAddOffersUrl = "${serverUrl}offers";
//   static String getComplaintsUrl = "${serverUrl}complaints";
//   static String sendNoteUrl = "${serverUrl}notification";
//
//   static String getUsersUrl(
//       String userType,
//       ) {
//     return "$serverUrl$userType";
//   }
//   static String blockUserUrl(
//       int userId,
//       ) {
//     return "${serverUrl}users/$userId/block";
//   }
//
//   static String editUserInfoUrl(
//       String userType,
//       ) {
//     return "$serverUrl$userType";
//   }
//   static String getUserInfoUrl(
//       int userId,
//       ) {
//     return "${serverUrl}user/$userId";
//   }
//   static String editUserPassUrl(
//       String userType,
//       ) {
//     return "$serverUrl$userType";
//   }
//   static String editOrDeleteCityUrl(
//     int cityId,
//   ) {
//     return "${serverUrl}cities/$cityId";
//   }
//
//   static String getOrAddRegionsUrl(
//     int cityId,
//   ) {
//     return "${serverUrl}cities/$cityId/regions";
//   }
//
//   static String editOrDeleteRegionUrl(
//     int cityId,
//     int regionId,
//   ) {
//     return "${serverUrl}cities/$cityId/regions/$regionId";
//   }
//
//   static String editOrDeleteCategoryUrl(
//     int categoryId,
//   ) {
//     return "${serverUrl}categories/$categoryId";
//   }
//
//   static String getOrAddSubCategoryUrl(
//     int categoryId,
//   ) {
//     return "${serverUrl}categories/$categoryId/sub_categories";
//   }
//
//   static String editOrDeleteSubCategoryUrl(
//     int categoryId,
//     int subCategoryId,
//   ) {
//     return "${serverUrl}categories/$categoryId/sub_categories/$subCategoryId";
//   }
//
//   static String editOrDeleteShopUrl(
//     int shopId,
//   ) {
//     return "${serverUrl}shops/$shopId";
//   }
//
//   static String editOrDeleteBranchUrl(
//     int shopId,
//     int branchId,
//   ) {
//     return "${serverUrl}shops/$shopId/branches/$branchId";
//   }
//
//   static String editOrDeleteProductOfBranchUrl(
//       int shopId, int branchId, int productId) {
//     return "${serverUrl}shops/$shopId/branches/$branchId/products/$productId";
//   }
//
//   static String editOrDeleteAdUrl(
//     int adId,
//   ) {
//     return "${serverUrl}ads/$adId";
//   }
//
//   static String editOrDeleteOfferUrl(
//     int offerId,
//   ) {
//     return "${serverUrl}offers/$offerId";
//   }
//   static String getSearchProductsUrl( int pageNumber) {
//     return "${serverUrl}products/all";
//   }
//
//   static String solveComplaintsUrl(
//       int complaintId,
//       ) {
//     return "${serverUrl}complaints/$complaintId/solve";
//   }
//
//   static String getOrEditCityPricesUrl(
//       int cityId,
//       ) {
//     return "${serverUrl}delivery_prices/cities/$cityId";
//   }
//
//   static String getOrEditRegionPricesUrl(
//       int cityId,
//       int regionId,
//       ) {
//     return "${serverUrl}delivery_prices/cities/$cityId/regions/$regionId";
//   }
//
//   static String getOrdersOfBranchUrl(
//       int branchId,
//       ) {
//     return "${serverUrl}orders/$branchId";
//   }
//
// //###################################################################################################//
//
//   BaseOptions options = BaseOptions(
//       receiveDataWhenStatusError: true,
//       connectTimeout: 30 * 1000, // 60 seconds
//       receiveTimeout: 30 * 1000 // 60 seconds
//       );
//
//   final Dio _clientDio = Dio();
//
//   int connectionTimeoutValue = 30 * 1000;
//   int receiveTimeoutValue = 30 * 1000;
//
// //###################################################################################################//
//
//   // Users
//   Future<Either<String, Response>> login(String email, String password,
//       {bool isPhone = false}) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//     late Either<String, Response> result;
//     try {
//       var response = await _clientDio
//           .post(
//             ServiceApi.loginUrl,
//             data: (isPhone != true)
//                 ? {
//                     'email': email,
//                     'password': password,
//                   }
//                 : {
//                     'phone': email,
//                     'password': password,
//                   },
//           )
//           .timeout(const Duration(seconds: 25));
//       // log("## Response login (API handler) : $response");
//       log("## $Response login (API handler) : Good to Go");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> logoutApi() async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//       var response = await _clientDio
//           .get(
//             ServiceApi.logoutUrl,
//             options: Options(
//               headers: {
//                 'Content-Type': 'application/json',
//                 'Authorization': token,
//               },
//             ),
//           )
//           .timeout(const Duration(seconds: 25));
//       log("## Response login : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> registerAdmin(
//     String name,
//     String phone,
//     String email,
//     String password,
//     String passwordConfirm,
//   ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//       var response = await _clientDio.post(
//         ServiceApi.registerAdminUrl,
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             'Authorization': token,
//           },
//         ),
//         data: {
//           "name": name,
//           "email": email,
//           "phone_number": "+963$phone",
//           "password": password,
//           "password_confirmation": passwordConfirm,
//         },
//       ).timeout(const Duration(seconds: 25));
//       log("## Response register (API handler) : Good ");
//       log("## Response register : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> registerBranchOwner(
//     String name,
//     String phone,
//     String email,
//     String password,
//     String passwordConfirm,
//   ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//       var response = await _clientDio.post(
//         ServiceApi.registerBranchOwnerUrl,
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             'Authorization': token,
//           },
//         ),
//         data: {
//           'name': name,
//           'email': email,
//           'phone_number': "+963$phone",
//           'password': password,
//           'password_confirmation': passwordConfirm,
//         },
//       ).timeout(const Duration(seconds: 25));
//       log("## Response register (API handler) : Good ");
//       log("## Response register : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> registerDelivery(
//     String name,
//     String phone,
//     String email,
//     String password,
//     String passwordConfirm,
//   ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//       var response = await _clientDio.post(
//         ServiceApi.registerDeliveryUrl,
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             'Authorization': token,
//           },
//         ),
//         data: {
//           'name': name,
//           'email': email,
//           'phone_number': "+963$phone",
//           'password': password,
//           'password_confirmation': passwordConfirm,
//         },
//       ).timeout(const Duration(seconds: 25));
//       log("## Response register (API handler) : Good ");
//       log("## Response register : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> editUserInfoApi( // should define user Id (body or link ?)
//     String name,
//     String phone,
//     String userType,
//   ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//       var response = await _clientDio.put(
//         ServiceApi.editUserInfoUrl(userType),
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             'Authorization': token,
//           },
//         ),
//         data: {
//           'name': name,
//           'phone_number': "+963$phone",
//         },
//       ).timeout(const Duration(seconds: 25));
//       log("## Response register (API handler) : Good ");
//       log("## Response register : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> editUserPassApi( // should define user Id (body or link ?)
//       String password,
//       String passwordConfirm,
//       String userType,
//       ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//       var response = await _clientDio.put(
//         ServiceApi.editUserPassUrl(userType),
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             'Authorization': token,
//           },
//         ),
//         data: {
//           'password': password,
//           'password_confirmation': passwordConfirm,
//         },
//       ).timeout(const Duration(seconds: 25));
//       log("## Response register (API handler) : Good ");
//       log("## Response register : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> getUsersApi(String userType) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//       var response = await _clientDio
//           .get(
//         getUsersUrl(userType),
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             'Authorization': token,
//           },
//         ),
//       )
//           .timeout(const Duration(seconds: 50));
//       log("## Response get $userType : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> blockUserApi(int userId) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//       var response = await _clientDio
//           .get(
//         blockUserUrl(userId),
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             'Authorization': token,
//           },
//         ),
//       )
//           .timeout(const Duration(seconds: 50));
//       log("## Response block user $userId : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> getUserInfoApi(int userId) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//       var response = await _clientDio
//           .get(
//         getUserInfoUrl(userId),
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             'Authorization': token,
//           },
//         ),
//       )
//           .timeout(const Duration(seconds: 50));
//       log("## Response block user $userId : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   // Cities
//   Future<Either<String, Response>> getCitiesApi() async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio
//           .get(
//             ServiceApi.getOrAddCitiesUrl,
//             options: Options(
//               headers: {
//                 'Content-Type': 'application/json',
//                 'Authorization': token,
//               },
//             ),
//           )
//           .timeout(const Duration(seconds: 50));
//       log("## Response get cites : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> addCitiesApi(
//     String englishName,
//     String arabicName,
//   ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio.post(ServiceApi.getOrAddCitiesUrl,
//           options: Options(
//             headers: {
//               'Content-Type': 'application/json',
//               'Authorization': token,
//             },
//           ),
//           data: {
//             "english_name": englishName,
//             "arabic_name": arabicName,
//           }).timeout(const Duration(seconds: 50));
//       log("## Response add cites : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> editCitiesApi(
//     int cityId,
//     String englishName,
//     String arabicName,
//   ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response =
//           await _clientDio.put(ServiceApi.editOrDeleteCityUrl(cityId),
//               options: Options(
//                 headers: {
//                   'Content-Type': 'application/json',
//                   'Authorization': token,
//                 },
//               ),
//               data: {
//             "english_name": englishName,
//             "arabic_name": arabicName,
//           }).timeout(const Duration(seconds: 50));
//       log("## Response edit cites : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> deleteCitiesApi(
//     int cityId,
//   ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio
//           .delete(
//             ServiceApi.editOrDeleteCityUrl(cityId),
//             options: Options(
//               headers: {
//                 'Content-Type': 'application/json',
//                 'Authorization': token,
//               },
//             ),
//           )
//           .timeout(const Duration(seconds: 50));
//       log("## Response delete cites : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   // Regions
//   Future<Either<String, Response>> getRegionsApi(int cityID) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//       var response = await _clientDio
//           .get(
//             getOrAddRegionsUrl(cityID),
//             options: Options(
//               headers: {
//                 'Content-Type': 'application/json',
//                 'Authorization': token,
//               },
//             ),
//           )
//           .timeout(const Duration(seconds: 50));
//       log("## Response get regions : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> addRegionsApi(
//     int cityID,
//     String englishName,
//     String arabicName,
//   ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response =
//           await _clientDio.post(ServiceApi.getOrAddRegionsUrl(cityID),
//               options: Options(
//                 headers: {
//                   'Content-Type': 'application/json',
//                   'Authorization': token,
//                 },
//               ),
//               data: {
//             "english_name": englishName,
//             "arabic_name": arabicName,
//           }).timeout(const Duration(seconds: 50));
//       log("## Response add regions : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> editRegionsApi(
//     int cityId,
//     int regionId,
//     String englishName,
//     String arabicName,
//   ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio
//           .put(ServiceApi.editOrDeleteRegionUrl(cityId, regionId),
//               options: Options(
//                 headers: {
//                   'Content-Type': 'application/json',
//                   'Authorization': token,
//                 },
//               ),
//               data: {
//             "english_name": englishName,
//             "arabic_name": arabicName,
//           }).timeout(const Duration(seconds: 50));
//       log("## Response edit regions: $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> deleteRegionsApi(
//     int cityId,
//     int regionId,
//   ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio
//           .delete(
//             ServiceApi.editOrDeleteRegionUrl(cityId, regionId),
//             options: Options(
//               headers: {
//                 'Content-Type': 'application/json',
//                 'Authorization': token,
//               },
//             ),
//           )
//           .timeout(const Duration(seconds: 50));
//       log("## Response delete region : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   // Categories
//   Future<Either<String, Response>> getCategoriesApi() async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//       var response = await _clientDio
//           .get(
//             getOrAddCategoriesUrl,
//             options: Options(
//               headers: {
//                 'Content-Type': 'application/json',
//                 'Authorization': token,
//               },
//             ),
//           )
//           .timeout(const Duration(seconds: 50));
//       log("## Response get categories : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> addCategoriesApi(
//     String englishName,
//     String arabicName,
//   ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio.post(ServiceApi.getOrAddCategoriesUrl,
//           options: Options(
//             headers: {
//               'Content-Type': 'application/json',
//               'Authorization': token,
//             },
//           ),
//           data: {
//             "english_name": englishName,
//             "arabic_name": arabicName,
//           }).timeout(const Duration(seconds: 50));
//       log("## Response add category : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> editCategoriesApi(
//     int categoryId,
//     String englishName,
//     String arabicName,
//   ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio.put(
//           ServiceApi.editOrDeleteCategoryUrl(
//             categoryId,
//           ),
//           options: Options(
//             headers: {
//               'Content-Type': 'application/json',
//               'Authorization': token,
//             },
//           ),
//           data: {
//             "english_name": englishName,
//             "arabic_name": arabicName,
//           }).timeout(const Duration(seconds: 50));
//       log("## Response edit category: $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> deleteCategoriesApi(
//     int categoryId,
//   ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio
//           .delete(
//             ServiceApi.editOrDeleteCategoryUrl(categoryId),
//             options: Options(
//               headers: {
//                 'Content-Type': 'application/json',
//                 'Authorization': token,
//               },
//             ),
//           )
//           .timeout(const Duration(seconds: 50));
//       log("## Response delete category : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   // Sub-category
//   Future<Either<String, Response>> getSubCategoriesApi(int categoryId) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//       var response = await _clientDio
//           .get(
//             getOrAddSubCategoryUrl(categoryId),
//             options: Options(
//               headers: {
//                 'Content-Type': 'application/json',
//                 'Authorization': token,
//               },
//             ),
//           )
//           .timeout(const Duration(seconds: 50));
//       log("## Response get sub-categories : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> addSubCategoriesApi(
//     int categoryId,
//     String englishName,
//     String arabicName,
//   ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response =
//           await _clientDio.post(ServiceApi.getOrAddSubCategoryUrl(categoryId),
//               options: Options(
//                 headers: {
//                   'Content-Type': 'application/json',
//                   'Authorization': token,
//                 },
//               ),
//               data: {
//             "english_name": englishName,
//             "arabic_name": arabicName,
//           }).timeout(const Duration(seconds: 50));
//       log("## Response add subCategory : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> editSubCategoriesApi(
//     int categoryId,
//     int subCategoryId,
//     String englishName,
//     String arabicName,
//   ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio
//           .put(ServiceApi.editOrDeleteSubCategoryUrl(categoryId, subCategoryId),
//               options: Options(
//                 headers: {
//                   'Content-Type': 'application/json',
//                   'Authorization': token,
//                 },
//               ),
//               data: {
//             "english_name": englishName,
//             "arabic_name": arabicName,
//           }).timeout(const Duration(seconds: 50));
//       log("## Response edit subCategory: $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> deleteSubCategoriesApi(
//     int categoryId,
//     int subCategoryId,
//   ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio
//           .delete(
//             ServiceApi.editOrDeleteSubCategoryUrl(categoryId, subCategoryId),
//             options: Options(
//               headers: {
//                 'Content-Type': 'application/json',
//                 'Authorization': token,
//               },
//             ),
//           )
//           .timeout(const Duration(seconds: 50));
//       log("## Response delete sub-categories : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   // Shops
//   Future<Either<String, Response>> getShopsApi() async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//       var response = await _clientDio
//           .get(
//             getOrAddShopsUrl,
//             options: Options(
//               headers: {
//                 'Content-Type': 'application/json',
//                 'Authorization': token,
//               },
//             ),
//           )
//           .timeout(const Duration(seconds: 50));
//       log("## Response get shops : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> addShopsApi(
//       String shopName, String image) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio.post(ServiceApi.getOrAddShopsUrl,
//           options: Options(
//             headers: {
//               'Content-Type': 'application/json',
//               'Authorization': token,
//             },
//           ),
//           data: {
//             "name": shopName,
//             "image": image,
//           }).timeout(const Duration(seconds: 50));
//       log("## Response add shop : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> editShopsApi(
//       int shopId, String shopName, ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response =
//           await _clientDio.put(ServiceApi.editOrDeleteShopUrl(shopId),
//               options: Options(
//                 headers: {
//                   'Content-Type': 'application/json',
//                   'Authorization': token,
//                 },
//               ),
//               data: {
//             "name": shopName,
//           }).timeout(const Duration(seconds: 50));
//       log("## Response edit shop: $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> editShopImageApi(
//       int shopId,
//       String image,
//       ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio
//           .put(ServiceApi.editOrDeleteShopUrl(shopId),
//           options: Options(
//             headers: {
//               'Content-Type': 'application/json',
//               'Authorization': token,
//             },
//           ),
//           data: {
//             "image": image,
//           }).timeout(const Duration(seconds: 50));
//       log("## Response add branch : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> deleteShopsApi(
//     int shopId,
//   ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio
//           .delete(
//             ServiceApi.editOrDeleteShopUrl(shopId),
//             options: Options(
//               headers: {
//                 'Content-Type': 'application/json',
//                 'Authorization': token,
//               },
//             ),
//           )
//           .timeout(const Duration(seconds: 50));
//       log("## Response delete shop : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   // Branches
//   Future<Either<String, Response>> getBranchesApi(int shopId) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//       var response = await _clientDio
//           .post(
//         getBranchUrl,
//             options: Options(
//               headers: {
//                 'Content-Type': 'application/json',
//                 'Authorization': token,
//               },
//             ),
//         data: {
//           "shop_id": shopId,
//         }
//           )
//           .timeout(const Duration(seconds: 50));
//       log("## Response get branches : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> addBranchesApi(
//     BranchModel branchModel,
//     String ownerEmail,
//   ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio
//           .post(ServiceApi.addBranchUrl,
//               options: Options(
//                 headers: {
//                   'Content-Type': 'application/json',
//                   'Authorization': token,
//                 },
//               ),
//               data: {
//             "shop_id": branchModel.shopId,
//             "branch_owner_email": ownerEmail,
//             "name": branchModel.name,
//             "image": branchModel.imgUrl,
//             "city_id": branchModel.cityId,
//             "region_id": branchModel.regionId,
//             "address_details": branchModel.addressDetails,
//           }).timeout(const Duration(seconds: 50));
//       log("## Response add branch : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> editBranchImageApi(
//       int branchId,
//       String image,
//       ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio
//           .put(ServiceApi.editOrDeleteBranchUrl(branchId, branchId), //todo do we need shopId ?
//           options: Options(
//             headers: {
//               'Content-Type': 'application/json',
//               'Authorization': token,
//             },
//           ),
//           data: {
//             "image": image,
//           }).timeout(const Duration(seconds: 50));
//       log("## Response add branch : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> editBranchesApi(
//       BranchModel branchModel) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio.put(
//           ServiceApi.editOrDeleteBranchUrl(branchModel.shopId, branchModel.id),
//           options: Options(
//             headers: {
//               'Content-Type': 'application/json',
//               'Authorization': token,
//             },
//           ),
//           data: {
//             "branch_owner_email": branchModel.branchOwnerEmail,
//             "name": branchModel.name,
//             "image": branchModel.imgUrl,
//             "city_id": branchModel.cityId,
//             "region_id": branchModel.regionId,
//             "address_details": branchModel.addressDetails,
//           }).timeout(const Duration(seconds: 50));
//       log("## Response edit branch: $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> deleteBranchesApi(
//     int shopId,
//     int branchId,
//   ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio
//           .delete(
//             ServiceApi.editOrDeleteBranchUrl(shopId, branchId),
//             options: Options(
//               headers: {
//                 'Content-Type': 'application/json',
//                 'Authorization': token,
//               },
//             ),
//           )
//           .timeout(const Duration(seconds: 50));
//       log("## Response delete branch : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   // Products
//   Future<Either<String, Response>> getProductsApi(
//     int branchId,
//   ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//       var response = await _clientDio
//           .post(
//             getProductsOfBranchUrl,
//             options: Options(
//               headers: {
//                 'Content-Type': 'application/json',
//                 'Authorization': token,
//               },
//             ),
//         data: {
//               "branch_id": branchId,
//               "order_by": false,
//         }
//           )
//           .timeout(const Duration(seconds: 50));
//       log("## Response get products : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> getSearchProductsOfBranch( String word, { int branchId = 0, required bool inStock, int pageNumber = 1} ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//     // int cityID = prefs.getInt(Constants.cityID) ?? 1;
//     // search for branches of city
//     late Either<String, Response> result;
//     try {
//       log("searching...");
//       String token = prefs.getString(Cache.token) ?? "";
//       var response = await _clientDio
//           .post(
//         getSearchProductsUrl(pageNumber, ),
//         options: Options(
//           headers: {
//             'Authorization': token,
//             'Content-Type': 'application/json',
//           },
//         ),
//         data: {
//           'search': word,
//           'in_stock': inStock,
//            (branchId != 0) ? 'branch_id': branchId : null,
//         },
//       )
//           .timeout(const Duration(seconds: 50));
//       log("## Response products : $response");
//       result = Right(response);
//       log("Api is OK");
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> addProductsApi(ProductModel product) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio.post(
//           ServiceApi.addProductToBranchUrl,
//           options: Options(
//             headers: {
//               'Content-Type': 'application/json',
//               'Authorization': token,
//             },
//           ),
//           data: {
//             "name": product.name,
//             "category_id": product.categoryId,
//             "sub_category_id": product.subCategoryId,
//             "description": product.description,
//             "price": product.price,
//             "quantity": product.quantity,
//             "image": product.imgUrl,
//           }).timeout(const Duration(seconds: 50));
//       log("## Response add product : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> editProductsApi(ProductModel product) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio.put(
//           ServiceApi.editOrDeleteBranchUrl(
//               product.branch.shopId, product.branchId),
//           options: Options(
//             headers: {
//               'Content-Type': 'application/json',
//               'Authorization': token,
//             },
//           ),
//           data: {
//             "id": product.id,
//             "name": product.name,
//             "category_id": product.categoryId,
//             "sub_category_id": product.subCategoryId,
//             "description": product.description,
//             "price": product.price,
//             "quantity": product.quantity,
//           }).timeout(const Duration(seconds: 50));
//       log("## Response edit product: $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> editProductsImageApi(
//       int shopId, int branchId, int productId, var image) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio.put(
//           ServiceApi.editOrDeleteProductOfBranchUrl(shopId, branchId, productId),
//           options: Options(
//             headers: {
//               'Content-Type': 'application/json',
//               'Authorization': token,
//             },
//           ),
//           data: {
//             "image": image,
//           }).timeout(const Duration(seconds: 50));
//       log("## Response edit product: $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> deleteProductsApi(
//       int shopId, int branchId, int productId) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio
//           .delete(
//             ServiceApi.editOrDeleteProductOfBranchUrl(
//                 shopId, branchId, productId),
//             options: Options(
//               headers: {
//                 'Content-Type': 'application/json',
//                 'Authorization': token,
//               },
//             ),
//           )
//           .timeout(const Duration(seconds: 50));
//       log("## Response delete product : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   // Ads
//   Future<Either<String, Response>> getAdsApi() async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//       var response = await _clientDio
//           .get(
//             getOrAddAdsUrl,
//             options: Options(
//               headers: {
//                 'Content-Type': 'application/json',
//                 'Authorization': token,
//               },
//             ),
//           )
//           .timeout(const Duration(seconds: 50));
//       log("## Response get Ads : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> addAdsApi(
//       String name, String expiryDate, String image) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio.post(ServiceApi.getOrAddAdsUrl,
//           options: Options(
//             headers: {
//               'Content-Type': 'application/json',
//               'Authorization': token,
//             },
//           ),
//           data: {
//             "name": name,
//             "expiry_date": expiryDate,
//             "image": image,
//           }).timeout(const Duration(seconds: 50));
//       log("## Response add shop : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> sendNotificationsApi(
//        String text) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio.post(ServiceApi.sendNoteUrl,
//           options: Options(
//             headers: {
//               'Content-Type': 'application/json',
//               'Authorization': token,
//             },
//           ),
//           data: {
//             "text": text,
//           }).timeout(const Duration(seconds: 50));
//       log("## Response add shop : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> editAdsApi(
//     int id,
//     String info,
//     String expiryDate,
//   ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio.put(ServiceApi.editOrDeleteAdUrl(id),
//           options: Options(
//             headers: {
//               'Content-Type': 'application/json',
//               'Authorization': token,
//             },
//           ),
//           data: {
//             "info": info,
//             "expiry_date": expiryDate,
//           }).timeout(const Duration(seconds: 50));
//       log("## Response edit ads: $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> deleteAdsApi(
//     int adId,
//   ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio
//           .delete(
//             ServiceApi.editOrDeleteAdUrl(adId),
//             options: Options(
//               headers: {
//                 'Content-Type': 'application/json',
//                 'Authorization': token,
//               },
//             ),
//           )
//           .timeout(const Duration(seconds: 50));
//       log("## Response delete ads : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   // Offers
//   Future<Either<String, Response>> getOffersApi() async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//       var response = await _clientDio
//           .get(
//             getOrAddOffersUrl,
//             options: Options(
//               headers: {
//                 'Content-Type': 'application/json',
//                 'Authorization': token,
//               },
//             ),
//           )
//           .timeout(const Duration(seconds: 50));
//       log("## Response get Offers : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> addOffersApi({
//     required String image,
//     required int shopId,
//     required int branchId,
//     required String title,
//     required String expiryDate,
//     required int percentage,
//   }) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio.post(ServiceApi.getOrAddOffersUrl,
//           options: Options(
//             headers: {
//               'Content-Type': 'application/json',
//               'Authorization': token,
//             },
//           ),
//           data: {
//             "title": title,
//             "shop_id": shopId,
//             "expiry_date": expiryDate,
//             "percentage": percentage,
//             "image": image,
//             (branchId > 0) ? "branch_id": branchId : null, // when isBranchOffer is false: don't send branch ID
//           }).timeout(const Duration(seconds: 50));
//       log("## Response add offer : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> editOffersApi(OfferModel offerModel) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response =
//           await _clientDio.put(ServiceApi.editOrDeleteOfferUrl(offerModel.id),
//               options: Options(
//                 headers: {
//                   'Content-Type': 'application/json',
//                   'Authorization': token,
//                 },
//               ),
//               data: {
//                 "title": offerModel.title,
//                 "shop_id": offerModel.shopId,
//                 "expiry_date": offerModel.expiryDate,
//                 "percentage": offerModel.percentage,
//                 (offerModel.branchId > 0) ? "branch_id": offerModel.branchId : null,
//               }).timeout(const Duration(seconds: 50));
//       log("## Response edit offer: $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> editOfferImageApi(
//       int offerId,
//       String image,
//       ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio
//           .put(ServiceApi.editOrDeleteOfferUrl(offerId),
//           options: Options(
//             headers: {
//               'Content-Type': 'application/json',
//               'Authorization': token,
//             },
//           ),
//           data: {
//             "image": image,
//           }).timeout(const Duration(seconds: 50));
//       log("## Response add branch : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> deleteOffersApi(
//     int offerId,
//   ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio
//           .delete(
//             ServiceApi.editOrDeleteOfferUrl(offerId),
//             options: Options(
//               headers: {
//                 'Content-Type': 'application/json',
//                 'Authorization': token,
//               },
//             ),
//           )
//           .timeout(const Duration(seconds: 50));
//       log("## Response delete Offers : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   // Complaints
//   Future<Either<String, Response>> getComplaintApi() async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio.get(ServiceApi.getComplaintsUrl,
//           options: Options(
//             headers: {
//               'Content-Type': 'application/json',
//               'Authorization': token,
//             },
//           ),
//       ).timeout(const Duration(seconds: 50));
//       log("## Response add cites : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> solveComplaintApi(int complaintId) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//
//       var response = await _clientDio.get(ServiceApi.solveComplaintsUrl(complaintId),
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             'Authorization': token,
//           },
//         ),
//       ).timeout(const Duration(seconds: 50));
//       log("## Response add cites : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   // Deliveries
//
//   Future<Either<String, Response>> getDeliveryCitiesApi(
//       int cityId,
//       ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//     late Either<String, Response> result;
//
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//       var response = await _clientDio.get(ServiceApi.getOrEditCityPricesUrl(cityId),
//           options: Options(
//             headers: {
//               'Content-Type': 'application/json',
//               'Authorization': token,
//             },
//           ),)
//           .timeout(const Duration(seconds: 50));
//       log("## Response get delivery cities: $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> editDeliveryCitiesApi(
//       int cityId, List<Map<String, dynamic>> updatedCityPrices,
//       ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//     late Either<String, Response> result;
//     log(updatedCityPrices.toString());
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//       var response = await _clientDio.put(ServiceApi.getOrEditCityPricesUrl(cityId),
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             'Authorization': token,
//           },
//         ),
//         data: updatedCityPrices
//       )
//           .timeout(const Duration(seconds: 50));
//       log("## Response edit delivery cities: $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> getDeliveryRegionsApi(
//       int cityId,
//       int regionId,
//       ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//     late Either<String, Response> result;
//
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//       var response = await _clientDio.get(ServiceApi.getOrEditRegionPricesUrl(cityId, regionId),
//           options: Options(
//             headers: {
//               'Content-Type': 'application/json',
//               'Authorization': token,
//             },
//           ),)
//           .timeout(const Duration(seconds: 50));
//       log("## Response get delivery regions: $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   Future<Either<String, Response>> editDeliveryRegionsApi(
//       int cityId, int regionId, List<Map<String, dynamic>> updatedRegionPrices,
//       ) async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//     late Either<String, Response> result;
//     log(updatedRegionPrices.toString());
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//       var response = await _clientDio.put(ServiceApi.getOrEditRegionPricesUrl(cityId, regionId),
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             'Authorization': token,
//           },
//         ),
//         data: updatedRegionPrices
//       )
//           .timeout(const Duration(seconds: 50));
//       log("## Response edit delivery cities: $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
//   // Orders
//   Future<Either<String, Response>> getOrdersApi() async {
//     _clientDio.options.connectTimeout = connectionTimeoutValue;
//     _clientDio.options.receiveTimeout = receiveTimeoutValue;
//     late Either<String, Response> result;
//     try {
//       String token = prefs.getString(Cache.token) ?? "";
//       var response = await _clientDio
//           .get(
//         getOrdersOfBranchUrl(0),
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             'Authorization': token,
//           },
//         ),
//       )
//           .timeout(const Duration(seconds: 50));
//       log("## Response get Orders : $response");
//       result = Right(response);
//       return result;
//     } on DioError catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       log("## error message : $errorMessage");
//       result = Left(errorMessage);
//       return result;
//     }
//   }
//
// //***********************************************************************************************************
// }
