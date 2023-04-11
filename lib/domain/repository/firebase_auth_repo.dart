import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/core/utils/app_storage_keys.dart';
import '../../data/dio/dio_client.dart';

class FirebaseAuthRepo {
  late final SharedPreferences sharedPreferences;
  final DioClient dioClient;
  FirebaseAuthRepo({required this.sharedPreferences,required this.dioClient});

  FirebaseAuth auth = FirebaseAuth.instance;

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppStorageKey.isLogin);
  }

  setLoggedIn() {
    sharedPreferences.setBool(AppStorageKey.isLogin, true);
  }

  getPhone() {
    if( sharedPreferences.containsKey(AppStorageKey.phone,)) {
      return sharedPreferences.getString(AppStorageKey.phone,);
    }
  }

  remember({required String phone}) {
    sharedPreferences.setString(AppStorageKey.phone, phone);
  }
  forget() {
    sharedPreferences.remove(AppStorageKey.phone);
  }

  Future<String?> saveDeviceToken() async {
    // String? _deviceToken;
    // if(Platform.isIOS) {
    //   _deviceToken = await FirebaseMessaging.instance.getAPNSToken();
    // }else {
    //   _deviceToken = await FirebaseMessaging.instance.getToken();
    // }
    //
    // if (_deviceToken != null) {
    //   log('--------Device Token---------- $_deviceToken');
    // }
    // return _deviceToken;
    return "RVmsmxd5dg8v3cS0d48q3nvoFFuaSXuCwZbMU3LCjEren7VWhq";
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



  Future<bool> clearSharedData() async {
    await sharedPreferences.remove(AppStorageKey.cityId);
    await sharedPreferences.remove(AppStorageKey.cityName);
    await sharedPreferences.remove(AppStorageKey.token);
    await sharedPreferences.remove(AppStorageKey.isLogin);
    return true;
  }


}
