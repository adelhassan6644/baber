import 'package:baber/controller/products_provider.dart';
import 'package:baber/domain/repository/vendor_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/core/error/api_error_handler.dart';
import '../app/core/error/failures.dart';
import '../app/core/utils/app_snack_bar.dart';
import '../app/core/utils/color_resources.dart';
import '../data/model/item_model.dart';

class VendorProvider extends ChangeNotifier {
  final VendorRepo vendorRepo;
  VendorProvider({required this.vendorRepo});

  late int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void getMenusData(
      {required int index,
      required String menuId,
      required BuildContext context}) {
    Provider.of<ProductsProvider>(context, listen: false).getProductsByMenu(menuId: menuId);
    _currentIndex = index;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ItemModel? vendor;

  getVendorDetails({required String id}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await vendorRepo.getVendorDetails(id: id);
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
        vendor = ItemModel.fromJson(success.data["data"]);
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
