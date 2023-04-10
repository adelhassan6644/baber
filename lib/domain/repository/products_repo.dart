import 'package:baber/app/core/api/end_points.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../app/core/error/api_error_handler.dart';
import '../../app/core/error/failures.dart';
import '../../data/dio/dio_client.dart';

class ProductsRepo {
  final DioClient dioClient;

  ProductsRepo({required this.dioClient});

  Future<Either<ServerFailure, Response>> getProductsByMenu({required String menuId}) async {
    try {
      Response response = await dioClient.get(uri: "${EndPoints.products}/$menuId");
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
