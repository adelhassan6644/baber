import 'package:baber/app/core/api/end_points.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/core/error/api_error_handler.dart';
import '../../app/core/error/failures.dart';
import '../../app/core/utils/app_storage_keys.dart';
import '../../data/dio/dio_client.dart';

class HomeRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  HomeRepo({required this.dioClient,required this.sharedPreferences});

  Future<Either<ServerFailure, Response>> getHomeBanners() async {
      try {
        Response response = await dioClient.get( uri: EndPoints.banners);
        if (response.statusCode == 200) {
          return Right(response);
        } else {
          return left(ServerFailure(response.data['message']));
        }
      } catch (error) {
        return left(ServerFailure(ApiErrorHandler.getMessage(error)));
      }
  }

  Future<Either<ServerFailure, Response>> getHomeCategories() async {
      try {
        Response response = await dioClient.get( uri: EndPoints.categories);
        if (response.statusCode == 200) {
          return Right(response);
        } else {
          return left(ServerFailure(response.data['message']));
        }
      } catch (error) {
        return left(ServerFailure(ApiErrorHandler.getMessage(error)));
      }
  }

  Future<Either<ServerFailure, Response>> getHomeVendors() async {
      try {
        Response response = await dioClient.get( uri: EndPoints.homeVendors,
            queryParameters: {
              "city_id":sharedPreferences.getString(AppStorageKey.cityId),
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

}