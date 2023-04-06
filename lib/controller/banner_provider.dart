import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../app/core/error/api_error_handler.dart';
import '../app/core/error/failures.dart';
import '../app/core/utils/app_snack_bar.dart';
import '../app/core/utils/color_resources.dart';
import '../data/model/home_model.dart';
import '../domain/repositery/home_repo.dart';

class BannerProvider extends ChangeNotifier {
  final HomeRepo homeRepo;
  BannerProvider({required this.homeRepo});

  late int _currentIndex=0;
  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  late List<BannerModel>? _bannerList = [
    BannerModel(
        id: 1,
        image:
            "https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8&w=1000&q=80"),
    BannerModel(
        id: 1,
        image:
            "https://images.unsplash.com/photo-1566438480900-0609be27a4be?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1894&q=80"),
  ];
  List<BannerModel>? get bannerList => _bannerList;

  getBannerList() async {
    try {
      {
        notifyListeners();
        Either<ServerFailure, Response> response =
            await homeRepo.getBannerList();
        response.fold((fail) {
          _bannerList = null;
          notifyListeners();
        }, (success) {
          _bannerList = success.data;
          notifyListeners();
        });
      }
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      _bannerList = null;
      notifyListeners();
    }
  }
}
