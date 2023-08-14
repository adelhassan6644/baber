import 'package:baber/app/core/utils/color_resources.dart';
import 'package:baber/controller/cart_provider.dart';
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
                  "تم تأكيد طلبك بنجاح",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.w600.copyWith(
                      fontSize: 22, color: ColorResources.PRIMARY_COLOR),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                child: Text(
                  "قم بإرسال طلبك عبر WhatsApp",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.w500.copyWith(
                      fontSize: 16, color: ColorResources.DETAILS_COLOR),
                ),
              ),
              Consumer<CartProvider>(builder: (_, provider, child) {
                return CustomButton(
                  isLoading: provider.isOpen,
                  assetIcon: Images.whatsApp,
                  text: getTranslated("submit", context),
                  onTap: () => provider.openWhatsApp(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}