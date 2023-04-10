import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../app/core/error/api_error_handler.dart';
import '../app/core/error/failures.dart';
import '../app/core/utils/app_snack_bar.dart';
import '../app/core/utils/color_resources.dart';
import '../data/model/base_model.dart';
import '../domain/repository/products_repo.dart';

class ProductsProvider extends ChangeNotifier {
  final ProductsRepo productsRepo;
  ProductsProvider({required this.productsRepo});


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  BaseModel? productsModel;

  getProductsByMenu({required String menuId}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response =
      await productsRepo.getProductsByMenu(menuId: menuId);
      response.fold((fail) {
        _isLoading = false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail.error),
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (success) {
        _isLoading = false;
        productsModel = BaseModel.fromJson(success.data);
        notifyListeners();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      _isLoading = false;
      notifyListeners();
    }
  }
}
