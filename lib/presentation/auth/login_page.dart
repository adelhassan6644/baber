import 'package:baber/app/core/utils/extensions.dart';
import 'package:baber/presentation/auth/widget/guest_button.dart';
import 'package:baber/presentation/auth/widget/welcome_widget.dart';
import 'package:baber/presentation/base/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/core/utils/app_snack_bar.dart';
import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/dimensions.dart';
import '../../app/core/utils/images.dart';
import '../../app/core/utils/svg_images.dart';
import '../../app/core/utils/validation.dart';
import '../../controller/auth_provider.dart';
import '../../domain/localization/language_constant.dart';
import '../base/chekbox_listtile.dart';
import '../base/custom_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACKGROUND_COLOR,
      body: Consumer<AuthProvider>(builder: (child, authProvider, _) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    WelcomeWidget(
                      title: getTranslated('welcome', context),
                      description:
                          getTranslated('sign_in_description', context),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical:  Dimensions.PADDING_SIZE_DEFAULT.h,
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                      child: CustomTextFormField(
                        controller: authProvider.phoneTEC,
                        pIconColor: Colors.black,
                        pSvgIcon: SvgImages.phoneIcon,
                        isValidat: formKey.currentState?.validate() ?? true,
                        hint: getTranslated("phone_number", context),
                        valid: Validations.phone,
                        inputType: TextInputType.phone,
                        label: true,
                        maxLength: 9,
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                      child: CheckBoxListTile(
                        title: getTranslated("remember_me", context),
                        onChange:authProvider.onRememberMe ,
                        check: authProvider.isRememberMe,
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                      child: CheckBoxListTile(
                        title:getTranslated("agree_to_the_terms_and_conditions", context),
                        onChange:authProvider.onAgree ,
                        check: authProvider.isAgree,

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,vertical:Dimensions.PADDING_SIZE_DEFAULT.h ),
                      child: CustomButton(
                          isLoading: authProvider.isLoading,
                          isError: authProvider.isError,
                          height: 46.h,
                          onTap: () {
                            if(authProvider.isAgree) {
                              if (formKey.currentState!.validate()) {
                                authProvider.logIn();
                              }
                            }else{
                              CustomSnackBar.showSnackBar(
                                  notification: AppNotification(
                                      message: "يجب الموافقة علي الشروط والاحكام اولا!",
                                      isFloating: true,
                                      backgroundColor: ColorResources
                                          .IN_ACTIVE,
                                      borderColor: Colors.transparent));
                            }

                          },
                          textColor: ColorResources.WHITE_COLOR,
                          text: getTranslated("sign_in", context),
                          backgroundColor: ColorResources.PRIMARY_COLOR),
                    ),
                    const GuestButton()
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
