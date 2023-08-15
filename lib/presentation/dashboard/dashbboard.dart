import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/controller/orders_provider.dart';
import 'package:baber/navigation/custom_navigation.dart';
import 'package:baber/presentation/dashboard/widget/nav_bar_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/core/network/netwok_info.dart';
import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/images.dart';
import '../../app/core/utils/svg_images.dart';
import '../../controller/banner_provider.dart';
import '../../controller/city_provider.dart';
import '../../controller/home_categories_provider.dart';
import '../../controller/home_vendors_provider.dart';
import '../../controller/settings_provider.dart';
import '../../domain/localization/language_constant.dart';
import '../cart/cart_page.dart';
import '../home/home_page.dart';
import '../orders/orders_page.dart';
import '../profile/profile_page.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({this.index, Key? key}) : super(key: key);
  final int? index;
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late final PageController _pageController =
      PageController(initialPage: _selectedIndex);
  late int _selectedIndex;
  _setPage(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(
        index,
      );
    });
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      // Provider.of<ProfileProvider>(context, listen: false).getProfileInfo();

      Provider.of<BannerProvider>(
              CustomNavigator.navigatorState.currentContext!,
              listen: false)
          .getBannerList();
      Provider.of<HomeCategoryProvider>(
              CustomNavigator.navigatorState.currentContext!,
              listen: false)
          .getHomeCategories();
      Provider.of<HomeVendorsProvider>(
              CustomNavigator.navigatorState.currentContext!,
              listen: false)
          .getVendorList();
      Provider.of<OrdersProvider>(
              CustomNavigator.navigatorState.currentContext!,
              listen: false)
          .getOrders();
      Provider.of<CityProvider>(CustomNavigator.navigatorState.currentContext!,
              listen: false)
          .getYourCity();
      Provider.of<SettingsProvider>(
              CustomNavigator.navigatorState.currentContext!,
              listen: false)
          .getSettingsInfo();
    });
    _selectedIndex = widget.index ?? 0;
    NetworkInfo.checkConnectivity(onVisible: () async {
      await Provider.of<BannerProvider>(
              CustomNavigator.navigatorState.currentContext!,
              listen: false)
          .getBannerList();
      await Provider.of<HomeCategoryProvider>(
              CustomNavigator.navigatorState.currentContext!,
              listen: false)
          .getHomeCategories();
      await Provider.of<HomeVendorsProvider>(
              CustomNavigator.navigatorState.currentContext!,
              listen: false)
          .getVendorList();
      await Provider.of<CityProvider>(
              CustomNavigator.navigatorState.currentContext!,
              listen: false)
          .getYourCity();
      await Provider.of<OrdersProvider>(
              CustomNavigator.navigatorState.currentContext!,
              listen: false)
          .getOrders();
      await Provider.of<SettingsProvider>(
              CustomNavigator.navigatorState.currentContext!,
              listen: false)
          .getSettingsInfo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACKGROUND_COLOR,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ///Body
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              HomePage(),
              CartPage(),
              OrdersPage(),
              ProfilePage(),
            ],
          ),

          ///Nav
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 25.h),
            child: Container(
                height: 60.h,
                width: 325.w,
                decoration: BoxDecoration(
                  color: ColorResources.NAV_BAR_BACKGROUND_COLOR,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, .1),
                        blurRadius: 0.5,
                        spreadRadius: 0.75,
                        offset: Offset(0, 2))
                  ],
                ),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: BottomNavBarItem(
                          imageIcon: Images.homeLogo,
                          height: 25.h,
                          width: 20.w,
                          isSelected: _selectedIndex == 0,
                          onTap: () => _setPage(0),
                          name: getTranslated("home", context),
                        ),
                      ),
                      Expanded(
                        child: BottomNavBarItem(
                          svgIcon: SvgImages.cartIcon,
                          isSelected: _selectedIndex == 1,
                          onTap: () => _setPage(1),
                          name: getTranslated("cart", context),
                        ),
                      ),
                      Expanded(
                        child: BottomNavBarItem(
                          imageIcon: Images.orders,
                          height: 20.h,
                          width: 20.w,
                          isSelected: _selectedIndex == 2,
                          onTap: () => _setPage(2),
                          name: getTranslated("orders", context),
                        ),
                      ),
                      Expanded(
                        child: BottomNavBarItem(
                          svgIcon: SvgImages.profileIcon,
                          isSelected: _selectedIndex == 3,
                          onTap: () => _setPage(3),
                          name: getTranslated("profile", context),
                        ),
                      ),
                    ])),
          ),
        ],
      ),
    );
  }
}
