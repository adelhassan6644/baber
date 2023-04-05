import 'package:baber/app/core/utils/extensions.dart';
import 'package:baber/app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/dimensions.dart';
import '../../app/core/utils/svg_images.dart';
import '../../navigation/custom_navigation.dart';
import 'custom_images.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final Widget? actionChild;
  final bool showLeading ;

  const CustomAppBar({Key? key, this.title ,this.showLeading = false, this.actionChild}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      decoration:  BoxDecoration(
        border: Border(bottom: BorderSide(
          color: ColorResources.BORDER_COLOR,
          width: 1.h
        )),
      ),padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: context.toPadding,),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              actionChild??const SizedBox(),
            Text(title??"",style: AppTextStyles.w700.copyWith(color: Colors.black,fontSize: 18),),
              SizedBox(width: 115.w,),
              showLeading?  GestureDetector(onTap: ()=>CustomNavigator.pop(),
                  child: customImageIconSVG(imageName: SvgImages.arrowRightIcon,color: Colors.black)):SizedBox(width: 24.w,),
          ],),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL.h),

        ],
      ),
    );
  }

}
