import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/core/api/end_points.dart';
import '../../app/core/error/api_error_handler.dart';
import '../../app/core/error/failures.dart';
import '../../app/core/utils/app_storage_keys.dart';
import '../../data/dio/dio_client.dart';
import '../../data/model/item_model.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  final DioClient dioClient;

  CartRepo({required this.dioClient,required this.sharedPreferences});

  List<ItemModel> getCartList() {
    List<String>? cart = [];
    if (sharedPreferences.containsKey(AppStorageKey.cartItems)) {
      cart = sharedPreferences.getStringList(AppStorageKey.cartItems);
    }

    List<ItemModel> items = [];
    cart?.forEach((item) => items.add(ItemModel.fromJson(jsonDecode(item))));
    return items;
  }

  void saveNewItems(List<ItemModel> items) {
    List<String> cart = [];
    for (var item in items) {
      cart.add(jsonEncode(item.toJson()));
    }
    sharedPreferences.setStringList(AppStorageKey.cartItems, cart);
  }

  Future<Either<ServerFailure, Response>> checkOut({required data,}) async {
    try {
      Response response = await dioClient.post(uri: EndPoints.checkOut, data: data);
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
