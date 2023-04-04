import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/core/api/end_points.dart';
import '../../app/core/error/api_error_handler.dart';
import '../../app/core/error/failures.dart';
import '../../app/core/utils/app_storage_keys.dart';
import '../../data/dio/dio_client.dart';

class AuthRepo {
  final SharedPreferences sharedPreferences;
  final DioClient dioClient;
  AuthRepo({required this.sharedPreferences, required this.dioClient});


  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppStorageKey.isLogin);
  }

  setLoggedIn() {
    sharedPreferences.setBool(AppStorageKey.isLogin, true);
  }

  Future<Either<ServerFailure, Response>> logIn(
      {required String phone, }) async {
    try {
      Response response = await dioClient.post(
          uri: EndPoints.logIn, data: {"phone": phone, });
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }


  Future<Either<ServerFailure, Response>> sendOTP(
      {required String code, }) async {
    try {
      Response response = await dioClient.post(
          uri: EndPoints.sendOTP, data: {"code": code, });
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }


  Future<bool> clearSharedData() async {
    await sharedPreferences.remove(AppStorageKey.userId);
    await sharedPreferences.remove(AppStorageKey.isLogin);
    return true;
  }
}
