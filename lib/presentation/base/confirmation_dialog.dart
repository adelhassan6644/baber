import 'package:baber/app/core/utils/color_resources.dart';
import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/svg_images.dart';
import 'package:baber/presentation/base/custom_button.dart';
import 'package:flutter/material.dart';
import '../../app/core/utils/text_styles.dart';
import '../../navigation/custom_navigation.dart';
import 'custom_images.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog(
      {required this.txtBtn,this.icon, this.description, this.onContinue, Key? key})
      : super(key: key);
  final void Function()? onContinue;
  final String txtBtn;
  final String? description;
  final String? icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        customImageIconSVG(imageName: (icon??SvgImages.alarm)),
         SizedBox(
          height: 16.h,
        ),
        // Text("هل انت متأكد ؟",style: AppTextStyles.w500.copyWith(
        //   fontSize: 16,
        // ),),
        // SizedBox(
        //   height: 8.h,
        // ),
        if(description != null) Text(description!,textAlign: TextAlign.center,style: AppTextStyles.w400.copyWith(
            fontSize: 14,
            // color: ColorResources.DETAILS_COLOR
        ),),
        SizedBox(
          height: 24.h,
        ),
        Row(
          children: [
            Expanded(
                child: CustomButton(
              onTap: onContinue,
              text: txtBtn,
            )),
            SizedBox(
              width: 16.w,
            ),
            Expanded(
                child: CustomButton(
              onTap: () => CustomNavigator.pop(),
              text: "رجوع",
              backgroundColor: ColorResources.PRIMARY_COLOR.withOpacity(0.1),
              textColor: ColorResources.PRIMARY_COLOR,
            ))
          ],
        )
      ],
    );
  }
}
