import 'package:baber/app/core/utils/color_resources.dart';
import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/text_styles.dart';
import 'package:baber/controller/home_categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../controller/vendors_provider.dart';
import '../../../domain/localization/language_constant.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../base/custom_images.dart';
import '../../base/custom_network_image.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeCategoryProvider>(
      builder: (context, categoriesProvider, child) {
        return Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: Dimensions.PADDING_SIZE_DEFAULT.w,
                ),
                Text(
                  getTranslated("sections", context),
                  style: AppTextStyles.w700
                      .copyWith(fontSize: 18, color: ColorResources.TITLE),
                ),
                SizedBox(
                  width: 10.w,
                ),
                customImageIconSVG(
                  imageName: SvgImages.deliciousIcon,
                )
              ],
            ),
            SizedBox(height: 8.0.h),
            Wrap(
                spacing: 14.w,
                runSpacing: 14.h,
                alignment: WrapAlignment.spaceBetween,
                children: List.generate(
                  categoriesProvider.homeCategoryModel != null &&
                          categoriesProvider
                              .homeCategoryModel!.items!.isNotEmpty
                      ? categoriesProvider.homeCategoryModel!.items!.length
                      : 4,
                  (index) => categoriesProvider.homeCategoryModel != null &&
                          categoriesProvider
                              .homeCategoryModel!.items!.isNotEmpty
                      ? InkWell(
                          onTap: () {
                            CustomNavigator.push(Routes.CATEGORIES,
                                arguments: categoriesProvider
                                    .homeCategoryModel!.items);
                            Provider.of<VendorsProvider>(context, listen: false)
                                .setCurrentIndex(index);
                            Provider.of<VendorsProvider>(context, listen: false)
                                .getVendorsByCategory(
                                    id: categoriesProvider
                                        .homeCategoryModel!.items![index].id!);
                          },
                          child: Stack(
                            children: [
                              CustomNetworkImage.containerNewWorkImage(
                                  image: categoriesProvider.homeCategoryModel!
                                          .items![index].image ??
                                      "",
                                  width: 163.h,
                                  height: 80.h,
                                  fit: BoxFit.cover,
                                  radius: 8.w),
                              Positioned(
                                top: 12.h,
                                left: 14.w,
                                child: Text(
                                  categoriesProvider.homeCategoryModel!
                                          .items![index].name ??
                                      "",
                                  style: AppTextStyles.w500.copyWith(
                                      fontSize: 15,
                                      color: ColorResources.WHITE_COLOR),
                                ),
                              ),
                            ],
                          ))
                      : Stack(
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              enabled: true,
                              child: Container(
                                  width: 163.h,
                                  height: 80.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.w),
                                    color: ColorResources.WHITE_COLOR,
                                  )),
                            ),
                            Positioned(
                              top: 24.h,
                              left: 24.w,
                              child: Shimmer.fromColors(
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
                            ),
                          ],
                        ),
                )),
            SizedBox(
              height: 12.h,
            ),
          ],
        );
      },
    );
  }
}
