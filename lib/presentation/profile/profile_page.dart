import 'package:baber/app/core/utils/color_resources.dart';
import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/svg_images.dart';
import 'package:baber/domain/localization/language_constant.dart';
import 'package:baber/presentation/base/custom_app_bar.dart';
import 'package:baber/presentation/base/custom_images.dart';
import 'package:baber/presentation/profile/widget/contact_with_us.dart';
import 'package:baber/presentation/profile/widget/profile_option.dart';
import 'package:flutter/cupertino.dart';
import '../../app/core/utils/text_styles.dart';
import '../../navigation/custom_navigation.dart';
import '../../navigation/routes.dart';
import '../base/custom_show_model_bottom_sheet.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: getTranslated("profile", context),
        ),
        SizedBox(
          height: 24.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: 70.w,
                    height: 70.h,
                    decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  customImageIconSVG(imageName: SvgImages.maleAvatar),
                ],
              ),
              SizedBox(
                width: 24.h,
              ),
              Text("60055005 (966+)",
                  style: AppTextStyles.w500.copyWith(
                      fontSize: 14, color: ColorResources.HINT_COLOR)),
            ],
          ),
        ),
        SizedBox(
          height: 40.h,
        ),
        ProfileOption(
            onTap: () => CustomNavigator.push(Routes.Location, arguments: true),
            title: getTranslated("change_city", context),
            iconName: SvgImages.edit),
        ProfileOption(
            onTap: () => CustomNavigator.push(Routes.NOTIFICATION),
            title: getTranslated("notifications", context),
            iconName: SvgImages.notification),
        ProfileOption(
            onTap: () =>
                customShowModelBottomSheet(body: const ContactWithUs()),
            title: getTranslated("contact_with_us", context),
            iconName: SvgImages.message),
        ProfileOption(
            onTap: () => CustomNavigator.push(Routes.ABOUT),
            title: getTranslated("about_baber", context),
            iconName: SvgImages.information),
        ProfileOption(
            onTap: () => CustomNavigator.push(Routes.PRIVACY),
            title: getTranslated("privacy_policy", context),
            iconName: SvgImages.security),
        ProfileOption(
            onTap: () {},
            showIcon: false,
            showDivider: false,
            iconColor: ColorResources.FAILED_COLOR,
            title: getTranslated("log_out", context),
            txtColor: ColorResources.FAILED_COLOR,
            iconName: SvgImages.logout),
      ],
    );
  }
}
