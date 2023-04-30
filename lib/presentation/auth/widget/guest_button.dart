import 'package:baber/app/core/utils/color_resources.dart';
import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/text_styles.dart';
import 'package:baber/domain/localization/language_constant.dart';
import 'package:baber/presentation/base/custom_images.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/svg_images.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';

class GuestButton extends StatelessWidget {
  const GuestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: (){
        CustomNavigator.push(Routes.DASHBOARD,replace: true);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
              text: TextSpan(children: [
                TextSpan(
                    text:getTranslated("browse", context),
                    style:
                    AppTextStyles.w600.copyWith(color: ColorResources.SUBTITLE,fontSize: 16)),
                TextSpan(
                    text: getTranslated("as_a_guest", context),
                    style: AppTextStyles.w600.copyWith(color: ColorResources.PRIMARY_COLOR,fontSize: 16)),
              ])),
          SizedBox(width: 8.w,),
          customImageIconSVG(imageName: SvgImages.arrowRightIcon)
        ],
      ),
    );
  }
}
