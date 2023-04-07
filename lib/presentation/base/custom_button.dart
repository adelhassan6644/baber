import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/extensions.dart';
import 'package:baber/app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../app/core/utils/color_resources.dart';
import 'custom_images.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final String? svgIcon;
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
      this.isLoading = false,
       this.textColor = ColorResources.WHITE_COLOR,
      this.width,
      this.iconColor =ColorResources.WHITE_COLOR,
      required this.text,
       this.backgroundColor=ColorResources.PRIMARY_COLOR,  this.isError=false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: isError?[const ShakeEffect(), ]:[],
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          width: isLoading ? 90.w :context.width,
          height: height??55.h,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
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
                      backgroundColor: Colors.white,
                      color: ColorResources.WHITE_COLOR,
                    ),
                  )
                : Row(
              mainAxisSize: MainAxisSize.min,
                  children: [
                    if(svgIcon != null) customImageIconSVG(
                        imageName: svgIcon!,
                        color: iconColor,
                        width: 18.w,
                        height: 16.w),
                    if(svgIcon != null)SizedBox(width: 8.w,),
                    Text(text, style: AppTextStyles.w500.copyWith(
                          fontSize: 16,
                          color: onTap == null
                              ? ColorResources.DISABLED
                              : Colors.white,
                        ),),
                  ],
                ),
          ),
        ).animate(target:  isLoading ? 1 : 0)
           .scaleXY(end: .8).flip(end: 1),

      ).animate().fade(),
    );
  }
}
