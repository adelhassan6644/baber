import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../app/core/api/end_points.dart';
import '../../app/core/error/api_error_handler.dart';
import '../../app/core/error/failures.dart';
import '../../data/dio/dio_client.dart';

class LocationRepo {
  final DioClient dioClient;
  LocationRepo({ required this.dioClient});

  Future<Either<ServerFailure, Response>> getLocations() async {
    try {
      Response response = await dioClient.get( uri: EndPoints.locations);
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<Either<ServerFailure, Response>> setLocation({required String location, }) async {
    try {
      Response response = await dioClient.post(
          uri: EndPoints.setLocation, data: {"location": location, });
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
