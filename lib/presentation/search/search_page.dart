import 'dart:async';

import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/extensions.dart';
import 'package:baber/app/core/utils/svg_images.dart';
import 'package:baber/controller/search_provider.dart';
import 'package:baber/domain/localization/language_constant.dart';
import 'package:baber/navigation/custom_navigation.dart';
import 'package:baber/presentation/base/custom_images.dart';
import 'package:baber/presentation/base/empty_widget.dart';
import 'package:baber/presentation/base/tab_widget.dart';
import 'package:baber/presentation/search/widgets/search_item_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/images.dart';
import '../../app/core/utils/text_styles.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Timer? timer;
  List<String> tabs = ["products", "vendors"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<SearchProvider>(
      builder: (_, provider, widget) {
        return Column(
          children: [
            Container(
              height: context.toPadding + 60,
              alignment: Alignment.bottomCenter,
              color: ColorResources.WHITE_COLOR,
              child: TextFormField(
                onChanged: (v) {
                  if (timer != null) if (timer!.isActive) timer!.cancel();
                  timer = Timer(const Duration(milliseconds: 100), () {
                    provider.getSearchResult(q: v);
                  });
                },
                // onTap: () => provider.getSearchResult(),
                cursorColor: ColorResources.PRIMARY_COLOR,
                onFieldSubmitted: (v) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  provider.getSearchResult(q: v);
                },
                textInputAction: TextInputAction.search,
                autofocus: true,
                decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: GestureDetector(
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 22,
                        ),
                        onTap: () => CustomNavigator.pop()),
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: customImageIconSVG(
                        imageName: SvgImages.searchIcon, color: Colors.black),
                  ),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  )),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                          style: BorderStyle.none)),
                  disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                          style: BorderStyle.none)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.w, horizontal: 24.h),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 0,
                        style: BorderStyle.none),
                  ),
                  hintText: getTranslated("search", context),
                  hintStyle: AppTextStyles.w400
                      .copyWith(color: ColorResources.HINT_COLOR, fontSize: 11),
                  fillColor: ColorResources.FILL_COLOR,
                  filled: true,
                  prefixIconConstraints: BoxConstraints(maxHeight: 25.h),
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            // provider.searchResult != null ?
            if (provider.searchResult == null)
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 100.h,
                    ),
                    EmptyWidget(
                      img: Images.emptySearch,
                      txt: "",
                      spaceBtw: 0,
                      subText: "ابحث هنا عن وجبتك او مطعمك المفضل ",
                      imgHeight: 85.h,
                      imgWidth: 135.w,
                    ),
                  ],
                ),
              ),
            if (provider.searchResult != null)
              Container(
                color: ColorResources.WHITE_COLOR,
                child: Row(
                    children: List.generate(
                        tabs.length,
                        (index) => Expanded(
                                child: TabWidget(
                              title: getTranslated(tabs[index], context),
                              isSelected: provider.currentIndex == index,
                              onTab: () =>
                                  provider.setCurrentIndex(index: index),
                              expand: true,
                            )))),
              ),
            if (provider.searchResult != null)
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: provider.currentIndex == 0
                      ? provider.searchResult!.products!.isNotEmpty
                          ? List.generate(
                              provider.searchResult!.products!.length,
                              (index) => SearchItemCard(
                                    item:
                                        provider.searchResult!.products![index],
                                    isVendor: false,
                                  ))
                          : [
                              SizedBox(
                                height: 100.h,
                              ),
                              EmptyWidget(
                                img: Images.emptySearch,
                                txt: "لم يتم العثور علي نتائج!",
                                subText: "ابحث هنا مجددا عن وجبتك الذيذة 😋",
                                imgHeight: 85.h,
                                imgWidth: 135.w,
                              ),
                            ]
                      : provider.searchResult!.vendors!.isNotEmpty
                          ? List.generate(
                              provider.searchResult!.vendors!.length,
                              (index) => SearchItemCard(
                                    item:
                                        provider.searchResult!.vendors![index],
                                  ))
                          : [
                              SizedBox(
                                height: 100.h,
                              ),
                              EmptyWidget(
                                img: Images.emptySearch,
                                txt: "لم يتم العثور علي نتائج!",
                                subText: "ابحث هنا مجددا عن وجبتك الذيذة 😋",
                                imgHeight: 85.h,
                                imgWidth: 135.w,
                              )
                            ],
                ),
              ),
          ],
        );
      },
    ));
  }
}
