import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/extensions.dart';
import 'package:baber/app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import '../../app/core/utils/color_resources.dart';
import 'custom_images.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final Color? textColor;
  final Color backgroundColor;
  final String? svgIcon;
  final String? assetIcon;
  final Color? iconColor;
  final double? width;
  final double? height;
  final bool isLoading;
  final bool isError;

  const CustomButton(
      {Key? key,
      this.onTap,
      this.height,
      this.svgIcon,
      this.assetIcon,
      this.isLoading = false,
       this.textColor ,
      this.width,
      this.iconColor ,
      required this.text,
       this.backgroundColor=ColorResources.PRIMARY_COLOR,  this.isError=false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
        onTap!();
      },
      child: AnimatedContainer(
        width: isLoading ? 90.w :context.width,
        height: height??46.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        duration: const Duration(
          milliseconds: 600,
        ),
        curve: Curves.easeInOutSine,
        child: Center(
          child: isLoading
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    color: ColorResources.WHITE_COLOR,
                  ),
                )
              : Row(
            mainAxisSize: MainAxisSize.min,
                children: [
                  if(assetIcon != null) customImageIcon(
                      imageName: assetIcon!,
                      color: iconColor,
                      width: 24.w,
                      height: 24.w),
                  if(assetIcon != null)SizedBox(width: 8.w,),

                  if(svgIcon != null) customImageIconSVG(
                      imageName: svgIcon!,
                      color: iconColor,
                      width: 18.w,
                      height: 18.w),
                  if(svgIcon != null)SizedBox(width: 8.w,),
                  Text(text, style: AppTextStyles.w500.copyWith(
                        fontSize: 16,
                        color: textColor??   ColorResources.WHITE_COLOR,
                      ),),
                ],
              ),
        ),
      )
    );
  }
}
