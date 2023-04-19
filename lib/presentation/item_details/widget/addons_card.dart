import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/svg_images.dart';
import 'package:baber/presentation/base/custom_images.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../data/model/item_model.dart';
import '../../base/custom_network_image.dart';

class AddonCard extends StatefulWidget {
  final Addon addon;
  final Function()? onSelect;
  const AddonCard({required this.addon, this.onSelect, Key? key})
      : super(key: key);

  @override
  State<AddonCard> createState() => _AddonCardState();
}

class _AddonCardState extends State<AddonCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              widget.addon.isSelected = !widget.addon.isSelected!;
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomNetworkImage.containerNewWorkImage(
                  image: widget.addon.image ?? "",
                  height: 70.h,
                  width: 70.w,
                  fit: BoxFit.cover,
                  radius: 8.w,
                  imageWidget: Container(
                    height: 70.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.w),
                        color: widget.addon.isSelected!
                            ? ColorResources.PRIMARY_COLOR.withOpacity(0.2)
                            : Colors.transparent),
                  )),
              SizedBox(height: 8.h),
              Row(
                children: [
                  if (widget.addon.isSelected!)
                    customImageIconSVG(
                        imageName: SvgImages.tickCircleIcon,
                        width: 16.w,
                        height: 16.w,
                        color: ColorResources.PRIMARY_COLOR),
                  SizedBox(width: 2.w),

                  Column(
                    children: [
                      Text(widget.addon.name ?? "",
                          textAlign: TextAlign.start,
                          style: AppTextStyles.w500.copyWith(
                              fontSize: 12,
                              color: widget.addon.isSelected!
                                  ? ColorResources.PRIMARY_COLOR
                                  : Colors.black)),
                      Text("${widget.addon.price} ر.س",
                          textAlign: TextAlign.start,
                          style: AppTextStyles.w500.copyWith(
                              fontSize: 12,
                              height: 1,
                              color: widget.addon.isSelected!
                                  ? ColorResources.PRIMARY_COLOR
                                  : ColorResources.SUBTITLE)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          width: Dimensions.PADDING_SIZE_DEFAULT.w,
        )
      ],
    );
  }
}

class AddonsCardShimmer extends StatelessWidget {
  const AddonsCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              enabled: true,
              child: Container(
                  height: 70.h,
                  width: 70.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    color: ColorResources.WHITE_COLOR,
                  )),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              enabled: true,
              child: Container(
                  height: 12.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    color: ColorResources.WHITE_COLOR,
                  )),
            ),
          ],
        ),
        SizedBox(
          width: Dimensions.PADDING_SIZE_DEFAULT.w,
        )
      ],
    );
  }
}
