import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import '../../app/core/utils/svg_images.dart';
import '../../navigation/custom_navigation.dart';
import '../../navigation/routes.dart';
import '../base/custom_images.dart';

class CustomStackAppBar extends StatelessWidget {
  const CustomStackAppBar({ this.withCart =false, Key? key}) : super(key: key);
  final bool withCart ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical:Dimensions.PADDING_SIZE_DEFAULT.h,horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      child: Column(
        children: [
          SizedBox(height: context.toPadding,),
          Row(
            children: [
              if(withCart)  GestureDetector(onTap: ()=>CustomNavigator.push(Routes.CART), child: customImageIconSVG(imageName: SvgImages.stackCartIcon,)),
              const Expanded(child: SizedBox()),
              GestureDetector(onTap: ()=>CustomNavigator.pop(),
                  child: customImageIconSVG(imageName: SvgImages.backIcon)),
            ],
          ),
        ],
      ),
    );
  }
}
