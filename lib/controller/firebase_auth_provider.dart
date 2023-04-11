import 'dart:developer';

import 'package:baber/domain/localization/language_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../navigation/custom_navigation.dart';
import '../../navigation/routes.dart';
import '../app/core/error/api_error_handler.dart';
import '../app/core/utils/app_snack_bar.dart';
import '../app/core/utils/color_resources.dart';
import '../domain/repository/firebase_auth_repo.dart';

class FirebaseAuthProvider extends ChangeNotifier {
  final FirebaseAuthRepo firebaseAuthRepo;
  FirebaseAuthProvider({
    required this.firebaseAuthRepo,
  }) {
    _phoneTEC = TextEditingController(
        text: kDebugMode ? "597834528" : firebaseAuthRepo.getPhone());
  }
  FirebaseAuth auth = FirebaseAuth.instance;

  String? phone;
  late final TextEditingController _phoneTEC;
  TextEditingController get phoneTEC => _phoneTEC;

  String firebaseVerificationId = "";
  String _verificationCode = "";
  String get verificationCode => _verificationCode;

  bool _isRememberMe = false;
  bool isLoginBefore = false;
  bool get isRememberMe => _isRememberMe;
  bool _isAgree = true;
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
  // bool _isSubmit = false;
  bool get isLoading => _isLoading;
  // bool get isSubmit => _isSubmit;

  bool get isLogin => firebaseAuthRepo.isLoggedIn();

  signInWithMobileNo(String mobileNo) async {
    try {
      _isLoading = true;
      notifyListeners();

      await auth.verifyPhoneNumber(
        phoneNumber: mobileNo,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (authCredential) => phoneVerificationCompleted(authCredential),
        verificationFailed: (authException) => phoneVerificationFailed(authException),
        codeSent: (verificationId, code) => phoneCodeSent(verificationId: verificationId,code:  code??0),
        codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout,
      );
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
    }
  }

  phoneVerificationCompleted(AuthCredential authCredential) {
    _isLoading=false;
    CustomNavigator.push(Routes.DASHBOARD,clean: true);
    log(authCredential.token.toString());
    firebaseAuthRepo.saveUserToken(token: authCredential.token.toString());
    firebaseAuthRepo.setLoggedIn();
  }

  phoneVerificationFailed(FirebaseException authException) {
    if (authException.code == 'invalid-phone-number') {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "رقم الهاتف غير صحيح",
              isFloating: true,
              backgroundColor: ColorResources.ACTIVE,
              borderColor: Colors.transparent));
    } else {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: authException.message.toString(),
              isFloating: true,
              backgroundColor: ColorResources.ACTIVE,
              borderColor: Colors.transparent));
    }
    _isLoading=false;
  }

  phoneCodeAutoRetrievalTimeout(String verificationCode) {
    _verificationCode = verificationCode;
  }

  phoneCodeSent({required String verificationId,required int code,bool submit =false,String? smsCode}) async {
    _isLoading=false;
    firebaseVerificationId = verificationId;
    CustomNavigator.push(Routes.VERIFICATION,);

   if(submit == true) {
      try {
        _isLoading=true;
        PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: firebaseVerificationId,
          smsCode: smsCode??"",
        );
        await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      } catch (e) {
        _isLoading=false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: e.toString(),
                isFloating: true,
                backgroundColor: ColorResources.ACTIVE,
                borderColor: Colors.transparent));
      }
    }

  }

  signIn(AuthCredential authCredential) {
    FirebaseAuth.instance.signInWithCredential(authCredential);
  }

  //for manual otp entry
  signInViaOTP(smsCode, verId) {
    AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verId, smsCode: smsCode);
    signIn(authCredential);
  }


  logOut() async {
    try {
      FirebaseAuth.instance.signOut();
      await firebaseAuthRepo.clearSharedData();
      CustomNavigator.push(Routes.LOGIN, clean: true);
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: getTranslated("your_logged_out_successfully",
                  CustomNavigator.navigatorState.currentContext!),
              isFloating: true,
              backgroundColor: ColorResources.ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: getTranslated("your_logged_out_successfully",
                  CustomNavigator.navigatorState.currentContext!),
              isFloating: true,
              backgroundColor: ColorResources.ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }

  }
}
