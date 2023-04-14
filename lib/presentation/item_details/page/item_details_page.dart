import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/extensions.dart';
import 'package:baber/app/core/utils/svg_images.dart';
import 'package:baber/controller/cart_provider.dart';
import 'package:baber/controller/item_details_provider.dart';
import 'package:baber/presentation/base/custom_images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../domain/localization/language_constant.dart';
import '../../../main_widgets/item_card.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../base/confirmation_dialog.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/custom_network_image.dart';
import '../../base/custom_simple_dialog.dart';
import '../widget/addon_item.dart';

class ItemDetailsPage extends StatelessWidget {
  const ItemDetailsPage({this.title, Key? key}) : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACKGROUND_COLOR,
      body: Column(
        children: [
          CustomAppBar(
            title: getTranslated("item_details", context),
            withBack: true,
          ),
          Consumer<ItemDetailsProvider>(
            builder: (context, provider, child) {
              return Expanded(
                  child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  ///Item Image
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                    child: provider.isLoading
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            enabled: true,
                            child: Container(
                                width: context.width,
                                height: 185.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.w),
                                  color: ColorResources.WHITE_COLOR,
                                )),
                          )
                        : CustomNetworkImage.containerNewWorkImage(
                            image: provider.item?.image ?? "",
                            height: 185.h,
                            width: context.width,
                            fit: BoxFit.cover,
                            radius: 8.w,
                          ),
                  ),

                  ///Item Name , Category and Quantity
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                        vertical: 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            provider.isLoading
                                ? const TextShimmer()
                                : Text(
                                    provider.item?.menu?.name ?? "",
                                    style: AppTextStyles.w700.copyWith(
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                            // const Expanded(child: SizedBox()),
                            provider.isLoading
                                ? Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    enabled: true,
                                    child: Container(
                                        height: 12.h,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.w),
                                          color: ColorResources.WHITE_COLOR,
                                        )),
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          provider.updateQty(qty: provider.item!.qty! + 1);

                                          Provider.of<CartProvider>(context,
                                                  listen: false)
                                              .isAddedToCart(item: provider.item!);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color:
                                                  ColorResources.PRIMARY_COLOR,
                                              borderRadius:
                                                  BorderRadius.circular(10.w)),
                                          alignment: Alignment.center,
                                          child: const Center(
                                            child: Icon(
                                              Icons.add,
                                              color: ColorResources.WHITE_COLOR,
                                              size: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6.0.w),
                                        child: Container(
                                          width: 28.w,
                                          height: 28.h,
                                          decoration: BoxDecoration(
                                              color: ColorResources.WHITE_COLOR,
                                              border: Border.all(
                                                  color: ColorResources
                                                      .PRIMARY_COLOR,
                                                  width: 0.5.h),
                                              borderRadius:
                                                  BorderRadius.circular(10.w)),
                                          alignment: Alignment.center,
                                          child: Center(
                                            child: Text(
                                              "${provider.item!.qty}",
                                              textAlign: TextAlign.center,
                                              style:
                                                  AppTextStyles.w700.copyWith(
                                                fontSize: 14,
                                                color: ColorResources
                                                    .PRIMARY_COLOR,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (provider.item!.qty! > 1) {
                                            provider.updateQty(
                                                qty: provider.item!.qty! - 1);
                                            Provider.of<CartProvider>(context,
                                                    listen: false).isAddedToCart(item: provider.item!);
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color:
                                                  ColorResources.PRIMARY_COLOR,
                                              borderRadius:
                                                  BorderRadius.circular(10.w)),
                                          alignment: Alignment.center,
                                          child: const Center(
                                            child: Icon(
                                              Icons.remove,
                                              color: ColorResources.WHITE_COLOR,
                                              size: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                          ],
                        ),
                        if (provider.isLoading)
                          SizedBox(
                            height: 10.h,
                          ),
                        provider.isLoading
                            ? const TextShimmer()
                            : Text(
                                provider.item?.name ?? "",
                                maxLines: 2,
                                style: AppTextStyles.w400.copyWith(
                                    fontSize: 12,
                                    color: ColorResources.SUBTITLE,
                                    overflow: TextOverflow.ellipsis),
                              )
                      ],
                    ),
                  ),
                  const Divider(
                    height: 0,
                    color: ColorResources.BORDER_COLOR,
                  ),

                  ///Item Price
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        provider.isLoading
                            ? const TextShimmer()
                            : Expanded(
                                child: Text(
                                  "شاملة لجميع الضرائب",
                                  maxLines: 1,
                                  style: AppTextStyles.w500.copyWith(
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                        provider.isLoading
                            ? TextShimmer(
                                width: 30.w,
                              )
                            : Text(
                                "${provider.item?.price} ر.س",
                                style: AppTextStyles.w700.copyWith(
                                    fontSize: 14,
                                    color: ColorResources.PRIMARY_COLOR),
                              ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 0,
                    color: ColorResources.BORDER_COLOR,
                  ),

                  ///Item Description
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                        vertical: 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        provider.isLoading
                            ? const TextShimmer()
                            : Text(
                                getTranslated("item_description", context),
                                style: AppTextStyles.w700.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                        if (provider.isLoading)
                          SizedBox(
                            height: 10.h,
                          ),
                        provider.isLoading
                            ? TextShimmer(
                                width: context.width,
                              )
                            : Text(
                                provider.item?.body ?? "",
                                maxLines: 2,
                                style: AppTextStyles.w400.copyWith(
                                    fontSize: 12,
                                    color: ColorResources.SUBTITLE,
                                    overflow: TextOverflow.ellipsis),
                              )
                      ],
                    ),
                  ),
                  const Divider(
                    height: 0,
                    color: ColorResources.BORDER_COLOR,
                  ),

                  ///Item Addons
                  Visibility(
                    visible: provider.item?.addons != null &&
                        provider.item!.addons!.isNotEmpty,
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        Dimensions.PADDING_SIZE_DEFAULT.w),
                                child: Text(
                                  getTranslated("addons", context),
                                  style: AppTextStyles.w700.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              ...List.generate(
                                  provider.isLoading
                                      ? 3
                                      : provider.item?.addons?.length ??
                                      0,
                                      (index) => provider.isLoading
                                      ? Padding(
                                        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,vertical: 6.h),
                                        child: Row(
                                          children: [
                                            TextShimmer(width:100.w,height: 20.h,),
                                            const Spacer(),
                                            TextShimmer(width:50.w,height: 20.h,),
                                          ],
                                        ),
                                      )
                                      : AddonItem(
                                    addon: provider
                                        .item!.addons![index],
                                  )),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 0,
                          color: ColorResources.BORDER_COLOR,
                        ),
                      ],
                    ),
                  ),
                ],
              ));
            },
          ),
        ],
      ),

      ///Add to cart Button
      bottomNavigationBar: Consumer<ItemDetailsProvider>(
        builder: (_,itemDetailsProvider,widget) {
          return itemDetailsProvider.isLoading? SafeArea(
             bottom: true,
             child: Padding(
               padding: EdgeInsets.symmetric(
                   horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                   vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
               child: Consumer<CartProvider>(
                 builder: (_, cartProvider, widget) {
                   return Row(
                     children: [
                       Expanded(
                         child: Shimmer.fromColors(
                           baseColor: Colors.grey[300]!,
                           highlightColor: Colors.grey[100]!,
                           enabled: true,
                           child: Container(
                               width: context.width,
                               height: 46.h,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(15.w),
                                 color: ColorResources.WHITE_COLOR,
                               )),
                         )
                       ),
                       SizedBox(
                         width: 12.w,
                       ),
                       Shimmer.fromColors(
                         baseColor: Colors.grey[300]!,
                         highlightColor: Colors.grey[100]!,
                         enabled: true,
                         child: Container(
                             width: 60.h,
                             height: 46.h,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(15.w),
                               color: ColorResources.WHITE_COLOR,
                             )),
                       )
                     ],
                   );
                 },
               ),
             ),
           ) :
          SafeArea(
             bottom: true,
             child: Padding(
               padding: EdgeInsets.symmetric(
                   horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                   vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
               child: Consumer<CartProvider>(
                 builder: (_, cartProvider, widget) {
                      return Row(
                     children: [
                       Expanded(
                         child: CustomButton(
                             isLoading: false,
                             height: 46.h,
                             onTap: () {
                               if (cartProvider.cartList.isEmpty) {
                                 cartProvider.addToCart(item: itemDetailsProvider.item!,);
                                 CustomSnackBar.showSnackBar(
                                     notification: AppNotification(
                                         message: "تم الإضافة إلي السلة",
                                         isFloating: true,
                                         backgroundColor: ColorResources.ACTIVE,
                                         borderColor: Colors.transparent));
                               }
                               else {
                                 if (cartProvider.checkStore(item: itemDetailsProvider.item!,)) {
                                   cartProvider.addToCart(item: itemDetailsProvider.item!,);
                                   CustomSnackBar.showSnackBar(
                                       notification: AppNotification(
                                           message: "تم التحديث في السلة",
                                           isFloating: true,
                                           backgroundColor: ColorResources.ACTIVE,
                                           borderColor: Colors.transparent));
                                 }
                                 else {Future.delayed(
                                     Duration.zero, () => CustomSimpleDialog.parentSimpleDialog(
                                     customListWidget: [
                                       ConfirmationDialog(
                                           txtBtn: "نعم,أضف الطلب",
                                           description: "سوف يتم ازالة جميع الطلبات الموجودة في السلة",
                                           onContinue: () {
                                             CustomNavigator.pop();
                                             cartProvider.clearCartList();
                                             cartProvider.addToCart(item: itemDetailsProvider.item!,);
                                             CustomSnackBar.showSnackBar(notification: AppNotification(
                                                 message:"تم إضافة الطلب الجديد إلي السلة",
                                                 isFloating: true,
                                                 backgroundColor: ColorResources.ACTIVE,
                                                 borderColor: Colors.transparent));
                                           }
                                       )
                                     ]));}
                               }
                             },
                             textColor: ColorResources.WHITE_COLOR,
                             text: cartProvider.isAdded
                                 ? getTranslated("update_cart", context)
                                 : getTranslated("add_to_cart", context),
                             backgroundColor: cartProvider.isAdded ?
                             ColorResources.ACTIVE : ColorResources.PRIMARY_COLOR),
                       ),
                       SizedBox(
                         width: 12.w,
                       ),
                       GestureDetector(
                         onTap: () => CustomNavigator.push(Routes.CART,replace: true),
                         child: Container(
                           width: 60.h,
                           height: 46.h,
                           decoration: BoxDecoration(
                               color: ColorResources.WHITE_COLOR,
                               borderRadius: BorderRadius.circular(15.w),
                               boxShadow: const [
                                 BoxShadow(
                                     color: Color.fromRGBO(0, 0, 0, .1),
                                     blurRadius: 0.05,
                                     spreadRadius: 0.05,
                                     offset: Offset(0, 1))
                               ],
                               border: Border.all(
                                   color: ColorResources.LIGHT_GREY_BORDER)),
                           child: Center(
                             child: Stack(
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.all(10.0),
                                   child: customImageIconSVG(
                                     imageName: SvgImages.cartIcon,
                                     color: ColorResources.PRIMARY_COLOR,
                                   ),
                                 ),
                                 Visibility(
                                   visible: cartProvider.cartList.isNotEmpty,
                                   child: Positioned(
                                     right: 8.w,
                                     top: 5.h,
                                     child: Container(
                                       height: 13.h,
                                       padding: EdgeInsets.symmetric(
                                         horizontal: 4.w,
                                       ),
                                       decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(
                                               50),
                                           color: ColorResources.FAILED_COLOR),
                                       child: Center(
                                         child: Text(
                                           cartProvider.cartList.length.toString(),
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
                       )
                     ],
                   );
                 },
               ),
             ),
           );
        }
      ),
    );
  }
}
