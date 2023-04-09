import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../app/core/error/api_error_handler.dart';
import '../app/core/error/failures.dart';
import '../app/core/utils/app_snack_bar.dart';
import '../app/core/utils/color_resources.dart';
import '../data/model/home_model.dart';
import '../domain/repository/home_repo.dart';

class HomeCategoryProvider extends ChangeNotifier {
  final HomeRepo homeRepo;
  HomeCategoryProvider({required this.homeRepo});

  HomeCategoryModel? _homeCategory ;
  HomeCategoryModel? get homeCategory => _homeCategory;

  getHomeCategories() async {
    try {
        Either<ServerFailure, Response> response =
        await homeRepo.getCategoryList();
        response.fold((fail) {
          notifyListeners();
        }, (success) {
          _homeCategory = HomeCategoryModel.fromJson(success.data);
          notifyListeners();
        });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }
}
