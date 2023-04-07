import 'package:baber/app/core/utils/color_resources.dart';
import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/presentation/base/custom_images.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/text_styles.dart';

class NotificationCardView extends StatelessWidget {
  const NotificationCardView({Key? key, required this.isOpened,this.isFirst=false})
      : super(key: key);
  final bool isOpened;
  final bool isFirst;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
              left: Dimensions.PADDING_SIZE_DEFAULT.w,
              right: Dimensions.PADDING_SIZE_DEFAULT.w,
              bottom: Dimensions.PADDING_SIZE_DEFAULT.h,
              top:isFirst?0: Dimensions.PADDING_SIZE_DEFAULT.h),
          color: isOpened ? ColorResources.PRIMARY_COLOR.withOpacity(0.1) : null,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: customImageIcon(
                  imageName: Images.splash,
                  fit: BoxFit.contain,
                  width: 50.w,
                  height: 50.h,
                ),
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Text("Your order is on the way, Get ready!",
                        style: AppTextStyles.w500.copyWith(
                            fontSize: 12,
                            color: !isOpened ? ColorResources.HINT_COLOR : null)),
                  ),
                  Text("Wednesday, 08, 02:00 Am",
                      style: AppTextStyles.w500.copyWith(
                          fontSize: 12,
                          color: !isOpened ? ColorResources.HINT_COLOR : null)),
                ],
              ),
            ],
          ),
        ),
        const Divider(height: 0, color: ColorResources.BORDER_COLOR),
      ],
    );
  }
}
