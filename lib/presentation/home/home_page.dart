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
import '../../data/model/City_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    City? city;

    Future.delayed(Duration.zero, (){
      Provider.of<BannerProvider>(context, listen: false).getBannerList();
      Provider.of<HomeCategoryProvider>(context, listen: false).getHomeCategories();
      Provider.of<CityProvider>(context, listen: false).getYourCity();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         const HomeAppBar(),
        SizedBox(
          height: Dimensions.PADDING_SIZE_DEFAULT.h,
        ),
        const BannersView(),
        const CategoriesSection(),
        const OurTable(),
        SizedBox(
          height: 85.h,
        )
      ],
    );
  }
}
