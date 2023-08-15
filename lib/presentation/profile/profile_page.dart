import 'dart:io';

import 'package:baber/app/core/utils/color_resources.dart';
import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/svg_images.dart';
import 'package:baber/domain/localization/language_constant.dart';
import 'package:baber/presentation/base/custom_app_bar.dart';
import 'package:baber/presentation/profile/widget/contact_with_us.dart';
import 'package:baber/presentation/profile/widget/profile_card.dart';
import 'package:baber/presentation/profile/widget/profile_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../controller/firebase_auth_provider.dart';
import '../../controller/notifications_provider.dart';
import '../../controller/orders_provider.dart';
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
        const ProfileCard(),
        SizedBox(
          height: 40.h,
        ),
        ProfileOption(
            onTap: () => CustomNavigator.push(Routes.CITY, arguments: true),
            title: getTranslated("change_city", context),
            iconName: SvgImages.edit),
        if (Provider.of<FirebaseAuthProvider>(context, listen: false).isLogin)
          ProfileOption(
              onTap: () {
                Provider.of<NotificationProvider>(context, listen: false)
                    .getNotifications();
                CustomNavigator.push(Routes.NOTIFICATION);
              },
              title: getTranslated("notifications", context),
              iconName: SvgImages.notification),
        if (Provider.of<FirebaseAuthProvider>(context, listen: false).isLogin)
          ProfileOption(
              onTap: () {
                Provider.of<OrdersProvider>(context, listen: false)
                    .getOrders();
                CustomNavigator.push(Routes.ORDERS);
              },
              title: getTranslated("orders", context),
              iconName: SvgImages.orders),
        if (Provider.of<FirebaseAuthProvider>(context, listen: false).isLogin)
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
        (Provider.of<FirebaseAuthProvider>(context, listen: false).isLogin)
            ? ProfileOption(
                onTap: () =>
                    Provider.of<FirebaseAuthProvider>(context, listen: false)
                        .logOut(),
                showIcon: false,
                showDivider: false,
                iconColor: ColorResources.FAILED_COLOR,
                title: getTranslated("log_out", context),
                txtColor: ColorResources.FAILED_COLOR,
                iconName: SvgImages.logout)
            : ProfileOption(
                onTap: () =>
                    CustomNavigator.push(Routes.LOGIN, arguments: true),
                showIcon: false,
                showDivider: false,
                iconColor: ColorResources.ACTIVE,
                title: getTranslated("sign_in", context),
                txtColor: ColorResources.ACTIVE,
                iconName: SvgImages.login),
        if (Platform.isIOS &&
            Provider.of<FirebaseAuthProvider>(context, listen: false).isLogin)
          ProfileOption(
              onTap: () =>
                  Provider.of<FirebaseAuthProvider>(context, listen: false)
                      .deleteAccount(),
              showIcon: false,
              showDivider: false,
              iconColor: ColorResources.FAILED_COLOR,
              title: "حذف الحساب",
              txtColor: ColorResources.FAILED_COLOR,
              iconName: SvgImages.delete)
      ],
    );
  }
}
