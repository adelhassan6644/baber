import 'package:baber/data/dio/dio_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../app/core/api/end_points.dart';
import '../../app/core/error/api_error_handler.dart';
import '../../app/core/error/failures.dart';

class OrderRepo {
  DioClient dioClient;
  OrderRepo({required this.dioClient});

  Future<Either<ServerFailure, Response>> getOrderHistory() async {
    try {
      Response response = await dioClient.get(uri: EndPoints.orders);
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
