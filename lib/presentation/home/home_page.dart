import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/presentation/home/widget/banner_view.dart';
import 'package:baber/presentation/home/widget/categories_section.dart';
import 'package:baber/presentation/home/widget/home_app_bar.dart';
import 'package:baber/presentation/home/widget/our_table.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children:   [
        const HomeAppBar(),
        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT.h,),
        const BannersView(),
        const CategoriesSection(),
        const OurTable(),
        SizedBox(height: 85.h,)],
    );
  }
}
