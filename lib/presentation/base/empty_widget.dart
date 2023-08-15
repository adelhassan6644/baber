import 'package:baber/app/core/utils/color_resources.dart';
import 'package:baber/app/core/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';

import '../../app/core/utils/images.dart';
import '../../app/core/utils/svg_images.dart';
import 'custom_images.dart';

class EmptyWidget extends StatelessWidget {
  final String? img;
  final double? imgHeight;
  final double? emptyHeight;
  final double? imgWidth;
  final bool isSvg;
  final bool withEmoji;
  final double? spaceBtw;
  final String? txt;
  final String? subText;

  const EmptyWidget({
    Key? key,
    this.emptyHeight,
    this.spaceBtw,
    this.isSvg = false,
    this.withEmoji = false,
    this.img,
    this.imgHeight,
    this.imgWidth,
    this.txt,
    this.subText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: emptyHeight, // MediaQueryHelper.height - remain!,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              !isSvg
                  ? customImageIcon(
                      imageName: img ?? Images.emptyDish,
                      width: imgWidth ?? 215.w,
                      height: imgHeight ??
                          220.h) //width: MediaQueryHelper.width*.8,),
                  : customImageIconSVG(imageName: img ?? Images.emptyDish),
              SizedBox(height: spaceBtw ?? 35.h),
              Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(txt ?? "نعتذر , لا يوجد اسر الان !",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    if (withEmoji)
                      SizedBox(
                        width: 10.w,
                      ),
                    if (withEmoji)
                      customImageIconSVG(
                        imageName: SvgImages.deliciousIcon,
                      )
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Text(subText ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14,
                      color: ColorResources.DETAILS_COLOR,
                      fontWeight: FontWeight.w400))
            ],
          ),
        ),
      ),
    );
  }
}
