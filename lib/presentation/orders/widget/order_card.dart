import 'package:baber/app/core/utils/color_resources.dart';
import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/text_styles.dart';

class OrderCardView extends StatelessWidget {
  const OrderCardView({
    Key? key,
  }) : super(key: key);
  // final OrderItem? orderItem;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ID : 10",
                          style: AppTextStyles.w500.copyWith(
                              fontSize: 12, color: ColorResources.SUBTITLE)),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text("100 AED",
                            style: AppTextStyles.w600.copyWith(fontSize: 16)),
                      ),
                      Text(DateTime.now().dateFormat(format: "yyyy MMM dd"),
                          style: AppTextStyles.w500.copyWith(
                              fontSize: 12,
                              color: ColorResources.PRIMARY_COLOR)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
