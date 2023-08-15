import 'package:baber/data/model/orders_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../app/core/error/api_error_handler.dart';
import '../app/core/error/failures.dart';
import '../app/core/utils/app_snack_bar.dart';
import '../app/core/utils/color_resources.dart';
import '../domain/repository/orders_repo.dart';

class OrdersProvider extends ChangeNotifier {
  final OrderRepo orderRepo;
  OrdersProvider({required this.orderRepo});

  OrdersModel? model;

  bool isLoading = false;

  getOrders() async {
    try {
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await orderRepo.getOrderHistory();
      response.fold((fail) {
        isLoading = false;
        notifyListeners();
      }, (success) {
        model = OrdersModel.fromJson(success.data);
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoading = false;
      notifyListeners();
    }
  }
}
