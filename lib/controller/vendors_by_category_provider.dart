import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../app/core/error/api_error_handler.dart';
import '../app/core/error/failures.dart';
import '../app/core/utils/app_snack_bar.dart';
import '../app/core/utils/color_resources.dart';
import '../data/model/home_model.dart';
import '../domain/repositery/category_repo.dart';

class VendorsByCategoryProvider extends ChangeNotifier {
  final CategoryRepo categoryRepo;
  VendorsByCategoryProvider({required this.categoryRepo});

  late int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  late List<ItemModel>? _vendorsByCategoryList = [
    ItemModel(
        id: 1,
        title: "اكل شعبي",
        address: "المدينة ",
        image:
        "https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8&w=1000&q=80"),
    ItemModel(
        id: 1,
        title: "معجنات",
        address: "الرياض ",
        image:
        "https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8&w=1000&q=80"),
    ItemModel(
        id: 1,
        address: "جدة ",
        title: "حلي",
        image:
        "https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8&w=1000&q=80"),
    ItemModel(
        id: 2,
        address: "مكة ",
        title: "محاشي",
        image:
        "https://images.unsplash.com/photo-1566438480900-0609be27a4be?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1894&q=80"),
  ];
  List<ItemModel>? get vendorsByCategoryList => _vendorsByCategoryList;

  getVendorByCategoryList({required int id}) async {
    try {
      {
        _isLoading = true;
        notifyListeners();
        Either<ServerFailure, Response> response =
            await categoryRepo.getVendorsByCategoryList();
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
          _vendorsByCategoryList = success.data;
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
      _isLoading = false;
      notifyListeners();
    }
  }
}
