import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/extensions.dart';
import 'package:baber/presentation/orders/widget/order_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../app/core/utils/color_resources.dart';
import '../../controller/firebase_auth_provider.dart';
import '../../controller/orders_provider.dart';
import '../../domain/localization/language_constant.dart';
import '../../navigation/custom_navigation.dart';
import '../../navigation/routes.dart';
import '../base/custom_app_bar.dart';
import '../base/custom_button.dart';
import '../base/empty_widget.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///App bar
        CustomAppBar(title: getTranslated("orders", context)),

        ///Body

        Consumer<FirebaseAuthProvider>(
            builder: (_, firebaseAuthProvider, child) {
          return firebaseAuthProvider.isLogin
              ? Expanded(
                  child: RefreshIndicator(
                      onRefresh: () async {
                        await Provider.of<OrdersProvider>(context,
                                listen: false)
                            .getOrders();
                      },
                      color: ColorResources.PRIMARY_COLOR,
                      child: Consumer<OrdersProvider>(
                        builder: (context, provider, child) {
                          return ListView(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_DEFAULT.h),
                            children: provider.isLoading
                                ? [
                                    SizedBox(height: 24.h),
                                    ...List.generate(
                                      7,
                                      (index) =>
                                          const _CustomShimmerOrderCard(),
                                    ),
                                    SizedBox(height: 80.h),
                                  ]
                                : provider.model?.data != null &&
                                        provider.model != null &&
                                        provider.model?.data?.orders != null
                                    ? [
                                        SizedBox(height: 24.h),
                                        ...List.generate(
                                          provider.model!.data!.orders!.length,
                                          (index) => OrderCardView(
                                              orderItem: provider
                                                  .model!.data!.orders![index]),
                                        ),
                                        SizedBox(height: 80.h),
                                      ]
                                    : [
                                        SizedBox(height: 24.h),
                                        const Center(
                                          child: EmptyWidget(
                                            withEmoji: true,
                                            txt:
                                                "اذهب وابحث عن وجبتك اللذيذة التالية!",
                                          ),
                                        ),
                                        SizedBox(height: 80.h),
                                      ],
                          );
                        },
                      )),
                )
              : Expanded(
                  child: Column(
                  children: [
                    const EmptyWidget(
                      txt: "قم بتسجيل الدخول حتي تستمتع بخدماتنا",
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                          vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                      child: CustomButton(
                          height: 46.h,
                          onTap: () => CustomNavigator.push(Routes.LOGIN,
                              arguments: true),
                          textColor: ColorResources.WHITE_COLOR,
                          text: getTranslated("sign_in", context),
                          backgroundColor: ColorResources.PRIMARY_COLOR),
                    ),
                  ],
                ));
        }),
      ],
    );
  }
}

class _CustomShimmerOrderCard extends StatelessWidget {
  const _CustomShimmerOrderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      enabled: true,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.w),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.w),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, .1),
                    blurRadius: 0.5,
                    spreadRadius: 0.75,
                    offset: Offset(-1, 1))
              ],
              color: ColorResources.WHITE_COLOR,
            ),
            child: SizedBox(
              width: context.width,
              height: 150.h,
            ),
          ),
        ),
      ),
    );
  }
}
