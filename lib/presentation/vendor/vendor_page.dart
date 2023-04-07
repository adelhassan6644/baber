import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/extensions.dart';
import 'package:baber/app/core/utils/text_styles.dart';
import 'package:baber/presentation/base/custom_network_image.dart';
import 'package:baber/main_widgets/grid_list_animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/images.dart';
import '../../controller/vednor_prvider.dart';
import '../../main_widgets/Item_card.dart';
import '../base/custom_stack_app_bar.dart';
import '../base/empty_widget.dart';

class VendorPage extends StatelessWidget {
  const VendorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACKGROUND_COLOR,
      body: Consumer<VendorProvider>(
        builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomNetworkImage.containerNewWorkImage(
                  image: provider.vendor?.image ?? "",
                  radius: 0,
                  width: context.width,
                  height: 250.h,
                  imageWidget: const CustomStackAppBar(
                    withCart: true,
                  )),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                    vertical: Dimensions.PADDING_SIZE_SMALL.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    provider.isLoading?Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      enabled: true,
                      child: Container(
                        width: 80.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),),
                      ),
                    ):
                    Text(
                      provider.vendor?.title ?? "Baber",
                      style: AppTextStyles.w600.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    provider.isLoading?Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      enabled: true,
                      child: Container(
                        width: 150.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),),
                      ),
                    ):  Text(
                      provider.vendor?.address ?? "الرياض",
                      style: AppTextStyles.w500.copyWith(
                        fontSize: 11,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1.h,
                color: ColorResources.BORDER_COLOR,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Dimensions.PADDING_SIZE_SMALL.h),
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Dimensions.PADDING_SIZE_DEFAULT.w,
                        ),
                        ...List.generate(
                          provider.isLoading?5 : provider.vendor?.menus?.length ?? 6,
                          (index) {
                            return
                              Padding(
                              padding: EdgeInsets.only(
                                  left: Dimensions.PADDING_SIZE_DEFAULT.w),
                              child:
                             provider.isLoading?Shimmer.fromColors(
                               baseColor: Colors.grey[300]!,
                               highlightColor: Colors.grey[100]!,
                               enabled: true,
                               child: Container(
                            width: 80.w,
                                 height: 27.h,
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(100),),
                               ),
                             ) : InkWell(
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () => provider.setCurrentIndex(index),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          color: ColorResources.PRIMARY_COLOR,
                                          width: 1.h),
                                      color: provider.currentIndex == index
                                          ? ColorResources.PRIMARY_COLOR
                                          : null),
                                  child: Text(
                                      provider.vendor?.menus?[index].title ??
                                          "Babar",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight:
                                              provider.currentIndex == index
                                                  ? FontWeight.w600
                                                  : FontWeight.w400,
                                          color: provider.currentIndex == index
                                              ? ColorResources.WHITE_COLOR
                                              : ColorResources.PRIMARY_COLOR)),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    )),
              ),
              Divider(
                height: 1.h,
                color: ColorResources.BORDER_COLOR,
              ),
              provider.isLoading
                  ? Expanded(
                      child: GridListAnimatorWidget(
                        items: List.generate(
                          8,
                          (int index) {
                            return AnimationConfiguration.staggeredGrid(
                                columnCount: 2,
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                child: const ScaleAnimation(
                                    child: FadeInAnimation(
                                        child: ItemShimmerCard(
                                  fromHome: false,
                                  isVendor: true,
                                ))));
                          },
                        ),
                      ),
                    )
                  : provider.vendor?.menus?[provider.currentIndex].product !=
                              null &&
                          provider.vendor!.menus![provider.currentIndex]
                              .product!.isNotEmpty
                      ? Expanded(
                          child: GridListAnimatorWidget(
                            aspectRatio: 0.8216,
                            items: List.generate(
                              provider.vendor!.menus![provider.currentIndex]
                                  .product!.length,
                              (int index) {
                                return AnimationConfiguration.staggeredGrid(
                                    columnCount: 2,
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    child: ScaleAnimation(
                                        child: FadeInAnimation(
                                            child: ItemCard(
                                      fromHome: false,
                                      isVendor: false,
                                      itemModel: provider
                                          .vendor
                                          ?.menus?[provider.currentIndex]
                                          .product?[index],
                                    ))));
                              },
                            ),
                          ),
                        )
                      : Expanded(
                          child: EmptyWidget(
                          img: Images.emptyDish,
                          imgWidth: 215.w,
                          imgHeight: 220.h,
                          txt: "نعتذر , لا يوجد اصناف الان",
                        ))
            ],
          );
        },
      ),
    );
  }
}
