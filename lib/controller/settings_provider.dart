import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../app/core/error/api_error_handler.dart';
import '../app/core/error/failures.dart';
import '../app/core/utils/app_snack_bar.dart';
import '../app/core/utils/color_resources.dart';
import '../data/model/settings_model.dart';
import '../domain/repository/settings_repo.dart';

class SettingsProvider extends ChangeNotifier{
  final SettingsRepo settingsRepo;
  SettingsProvider({required this.settingsRepo});

  SettingsModel? settingsModel;
  bool isLoading = false;
  getSettingsInfo() async {
    try {
      Either<ServerFailure, Response> response =
      await settingsRepo.getSettingsInfo();
      response.fold((fail) {
        isLoading =false;
        notifyListeners();
      }, (success) {
        settingsModel = SettingsModel.fromJson(success.data["data"]);
        isLoading =false;
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