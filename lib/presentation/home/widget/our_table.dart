import 'package:baber/app/core/utils/color_resources.dart';
import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../controller/home_vendor_provider.dart';
import '../../../domain/localization/language_constant.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../base/custom_network_image.dart';
import '../../main_widgets/Item_card.dart';

class OurTable extends StatelessWidget {
  const OurTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeVendorProvider>(
      builder: (context, vendorProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              child: Text(
                getTranslated("our_dining_table", context),
                style: AppTextStyles.w700
                    .copyWith(fontSize: 18, color: ColorResources.TITLE),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  SizedBox(width: 24.w),
                  ...List.generate(
                    vendorProvider.homeVendorList != null && vendorProvider.homeVendorList!.isNotEmpty
                        ? vendorProvider.homeVendorList!.length
                        : 4,
                    (index) => vendorProvider.homeVendorList != null &&
                            vendorProvider.homeVendorList!.isNotEmpty
                        ? Row(
                            children: [
                              const ItemCard(
                                fromHome: true,
                              ),
                              SizedBox(
                                width: Dimensions.PADDING_SIZE_DEFAULT.w,
                              )
                            ],
                          )
                        : Row(
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                enabled: true,
                                child:  ClipRRect(
                                  borderRadius: BorderRadius.circular(8.w),

                                  child: Padding(
                                    padding:  EdgeInsets.symmetric(vertical:8.h),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.w),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Color.fromRGBO(0, 0, 0, .1),
                                              blurRadius: 0.5,
                                              spreadRadius:0.75,
                                              offset: Offset(-1, 1)
                                          )
                                        ],
                                        color: ColorResources.WHITE_COLOR,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Card Image
                                         SizedBox(
                                            height:90.h,
                                            width:130.w,
                                          ),
                                          // Text Content
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal:12.w ,vertical:6.h),
                                            child: Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  // Meal name
                                                  Shimmer.fromColors(
                                                    baseColor: Colors.grey[300]!,
                                                    highlightColor: Colors.grey[100]!,
                                                    enabled: true,
                                                    child: Container(
                                                        width: 60.h,
                                                        height: 10.h,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(8.w),
                                                          color: ColorResources.WHITE_COLOR,
                                                        )),
                                                  ),
                                                  Shimmer.fromColors(
                                                    baseColor: Colors.grey[300]!,
                                                    highlightColor: Colors.grey[100]!,
                                                    enabled: true,
                                                    child: Container(
                                                        width: 130.h,
                                                        height: 8.h,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(8.w),
                                                          color: ColorResources.WHITE_COLOR,
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Dimensions.PADDING_SIZE_DEFAULT.w,
                              )
                            ],
                          ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
