import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/presentation/dashboard/widget/nav_bar_bar.dart';
import 'package:flutter/material.dart';

import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/images.dart';
import '../../app/core/utils/svg_images.dart';
import '../../domain/localization/language_constant.dart';
import '../cart/cart_page.dart';
import '../home/home_page.dart';
import '../profile/profile_page.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({this.index, Key? key}) : super(key: key);
  final int? index;
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late final PageController _pageController = PageController(initialPage:_selectedIndex );
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
    _selectedIndex = widget.index ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACKGROUND_COLOR,
      // bottomNavigationBar: Padding(
      //     padding:  EdgeInsets.only(bottom: 25.h,right: 35.w,left: 35.w),
      //     child: Container(
      //         height: 60.h,
      //         decoration:BoxDecoration(
      //           color: ColorResources.NAV_BAR_BACKGROUND_COLOR,
      //           borderRadius: BorderRadius.circular(100),
      //           boxShadow: const [
      //             BoxShadow(
      //               color: Color.fromRGBO(0, 0, 0, .1),
      //               blurRadius: 0.5,
      //               spreadRadius:0.75,
      //               offset: Offset(0, 2)
      //             )
      //           ],
      //         ),
      //         child: Row(
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Expanded(
      //                 child: BottomNavBarItem(
      //                   imageIcon: Images.logo,
      //                   isSelected: _selectedIndex ==0 ,
      //                   onTap: () => _setPage(0),
      //                   name: getTranslated("home", context),
      //                 ),
      //               ),
      //               Expanded(
      //                 child: BottomNavBarItem(
      //                   svgIcon: SvgImages.cartIcon,
      //                   isSelected: _selectedIndex ==1 ,
      //                   onTap: () => _setPage(1),
      //                   name: getTranslated("cart", context),
      //                 ),
      //               ),
      //               Expanded(
      //                 child: BottomNavBarItem(
      //                   svgIcon: SvgImages.profileIcon,
      //                   isSelected: _selectedIndex ==2 ,
      //                   onTap: () => _setPage(2),
      //                   name: getTranslated("profile", context),
      //
      //                 ),
      //               ),
      //
      //             ]))
      // ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                HomePage(),
                CartPage(),
                ProfilePage(),
              ]),
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
                          svgIcon: SvgImages.profileIcon,
                          isSelected: _selectedIndex == 2,
                          onTap: () => _setPage(2),
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
