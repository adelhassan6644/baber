import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../app/core/api/end_points.dart';
import '../../app/core/error/api_error_handler.dart';
import '../../app/core/error/failures.dart';
import '../../data/dio/dio_client.dart';

class ContactRepo{
  final DioClient dioClient;
  ContactRepo({ required this.dioClient});

  Future<Either<ServerFailure, Response>> contact({required String message}) async {
    try {
      Response response = await dioClient.post(
          uri: EndPoints.contact, data: {"message": message,});
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