import 'package:baber/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import '../../app/core/utils/color_resources.dart';
import 'custom_images.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({required this.title,required this.isSelected,required this.onTab,this.iconSize,
      Key? key, this.icon, this.expand = false})
      : super(key: key);
  final String title;
  final bool isSelected;
  final Function() onTab;
  final String? icon;
  final double? iconSize;
  final bool expand;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  customImageIconSVG(imageName: icon??"",
                      color: isSelected
                          ? ColorResources.WHITE_COLOR
                          : ColorResources.WHITE_COLOR.withOpacity(.5),
                      height:iconSize?.h ,
                      width: iconSize?.w),
                if (icon != null) SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    title,
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      overflow: TextOverflow.fade,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? ColorResources.PRIMARY_COLOR : ColorResources.TITLE,
                    ),
                  ),
                ),
              ],
            ),
            LayoutBuilder(builder: (context, constraints) {
              return Container(
                padding: EdgeInsets.zero,
                width: (expand) ? constraints.maxWidth : 28.w + (title.length * 8),
                height: 4.h,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft:Radius.circular(5) ,
                    topRight: Radius.circular(5) ,
                  ),
                  color: isSelected ? ColorResources.PRIMARY_COLOR : Colors.transparent,
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
