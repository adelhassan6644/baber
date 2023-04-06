import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/presentation/category/widget/category_selection_bar.dart';
import 'package:baber/presentation/main_widgets/Item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../../controller/vendors_by_category_provider.dart';
import '../../data/model/home_model.dart';
import '../../domain/localization/language_constant.dart';
import '../base/custom_app_bar.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({required this.categories, Key? key}) : super(key: key);
  final List<HomeCategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: getTranslated("sections", context),
            showLeading: true,
          ),
          CategorySelectionBar(
            categories: categories,
          ),
          Consumer<VendorsByCategoryProvider>(
            builder: (context, provider, child) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                  child: GridView.count(
                    padding: EdgeInsets.only(top: 6.h),
                    crossAxisCount: 2,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    addAutomaticKeepAlives: true,
                    mainAxisSpacing: 8.h,
                    childAspectRatio: 0.957,
                    crossAxisSpacing: 15.w,
                    children: List.generate(
                      provider.vendorsByCategoryList != null &&
                              provider.vendorsByCategoryList!.isNotEmpty
                          ? provider.vendorsByCategoryList!.length
                          : 8,
                      (int index) {
                        return AnimationConfiguration.staggeredGrid(
                            columnCount: 2,
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: ScaleAnimation(
                                child: FadeInAnimation(
                                    child: (provider.vendorsByCategoryList !=
                                                null &&
                                            provider.vendorsByCategoryList!
                                                .isNotEmpty)
                                        ? ItemCard(
                                            fromHome: false,
                                            isVendor: true,
                                            itemModel: provider
                                                .vendorsByCategoryList![index],
                                          )
                                        : const ItemShimmerCard(
                                            fromHome: false,
                                            isVendor: true,
                                          ))));
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
