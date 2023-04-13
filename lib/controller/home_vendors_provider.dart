import 'package:baber/data/model/base_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../app/core/error/api_error_handler.dart';
import '../app/core/error/failures.dart';
import '../app/core/utils/app_snack_bar.dart';
import '../app/core/utils/color_resources.dart';
import '../domain/repository/home_repo.dart';

class HomeVendorsProvider extends ChangeNotifier {
  final HomeRepo homeRepo;
  HomeVendorsProvider({required this.homeRepo});



  BaseModel? homeVendorList ;

  getVendorList() async {
    try {
        Either<ServerFailure, Response> response =
        await homeRepo.getHomeVendors();
        response.fold((fail) {
          notifyListeners();
        }, (success) {
          homeVendorList = BaseModel.fromJson(success.data);
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
