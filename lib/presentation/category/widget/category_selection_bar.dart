import 'package:baber/app/core/utils/color_resources.dart';
import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../controller/vendors_by_category_provider.dart';
import '../../../data/model/home_model.dart';

class CategorySelectionBar extends StatefulWidget {
  const CategorySelectionBar({required this.categories,Key? key}) : super(key: key);
  final List<HomeCategoryModel> categories;

  @override
  State<CategorySelectionBar> createState() => _CategorySelectionBarState();
}

class _CategorySelectionBarState extends State<CategorySelectionBar> {

  final List<GlobalKey> _globalKeys = [];

  static animatedRowScroll(BuildContext context) {
    Scrollable.ensureVisible(context,
        curve: Curves.ease,
        duration: const Duration(seconds: 1),
        alignment: 0.5);
  }

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: context.width,
      height: 51.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
         physics: const BouncingScrollPhysics(),
        child:  Consumer<VendorsByCategoryProvider>(
          builder: (context, provider, child) {
            return Row(
              children: [
                ...List.generate(
                  widget.categories.length, (index) {
                  _globalKeys.add(GlobalKey(debugLabel: "$index"));
                  Future.delayed(const Duration(seconds: 1), () {
                    animatedRowScroll(_globalKeys[provider.currentIndex].currentContext!);
                  });
                  return InkWell(
                    key: _globalKeys[index],
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      animatedRowScroll(_globalKeys[index].currentContext!);
                      provider.setCurrentIndex(index);
                      provider.getVendorByCategoryList(id: widget.categories[index].id );
                    },
                    child: Container(
                      height: 50,
                      padding:  EdgeInsets.symmetric(horizontal: 12.w),
                      margin:  EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                          border: provider.currentIndex==index ?  Border(
                              bottom: BorderSide(width: 4.h, color: ColorResources.PRIMARY_COLOR))
                              : null),
                      child: Center(
                        child: Text( widget.categories[index].title,
                            style: AppTextStyles.w600.copyWith(
                                fontSize: 14,
                                color:
                                provider.currentIndex==index ? ColorResources.PRIMARY_COLOR : ColorResources.HINT_COLOR)),
                      ),
                    ),
                  );
                },
                )
              ],
            );
          },
        )
       ,
      ),
    );
  }
}
