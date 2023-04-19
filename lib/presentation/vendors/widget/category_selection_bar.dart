import 'package:baber/app/core/utils/color_resources.dart';
import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/vendors_provider.dart';
import '../../../data/model/item_model.dart';

class CategorySelectionBar extends StatefulWidget {
  const CategorySelectionBar({required this.categories, Key? key})
      : super(key: key);
  final List<ItemModel> categories;

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
    return SizedBox(
      width: context.width,
      child: Container(
        decoration:  const BoxDecoration(
            color: ColorResources.WHITE_COLOR,
            border: Border(
                bottom: BorderSide(
                    width: 1,
                    color: ColorResources.BORDER_COLOR))),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Consumer<VendorsProvider>(
            builder: (context, provider, child) {
              return Row(
                children: [
                  ...List.generate(
                    widget.categories.length,
                    (index) {
                      _globalKeys.add(GlobalKey(debugLabel: "$index"));
                      Future.delayed(const Duration(seconds: 1), () {
                        animatedRowScroll(
                            _globalKeys[provider.currentIndex].currentContext!);
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
                            provider.getVendorsByCategory(id: widget.categories[index].id!);
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 50.h,
                                width: 100.w,
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: Center(
                                  child: Text(widget.categories[index].name!,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: provider.currentIndex == index
                                              ? FontWeight.w600
                                              : FontWeight.w500,
                                          color: provider.currentIndex == index
                                              ? ColorResources.PRIMARY_COLOR
                                              : ColorResources.HINT_COLOR)),
                                ),
                              ),
                              Container(
                                height: 3.h,
                                width: 100.w,
                                decoration:   BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft:Radius.circular(10) ,
                                      topRight: Radius.circular(10) ,
                                    ),
                                  color: provider.currentIndex == index
                                      ? ColorResources.PRIMARY_COLOR
                                      : Colors.transparent),
                              ),
                            ],
                          ),
                        );
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
