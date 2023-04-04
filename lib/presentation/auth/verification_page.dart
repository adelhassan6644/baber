import 'package:baber/app/core/utils/extensions.dart';
import 'package:baber/app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/dimensions.dart';
import '../../controller/auth_provider.dart';
import '../../domain/localization/language_constant.dart';
import '../base/count_down.dart';
import '../base/custom_button.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACKGROUND_COLOR,
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: Consumer<AuthProvider>(builder: (child, authProvider, _) {
          return Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: context.height * 0.05,
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 24.h),
                  child: Text(getTranslated("please_enter_verification_code", context),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.w500.copyWith(
                          color: ColorResources.PRIMARY_COLOR,
                          fontSize: 16)),
                ),
                 SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
                  child: PinCodeTextField(
                    length: 4,
                    appContext: context,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.slide,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      fieldHeight: 60,
                      fieldWidth: 60,
                      borderWidth: 1,
                      borderRadius:
                      BorderRadius.circular(Dimensions.RADIUS_SMALL),
                      selectedColor:
                      Theme.of(context).primaryColor.withOpacity(0.2),
                      selectedFillColor: Colors.white,
                      inactiveFillColor:
                      Theme.of(context).disabledColor.withOpacity(0.2),
                      inactiveColor:
                      Theme.of(context).primaryColor.withOpacity(0.2),
                      activeColor:
                      Theme.of(context).primaryColor.withOpacity(0.4),
                      activeFillColor:
                      Theme.of(context).disabledColor.withOpacity(0.2),
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    onChanged: authProvider.updateVerificationCode,
                    beforeTextPaste: (text) => true,
                  ),
                ),
                 SizedBox(
                  height: 10.h,
                ),
                 CountDown(onCount:  authProvider.logIn(),),

                SizedBox(
                  height: context.height * 0.07,
                ),
                CustomButton(
                    isLoading: authProvider.isLoading,
                    isError: authProvider.isError,
                    onTap: () {
                      if(formKey.currentState!.validate()) {
                        authProvider.sendOTP();
                      }
                    },
                    textColor: ColorResources.WHITE_COLOR,
                    text: getTranslated("send_otp", context),
                    backgroundColor: ColorResources.PRIMARY_COLOR),

              ],
            ),
          );
        }),
      ),
    );
  }
}
