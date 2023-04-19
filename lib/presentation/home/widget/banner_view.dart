import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/extensions.dart';
import 'package:baber/presentation/base/custom_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../controller/banner_provider.dart';
import '../../../controller/item_details_provider.dart';
import '../../../controller/products_provider.dart';
import '../../../controller/vendor_provider.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';

class BannerView extends StatelessWidget {
  const BannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BannerProvider>(
      builder: (context, bannerProvider, child) {
        return bannerProvider.bannerModel != null &&
                bannerProvider.bannerModel!.banners != null &&
                bannerProvider.bannerModel!.banners!.isNotEmpty
            ? Column(
                children: [
                  CarouselSlider.builder(
                    options: CarouselOptions(
                      viewportFraction: 0.83,
                      autoPlay: true,
                      height: 165.h,
                      enlargeCenterPage: true,
                      disableCenter: true,
                      onPageChanged: (index, reason) {
                        bannerProvider.setCurrentIndex(index);
                      },
                    ),
                    itemCount: bannerProvider.bannerModel!.banners!.length,
                    itemBuilder: (context, index, _) {
                      return GestureDetector(
                        onTap: () {
                          if (bannerProvider
                                  .bannerModel!.banners![index].type ==
                              "store") {
                            Provider.of<VendorProvider>(context, listen: false)
                                .getVendorDetails(
                                    id: bannerProvider.bannerModel!
                                            .banners![index].store!.id ??
                                        "");
                            Provider.of<ProductsProvider>(context,
                                    listen: false)
                                .getProductsByMenu(
                                    menuId: bannerProvider.bannerModel!
                                        .banners![index].store!.menus!.first.id
                                        .toString());
                            Provider.of<VendorProvider>(context, listen: false)
                                .currentIndex = 0;
                            CustomNavigator.push(
                              Routes.VENDOR,
                            );
                          } else if (bannerProvider
                                  .bannerModel!.banners![index].type ==
                              "product") {
                            Provider.of<ItemDetailsProvider>(context,
                                    listen: false)
                                .getItemDetails(
                                    id: bannerProvider.bannerModel!
                                            .banners![index].productId ??
                                        "");
                            CustomNavigator.push(Routes.ITEM_DETAILS,
                                arguments: "تفاصيل المنتج");
                          } else {
                            return;
                          }
                        },
                        child: CustomNetworkImage.containerNewWorkImage(
                          image: bannerProvider
                              .bannerModel!.banners![index].image!,
                          width: context.width,
                          height: 165.h,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorResources.WHITE_COLOR,
                      borderRadius: BorderRadius.circular(100.w),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.5.h),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          bannerProvider.bannerModel!.banners!.map((banner) {
                        int index = bannerProvider.bannerModel!.banners!
                            .indexOf(banner);
                        return TabPageSelectorIndicator(
                          backgroundColor: index == bannerProvider.currentIndex
                              ? ColorResources.PRIMARY_COLOR
                              : ColorResources.WHITE_COLOR,
                          borderColor: Theme.of(context).primaryColor,
                          size: 10,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              )
            : Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  enabled: true,
                  child: Container(
                      width: context.width,
                      height: 165.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.w),
                        color: ColorResources.WHITE_COLOR,
                      )),
                ),
              );
      },
    );
  }
}
