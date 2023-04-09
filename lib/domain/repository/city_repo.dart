import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/core/api/end_points.dart';
import '../../app/core/error/api_error_handler.dart';
import '../../app/core/error/failures.dart';
import '../../app/core/utils/app_storage_keys.dart';
import '../../data/dio/dio_client.dart';

class CityRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  CityRepo({required this.dioClient, required this.sharedPreferences});

  Future<Either<ServerFailure, Response>> getCities() async {
    try {
      Response response = await dioClient.get(uri: EndPoints.cities);
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<Either<ServerFailure, Response>> setCity({
    required int cityId,
  }) async {
    try {
      Response response = await dioClient.post(uri: EndPoints.setCity, data: {
        "city_id": cityId,
      });

      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  saveCity({required String cityId,required String cityName,}) {
    sharedPreferences.setString(AppStorageKey.cityName, cityName);
    sharedPreferences.setString(AppStorageKey.cityId, cityId);
  }

  getCityName() {
    if (sharedPreferences.containsKey(AppStorageKey.cityName,)) {
     return sharedPreferences.getString(AppStorageKey.cityName,);
    }
  }
}
