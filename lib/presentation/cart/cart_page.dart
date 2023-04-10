import 'package:baber/app/core/utils/color_resources.dart';
import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/text_styles.dart';
import 'package:baber/controller/cart_provider.dart';
import 'package:baber/presentation/cart/widget/cart_item_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/core/utils/images.dart';
import '../../domain/localization/language_constant.dart';
import '../base/custom_app_bar.dart';
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
            return Expanded(
              child: provider.cartList.isEmpty
                  ? EmptyWidget(
                      img: Images.emptyCart,
                      imgWidth: 195.w,
                      imgHeight: 205.h,
                      txt: "عربة التسوق الخاصة بك فارغة",
                      subText: "اذهب وابحث عن وجبتك اللذيذة !😋",
                    )
                  : ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        ...List.generate(
                          provider.cartList.length,
                          (index) => Dismissible(
                            key: Key("${provider.cartList[index]}"),
                            onDismissed: (v) => provider.removeFromCart(
                                index: index, item: provider.cartList[index]),
                            background:Container(
                              color: ColorResources.IN_ACTIVE,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: 50.w,),
                                  Text(getTranslated("delete", context),style: AppTextStyles.w600.copyWith(
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
                                provider.cartList[index].qty = provider.cartList[index].qty! + 1;
                                provider.addToCart(item: provider.cartList[index]);
                              },
                              onDelete: () => provider.removeFromCart(
                                  index: index, item: provider.cartList[index]),
                              item: provider.cartList[index],
                            ),
                          ),
                        )
                      ],
                    ),
            );
          })
        ],
      ),
    );
  }
}
