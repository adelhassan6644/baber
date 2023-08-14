import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../app/core/error/api_error_handler.dart';
import '../app/core/error/failures.dart';
import '../app/core/utils/app_snack_bar.dart';
import '../app/core/utils/color_resources.dart';
import '../data/model/notification_model.dart';
import '../domain/repository/order_history_repo.dart';

class OrderHistoryProvider extends ChangeNotifier {
  final OrderHistoryRepo orderHistoryRepo;
  OrderHistoryProvider({required this.orderHistoryRepo});

  NotificationModel? notificationModel;

  bool isLoading = false;

  getOrders() async {
    try {
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response =
          await orderHistoryRepo.getOrderHistory();
      response.fold((fail) {
        isLoading = false;
        notifyListeners();
      },
              (success) {
        notificationModel = NotificationModel.fromJson(success.data);
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
