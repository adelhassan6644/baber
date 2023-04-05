import 'package:baber/app/core/utils/color_resources.dart';
import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key, required this.title,required this.description,});
  final String title,description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.w700.copyWith(fontSize: 20,color: Colors.black,height: 1)),
          SizedBox(height:5.h),
          Text(description, style: AppTextStyles.w500.copyWith(fontSize: 14,color: ColorResources.SUBTITLE)),
        ],
      ),
    );
  }
}
