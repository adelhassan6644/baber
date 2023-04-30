import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../app/core/error/api_error_handler.dart';
import '../app/core/error/failures.dart';
import '../app/core/utils/app_snack_bar.dart';
import '../app/core/utils/color_resources.dart';
import '../data/model/banner_model.dart';
import '../domain/repository/home_repo.dart';

class BannerProvider extends ChangeNotifier {
  final HomeRepo homeRepo;
  BannerProvider({required this.homeRepo});

  late int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  BannerModel? bannerModel;

  getBannerList() async {
    try {
      bannerModel=null;
      notifyListeners();
      Either<ServerFailure, Response> response =
          await homeRepo.getHomeBanners();
      response.fold((fail) {
        notifyListeners();
      }, (success) {
        bannerModel = BannerModel.fromJson(success.data);
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
