import 'package:baber/app/core/utils/extensions.dart';
import 'package:baber/app/core/utils/text_styles.dart';
import 'package:baber/app/core/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/dimensions.dart';
import '../../app/core/utils/images.dart';
import '../../controller/firebase_auth_provider.dart';
import '../../domain/localization/language_constant.dart';
import '../base/count_down.dart';
import '../base/custom_button.dart';
import '../base/custom_stack_app_bar.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACKGROUND_COLOR,
      body: Consumer<FirebaseAuthProvider>(builder: (child, provider, _) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, .25),
                          blurRadius: 5,
                          spreadRadius: 5,
                        )
                      ],
                      color: ColorResources.PRIMARY_COLOR
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: context.toPadding,),
                        Image.asset(
                          Images.splash,
                          height: 215.h,
                          width: context.width,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                  const CustomStackAppBar()
                ],
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Center(child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                          vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(getTranslated("verify_the_phone", context),
                              style: AppTextStyles.w700.copyWith(
                                  fontSize: 20,
                                  color: Colors.black,
                                  height: 1)),
                          SizedBox(height: 24.h),
                          Text(
                              getTranslated(
                                  "please_verify_your_mobile_number_and_enter_the_6_digit_verification_code",
                                  context),
                              textAlign: TextAlign.center,
                              style: AppTextStyles.w500.copyWith(
                                  fontSize: 14,
                                  color: ColorResources.SUBTITLE)),
                        ],
                      ),
                    )),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w, vertical: 20.h),
                      child: PinCodeTextField(
                        length: 6,
                        hintCharacter: "*",
                        hintStyle: AppTextStyles.w500.copyWith(color: ColorResources.DETAILS_COLOR),
                        appContext: context,
                        keyboardType: TextInputType.phone,
                        animationType: AnimationType.slide,
                        obscureText: true,
                        obscuringCharacter: "*",
                        validator: Validations.code,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        errorTextDirection:TextDirection.rtl,
                        cursorColor: ColorResources.PRIMARY_COLOR,
                        errorTextSpace: 30.h,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          fieldHeight: 50.h,
                          fieldWidth: 50.w,
                          borderWidth: 1.w,
                          borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                          selectedColor: ColorResources.LIGHT_GREY_BORDER,
                          selectedFillColor: ColorResources.FILL_COLOR,
                          inactiveFillColor: ColorResources.FILL_COLOR,
                          inactiveColor: ColorResources.LIGHT_GREY_BORDER,
                          activeColor: ColorResources.LIGHT_GREY_BORDER,
                          activeFillColor: ColorResources.FILL_COLOR,
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        backgroundColor: Colors.transparent,
                        enableActiveFill: true,
                        onChanged: provider.updateVerificationCode,
                        beforeTextPaste: (text) => true,
                      ),
                    ),
                    CountDown(
                      onCount: provider.signInWithMobileNo,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                          vertical: Dimensions.PADDING_SIZE_SMALL.h),
                      child: CustomButton(
                          isLoading: provider.isSubmit,
                          height: 46.h,
                          onTap: () {if (formKey.currentState!.validate()) {provider.sendOTP();}},
                          textColor: ColorResources.WHITE_COLOR,
                          text: getTranslated("submit", context),
                          backgroundColor: ColorResources.PRIMARY_COLOR),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
