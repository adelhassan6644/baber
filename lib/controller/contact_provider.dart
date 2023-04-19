import 'package:baber/domain/localization/language_constant.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../app/core/error/failures.dart';
import '../../navigation/custom_navigation.dart';
import '../app/core/error/api_error_handler.dart';
import '../app/core/utils/app_snack_bar.dart';
import '../app/core/utils/color_resources.dart';
import '../domain/repository/contact_repo.dart';

class ContactProvider extends ChangeNotifier {
  final ContactRepo contactRepo;
  ContactProvider({required this.contactRepo,});

  String? message;

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  sendMessage() async {
    try {
      {
        _isLoading = true;
        notifyListeners();
        Either<ServerFailure, Response> response = await contactRepo.contact(message:message??"" ,
        );
        response.fold((fail) {
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: fail.error,
                  isFloating: true,
                  backgroundColor: ColorResources.IN_ACTIVE,
                  borderColor: Colors.transparent));
          notifyListeners();
        }, (success) {
          CustomNavigator.pop();
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: getTranslated("your_message_send_successfully", CustomNavigator.navigatorState.currentContext!),
                  isFloating: true,
                  backgroundColor: ColorResources.ACTIVE,
                  borderColor: Colors.transparent));
        });
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      CustomNavigator.pop();
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
