import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

  getPhone() {
    if (sharedPreferences.containsKey(
      AppStorageKey.phone,
    )) {
      return sharedPreferences.getString(
        AppStorageKey.phone,
      );
    }
  }

  remember({required String phone}) {
    sharedPreferences.setString(AppStorageKey.phone, phone);
  }

  forget() {
    sharedPreferences.remove(AppStorageKey.phone);
  }

  Future<String?> saveDeviceToken() async {
    String? deviceToken;
    if (Platform.isIOS) {
      deviceToken = await FirebaseMessaging.instance.getAPNSToken();
    } else {
      deviceToken = await FirebaseMessaging.instance.getToken();
    }

    if (deviceToken != null) {
      log('--------Device Token---------- $deviceToken');
    }
    return deviceToken;
  }

  // Future<Either<ServerFailure, Response>> subscribeToTopic() async {
  //   try {
  //     FirebaseMessaging.instance.subscribeToTopic(EndPoints.topic);
  //     Response response = await dioClient.post(
  //       data: {"_method": "put", "cm_firebase_token": await saveDeviceToken()},
  //       uri: EndPoints.,
  //     );
  //   else {
  //   return left(ServerFailure(response.data['message']));
  //   }
  //   } catch (error) {
  //   return left(ServerFailure(ApiErrorHandler.getMessage(error)));
  //   }
  // }

  Future<void> saveUserToken({required String token}) async {
    try {
      dioClient.updateHeader(token: token);
      await sharedPreferences.setString(AppStorageKey.token, token);
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<ServerFailure, Response>> logIn({required String phone}) async {
    try {
      Response response = await dioClient.post(
          uri: EndPoints.logIn,
          data: {"phone": phone, "device_token": await saveDeviceToken()});

      if (response.statusCode == 200) {
        dioClient.updateHeader(token: response.data['data']["api_token"]);

        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<Either<ServerFailure, Response>> verifyPhone({
    required String phone,
    required String code,
  }) async {
    try {
      Response response = await dioClient.post(
          uri: EndPoints.verifyPhone, data: {"phone": phone, "otp": code});
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
    await sharedPreferences.remove(AppStorageKey.cityId);
    await sharedPreferences.remove(AppStorageKey.cityName);
    await sharedPreferences.remove(AppStorageKey.token);
    await sharedPreferences.remove(AppStorageKey.isLogin);
    return true;
  }
}
