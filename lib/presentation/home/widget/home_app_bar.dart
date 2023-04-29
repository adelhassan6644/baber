import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/extensions.dart';
import 'package:baber/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../controller/city_provider.dart';
import '../../../domain/localization/language_constant.dart';
import '../../../navigation/routes.dart';
import '../../base/custom_images.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: 120.h,
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: ColorResources.BORDER_COLOR, width: 1.h)),
        color: ColorResources.BACKGROUND_COLOR,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 2,
              spreadRadius: 0.1,
              offset: const Offset(0, 2))
        ],
      ),
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: context.toPadding,
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => CustomNavigator.push(Routes.CITY, arguments: true),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          getTranslated("delivery_to", context),
                          style: AppTextStyles.w500.copyWith(
                              color: ColorResources.PRIMARY_COLOR, fontSize: 13),
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: ColorResources.PRIMARY_COLOR,
                          size: 15,
                        )
                      ],
                    ),
                    Consumer<CityProvider>(
                      builder: (context, provider, child) {
                        return   Text(
                          provider.city?.name ?? "الرياض",
                          style: AppTextStyles.w500.copyWith(
                              color: ColorResources.DETAILS_COLOR, fontSize: 13),
                        );
                      },
                    ),
                  ],
                ),
              ),
              GestureDetector(
                  onTap: ()=>CustomNavigator.push(Routes.SEARCH),
                  child: customImageIconSVG(
                    imageName: SvgImages.homeSearchIcon,
                  )),
            ],
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL.h),
        ],
      ),
    );
  }
}
