import 'package:baber/app/core/utils/color_resources.dart';
import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/presentation/home/widget/banner_view.dart';
import 'package:baber/presentation/home/widget/categories_section.dart';
import 'package:baber/presentation/home/widget/home_app_bar.dart';
import 'package:baber/presentation/home/widget/our_table.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/banner_provider.dart';
import '../../controller/city_provider.dart';
import '../../controller/home_categories_provider.dart';
import '../../controller/home_vendors_provider.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         const HomeAppBar(),
        Expanded(
          child: RefreshIndicator(
            onRefresh: ()async{
                Future.delayed(Duration.zero, (){
                  Provider.of<BannerProvider>(context, listen: false).getBannerList();
                  Provider.of<HomeCategoryProvider>(context, listen: false).getHomeCategories();
                  Provider.of<HomeVendorsProvider>(context, listen: false).getVendorList();
                  Provider.of<CityProvider>(context, listen: false).getYourCity();
                });
            },
            color: ColorResources.PRIMARY_COLOR,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
              const BannerView(),
              const CategoriesSection(),
              const OurTable(),
              SizedBox(
                height: 85.h,
              )
            ],),
          ),
        )

      ],
    );
  }
}
