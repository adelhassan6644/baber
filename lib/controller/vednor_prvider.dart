import 'package:baber/domain/repositery/vendor_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../app/core/error/api_error_handler.dart';
import '../app/core/error/failures.dart';
import '../app/core/utils/app_snack_bar.dart';
import '../app/core/utils/color_resources.dart';
import '../data/model/vendor_model.dart';

class VendorProvider extends ChangeNotifier {
  final VendorRepo vendorRepo;
  VendorProvider({required this.vendorRepo});



  late int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;


   VendorModel? _vendor ;
   VendorModel? get vendor => _vendor;

  getVendorDetails({required int id}) async {
    try {
      {
        _isLoading = true;
        notifyListeners();
        Either<ServerFailure, Response> response =
        await vendorRepo.getVendorDetails(id: id);
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
          _vendor = success.data;
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
