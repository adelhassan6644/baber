import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../app/core/error/api_error_handler.dart';
import '../app/core/error/failures.dart';
import '../app/core/utils/app_snack_bar.dart';
import '../app/core/utils/color_resources.dart';
import '../data/model/item_model.dart';
import '../domain/repositery/item_repo.dart';

class ItemProvider extends ChangeNotifier {
  final ItemRepo itemRepo;
  ItemProvider({required this.itemRepo});


  bool _isLoading = false;
  bool get isLoading => _isLoading;


  ItemModel? _item ;
  ItemModel? get item => _item;

  getItemDetails({required int id}) async {
    try {
      {
        _isLoading = true;
        notifyListeners();
        Either<ServerFailure, Response> response =
        await itemRepo.getItemDetails(id: id);
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
          _item = success.data;
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
