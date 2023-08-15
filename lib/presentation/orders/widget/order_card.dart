import 'package:baber/app/core/utils/color_resources.dart';
import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/text_styles.dart';
import '../../../data/model/orders_model.dart';

class OrderCardView extends StatelessWidget {
  const OrderCardView({
    required this.orderItem,
    Key? key,
  }) : super(key: key);
  final OrderItem orderItem;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.w),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, .1),
                blurRadius: 0.5,
                spreadRadius: 0.75,
                offset: Offset(-1, 1))
          ],
          color: ColorResources.WHITE_COLOR,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("رقم الطلب  :  ${orderItem.orderId}",
                style: AppTextStyles.w700.copyWith(fontSize: 16)),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              child: Text("سفرة  :  ${orderItem.storeName ?? ""}",
                  style: AppTextStyles.w600.copyWith(
                      fontSize: 14, color: ColorResources.PRIMARY_COLOR)),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Text("الاجمالي  :  ${orderItem.total} ريال",
                  style: AppTextStyles.w500.copyWith(fontSize: 14)),
            ),
            Row(
              children: [
                const Expanded(child: SizedBox()),
                Text(
                    orderItem.createdAt!
                        .dateFormat(format: "dd MMM yyyy , hh:mm a"),
                    style: AppTextStyles.w500.copyWith(
                        fontSize: 14, color: ColorResources.PRIMARY_COLOR)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
