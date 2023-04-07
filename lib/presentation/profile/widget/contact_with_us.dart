import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/extensions.dart';
import 'package:baber/app/core/utils/svg_images.dart';
import 'package:baber/domain/localization/language_constant.dart';
import 'package:baber/presentation/base/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../base/custom_button.dart';

class ContactWithUs extends StatelessWidget {
  const ContactWithUs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: true,
      child: Container(
        width: context.width,
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Container(
                height: 5.h,
                width: 36.w,
                decoration: BoxDecoration(
                    color: const Color(0xFF3C3C43).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(100)),
                child: const SizedBox(),
              ),
            ),
            Text(
              getTranslated("contact_with_us",context),
              style: AppTextStyles.w600
                  .copyWith(fontSize: 16),
            ),

            SizedBox(height: 6.h),
            CustomTextFormField(
              label: true,
              hint: "${getTranslated("write_your_massage",context)}.....",
              minLine: 5,
              maxLine: 5,
              onChanged: (v) {
              },
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
              child: CustomButton(
                  isLoading: false,
                  isError: false,
                  height: 46.h,
                  svgIcon: SvgImages.send,
                  onTap: () {},
                  textColor: ColorResources.WHITE_COLOR,
                  text: getTranslated("submit", context),
                  backgroundColor: ColorResources.PRIMARY_COLOR),
            ),

          ],
        ),
      ),
    );
  }
}
