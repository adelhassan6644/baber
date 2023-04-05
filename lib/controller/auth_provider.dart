import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../app/core/error/failures.dart';
import '../../domain/repositery/auth_repo.dart';
import '../../navigation/custom_navigation.dart';
import '../../navigation/routes.dart';
import '../app/core/error/api_error_handler.dart';
import '../app/core/utils/app_snack_bar.dart';
import '../app/core/utils/color_resources.dart';
import 'base_vm.dart';

class AuthProvider extends ChangeNotifier with BaseViewModel {
  final AuthRepo authRepo;
  AuthProvider({required this.authRepo,});
  final TextEditingController _phoneTEC =
  TextEditingController(text: kDebugMode ? "44455666":'');
   TextEditingController get phoneTEC=>_phoneTEC;

  String _verificationCode = "";
  String get verificationCode => _verificationCode;

  bool _isRememberMe = false;
  bool get isRememberMe => _isRememberMe;
  bool _isAgree = false;
  bool get isAgree => _isAgree;

  void onRememberMe(bool value) {
    _isRememberMe = value;
    notifyListeners();
  }

  void onAgree(bool value) {
    _isAgree = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool _isSubmit = false;
  bool isError = false;
  bool isErrorOnSubmit = false;
  bool get isLoading => _isLoading;
  bool get isSubmit => _isSubmit;

  bool get isLogin => authRepo.isLoggedIn();

  logIn() async {
    try {
      {
        isError = false;
        _isLoading = true;
        notifyListeners();
        Either<ServerFailure, Response> response = await authRepo.logIn(
            phone: _phoneTEC.text.trim(),);
        response.fold((fail) {
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: fail.error,
                  isFloating: true,
                  backgroundColor: ColorResources.IN_ACTIVE,
                  borderColor: Colors.transparent));
          isError = true;
          notifyListeners();
        }, (success) {
          CustomNavigator.push(Routes.VERIFICATION,);
        });
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));

      isError = true;
      _isLoading = false;
      notifyListeners();
    }
  }


  sendOTP() async {
    try {
      isErrorOnSubmit = false;
        _isSubmit = true;
        notifyListeners();
        Either<ServerFailure, Response> response =
            await authRepo.sendOTP(
          code: _verificationCode,
        );
        response.fold((fail) {
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: fail.error,
                  isFloating: true,
                  backgroundColor: ColorResources.IN_ACTIVE,
                  borderColor: Colors.transparent));
          isErrorOnSubmit = true;
          notifyListeners();
        }, (success) {
          _verificationCode ="";
          CustomNavigator.push(Routes.DASHBOARD, replace: true);
        });
        _isSubmit = false;
        notifyListeners();
    } catch (e) {
      isErrorOnSubmit = true;
      _isSubmit = false;
      CustomSnackBar.showSnackBar(notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }

  void updateVerificationCode(String code) {
    _verificationCode = code;
    notifyListeners();
  }


  logOut() async {
    CustomNavigator.push(Routes.LOGIN, clean: true);
    await authRepo.clearSharedData();
    CustomSnackBar.showSnackBar(
        notification: AppNotification(
            message: "You logged out successfully !",
            isFloating: true,
            backgroundColor: ColorResources.ACTIVE,
            borderColor: Colors.transparent));
    notifyListeners();
  }
}
