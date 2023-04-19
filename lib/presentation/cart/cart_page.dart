import 'package:baber/app/core/utils/color_resources.dart';
import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/text_styles.dart';
import 'package:baber/controller/cart_provider.dart';
import 'package:baber/presentation/base/custom_button.dart';
import 'package:baber/presentation/cart/widget/cart_item_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/core/utils/images.dart';
import '../../controller/firebase_auth_provider.dart';
import '../../domain/localization/language_constant.dart';
import '../../navigation/custom_navigation.dart';
import '../../navigation/routes.dart';
import '../base/confirmation_dialog.dart';
import '../base/custom_app_bar.dart';
import '../base/custom_simple_dialog.dart';
import '../base/empty_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({this.fromNav = true, Key? key}) : super(key: key);
  final bool fromNav;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  void initState() {
    Future.delayed(Duration.zero,
        () => Provider.of<CartProvider>(context, listen: false).getCartData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: getTranslated("cart", context),
            withBack: !widget.fromNav,
          ),
          Consumer<CartProvider>(builder: (_, provider, widget) {
            return provider.cartList.isEmpty
                ? Expanded(
                  child: EmptyWidget(
                      img: Images.emptyCart,
                      imgWidth: 195.w,
                      imgHeight: 205.h,
                      txt: "عربة التسوق الخاصة بك فارغة",
                      subText: "اذهب وابحث عن وجبتك اللذيذة !😋",
                    ),
                )
                : Expanded(
                  child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        ...List.generate(
                          provider.cartList.length,
                          (index) =>
                              Dismissible(
                            direction: DismissDirection.startToEnd,
                            key: UniqueKey(),
                            onDismissed: (v) => provider.removeFromCart(
                                // index: index,
                                item: provider.cartList[index]),
                            background: Container(
                              color: ColorResources.IN_ACTIVE,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 50.w,
                                  ),
                                  Text(getTranslated("delete", context),
                                      style: AppTextStyles.w600.copyWith(
                                        color: ColorResources.WHITE_COLOR,
                                        fontSize: 16,
                                      )),
                                ],
                              ),
                            ),
                            child: CartItemCard(
                              onDecrease: () {
                                if (provider.cartList[index].qty! > 1) {
                                  provider.cartList[index].qty =
                                      provider.cartList[index].qty! - 1;
                                  provider.addToCart(
                                      item: provider.cartList[index]);
                                }
                              },
                              onIncrease: () {
                                provider.cartList[index].qty =
                                    provider.cartList[index].qty! + 1;
                                provider.addToCart(
                                    item: provider.cartList[index]);
                              },
                              onDelete: () => provider.removeFromCart(
                                  // index: index,
                                  item: provider.cartList[index]),
                              item: provider.cartList[index],
                            ),
                          ),
                        )
                      ],
                    ),
                );
          }),
          Consumer<CartProvider>(
            builder: (context,provider,widget) {
              return Visibility(
                visible: provider.cartList.isNotEmpty,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                    vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("بيانات الدفع",
                          style: AppTextStyles.w600.copyWith(
                            fontSize: 16,
                          )),
                      SizedBox(height: 12.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("الأجمالى",
                              style: AppTextStyles.w500.copyWith(
                                fontSize: 14,
                                color: ColorResources.DETAILS_COLOR
                              )),
                          Text("${provider.totalSum} ر.س",
                              style: AppTextStyles.w500.copyWith(
                                  fontSize: 14,
                                  color: ColorResources.DETAILS_COLOR
                              )),
                        ],
                      ),
                      SizedBox(height: 24.h,),
                      CustomButton(
                        text: "اتمام الطلب",
                        onTap: () async{
                          if (Provider.of<FirebaseAuthProvider>(context, listen: false)
                              .isLogin) {
                          //  if(provider.cartList.first.store!.active!) {
                          //    provider.openWhatsApp();
                          // }else{
                          //    CustomSnackBar.showSnackBar(
                          //        notification: AppNotification(
                          //            message: "الأسرة غير متاحة الأن",
                          //            isFloating: true,
                          //            backgroundColor: ColorResources.IN_ACTIVE,
                          //            borderColor: Colors.transparent));
                          // }
                             provider.openWhatsApp();


                        } else {
                            Future.delayed(
                                Duration.zero,
                                    () => CustomSimpleDialog.parentSimpleDialog(customListWidget: [
                                  ConfirmationDialog(
                                      txtBtn: "تسجيل",
                                      description: "يجب ان تقوم بالتسجيل اولا حتي تتمكن من اتمام الطلب",
                                      onContinue: () {
                                        CustomNavigator.pop();
                                        CustomNavigator.push(Routes.LOGIN,arguments: true);
                                      })
                                ]));
                          }
                        },
                        assetIcon: Images.whatsApp,
                        isLoading: false,
                        height: 46.h,
                      ),
                    ],
                  ),
                ),
              );
            }
          ),
          if(widget.fromNav)SizedBox(
            height: 80.h,
          ),
        ],
      ),
    );
  }
}
