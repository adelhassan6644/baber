import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/main_widgets/grid_list_animator.dart';
import 'package:baber/presentation/vendors/widget/category_selection_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../../app/core/utils/images.dart';
import '../../controller/vendors_provider.dart';
import '../../data/model/item_model.dart';
import '../../domain/localization/language_constant.dart';
import '../../main_widgets/Item_card.dart';
import '../base/custom_app_bar.dart';
import '../base/empty_widget.dart';

class VendorsPage extends StatelessWidget {
  const VendorsPage({required this.categories, Key? key}) : super(key: key);
  final List<ItemModel> categories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: getTranslated("our_dining_table", context),
            withBack: true,
            withSearch: true,
          ),
          CategorySelectionBar(
            categories: categories,
          ),
          Consumer<VendorsProvider>(
            builder: (context, provider, child) {
              return provider.isLoading
                  ? Expanded(
                      child: GridListAnimatorWidget(
                      items: List.generate(
                        8,
                        (int index) {
                          return AnimationConfiguration.staggeredGrid(
                              columnCount: 2,
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: const ScaleAnimation(
                                  child: FadeInAnimation(
                                      child: ItemShimmerCard(
                                fromHome: false,
                                isVendor: true,
                              ))));
                        },
                      ),
                    ))
                  : provider.vendorsModel != null &&
                          provider.vendorsModel!.items != null &&
                          provider.vendorsModel!.items!.isNotEmpty
                      ? Expanded(
                          child: GridListAnimatorWidget(
                          items: List.generate(
                            provider.vendorsModel!.items!.length,
                            (int index) {
                              return AnimationConfiguration.staggeredGrid(
                                  columnCount: 2,
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  child: ScaleAnimation(
                                      child: FadeInAnimation(
                                          child: ItemCard(
                                    fromHome: false,
                                    isVendor: true,
                                    itemModel: provider.vendorsModel!.items![index],
                                  ))));
                            },
                          ),
                        ))
                      : Expanded(
                          child: EmptyWidget(
                          img: Images.emptyDish,
                          imgWidth: 215.w,
                          imgHeight: 220.h,
                          txt: "نعتذر , لا يوجد اسر متاحة الان",
                        ));
            },
          ),
        ],
      ),
    );
  }
}
