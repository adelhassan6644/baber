import 'package:baber/app/core/utils/color_resources.dart';
import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/presentation/base/custom_images.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

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
              top:  Dimensions.PADDING_SIZE_DEFAULT.h),
          // color:
          //     isOpened ? ColorResources.PRIMARY_COLOR.withOpacity(0.1) : null,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notification.title ?? "",
                        style: AppTextStyles.w700
                            .copyWith(fontSize: 14, color: Colors.black)),
                    Row(
                      children: [
                        Expanded(
                          child: ReadMoreText(
                            notification.message ?? "",
                            trimLines: 2,
                            colorClickableText: Colors.white,
                            trimMode: TrimMode.Line,
                            style: AppTextStyles.w500.copyWith(
                              fontSize: 12.0,
                            ),
                            trimCollapsedText: 'عرض المزيد',
                            trimExpandedText: 'عرض اقل',
                            lessStyle: AppTextStyles.w400.copyWith(
                                fontSize: 10,
                                color: ColorResources.PRIMARY_COLOR),
                            moreStyle: AppTextStyles.w400.copyWith(
                                fontSize: 10,
                                color: ColorResources.PRIMARY_COLOR),
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     const Expanded(child: SizedBox()),
                    //     Text(
                    //         notification.createdAt!
                    //             .dateFormat(format: "EEEE, MMM d, hh:mm"),
                    //         style: AppTextStyles.w400.copyWith(
                    //             fontSize: 12,),)
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 0, color: ColorResources.BORDER_COLOR),
      ],
    );
  }
}
