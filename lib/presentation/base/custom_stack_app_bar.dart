import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/svg_images.dart';
import '../../app/core/utils/text_styles.dart';
import '../../controller/cart_provider.dart';
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
              if(withCart)  Consumer<CartProvider>(
                builder: (_, provider, widget) {
                  return GestureDetector(
                    onTap: () => CustomNavigator.push(Routes.CART),
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorResources.WHITE_COLOR,
                          borderRadius: BorderRadius.circular(150.w),
                          border: Border.all(color: ColorResources.LIGHT_GREY_BORDER)),
                      child: Center(
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customImageIconSVG(
                                imageName: SvgImages.cartIcon,
                                height: 20,
                                width: 20,
                                color: ColorResources.PRIMARY_COLOR,
                              ),
                            ),
                            Visibility(
                              visible: provider.cartList.isNotEmpty,
                              child: Positioned(
                                right: 4.w,
                                top: 4.h,
                                child: Container(
                                  height: 13.h,
                                  padding:  EdgeInsets.symmetric(horizontal: 4.w,),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: ColorResources.FAILED_COLOR),
                                  child: Center(
                                    child: Text(
                                      provider.cartList.length.toString(),
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.w500.copyWith(
                                        fontSize: 10,
                                        height: 1.3,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
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
