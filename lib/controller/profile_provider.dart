import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../app/core/error/api_error_handler.dart';
import '../app/core/error/failures.dart';
import '../app/core/utils/app_snack_bar.dart';
import '../app/core/utils/color_resources.dart';
import '../data/model/profile_model.dart';
import '../domain/repository/profile_repo.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepo profileRepo;
  ProfileProvider({required this.profileRepo});

  ProfileModel? profileModel ;

  getProfileInfo() async {
    try {
      Either<ServerFailure, Response> response =
      await profileRepo.getProfileInfo();
      response.fold((fail) {
        notifyListeners();
      }, (success) {
        profileModel = ProfileModel.fromJson(success.data["data"]);
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
