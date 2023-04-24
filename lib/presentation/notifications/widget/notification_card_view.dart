import 'package:baber/app/core/utils/color_resources.dart';
import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/extensions.dart';
import 'package:baber/presentation/base/custom_images.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/text_styles.dart';
import 'package:baber/data/model/notification_model.dart';

class NotificationCardView extends StatelessWidget {
  const NotificationCardView(
      {Key? key,
      required this.notification,
      required this.isOpened,
      this.isFirst = false})
      : super(key: key);
  final bool isOpened;
  final bool isFirst;
  final NotificationData notification;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
              left: Dimensions.PADDING_SIZE_DEFAULT.w,
              right: Dimensions.PADDING_SIZE_DEFAULT.w,
              bottom: Dimensions.PADDING_SIZE_DEFAULT.h,
              top: isFirst ? 0 : Dimensions.PADDING_SIZE_DEFAULT.h),
          color:
              isOpened ? ColorResources.PRIMARY_COLOR.withOpacity(0.1) : null,
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
                    child: Text(notification.body??"",
                        style: AppTextStyles.w500.copyWith(
                            fontSize: 12,
                            color:
                                !isOpened ? ColorResources.HINT_COLOR : null)),
                  ),
                  Text(notification.createdAt!.dateFormat(format: "EEEE, MMM d, hh:mm"),
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
