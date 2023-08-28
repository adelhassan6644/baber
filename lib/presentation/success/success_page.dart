import 'package:baber/app/core/utils/color_resources.dart';
import 'package:baber/controller/cart_provider.dart';
import 'package:baber/navigation/custom_navigation.dart';
import 'package:baber/navigation/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/images.dart';
import '../../app/core/utils/text_styles.dart';
import '../../domain/localization/language_constant.dart';
import '../base/custom_button.dart';
import '../base/custom_images.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: customImageIcon(
                  imageName: Images.done,
                  width: 215,
                  height: 215,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: Text(
                  getTranslated("to_confirm_your_order", context),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.w600.copyWith(
                      fontSize: 22, color: ColorResources.PRIMARY_COLOR),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Consumer<CartProvider>(builder: (_, provider, child) {
                return CustomButton(
                  isLoading: provider.isOpen,
                  assetIcon:
                      "${FirebaseAuth.instance.currentUser?.phoneNumber?.replaceAll("+", "").trim()}" ==
                              "966555666777"
                          ? null
                          : Images.whatsApp,
                  text:
                      "${FirebaseAuth.instance.currentUser?.phoneNumber?.replaceAll("+", "").trim()}" ==
                              "966555666777"
                          ? getTranslated("home", context)
                          : getTranslated("press_here", context),
                  onTap: () {
                    if ("${FirebaseAuth.instance.currentUser?.phoneNumber?.replaceAll("+", "").trim()}" ==
                        "966555666777") {
                      CustomNavigator.push(Routes.DASHBOARD,
                          arguments: 0, clean: true);
                    } else {
                      provider.openWhatsApp();
                    }
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
