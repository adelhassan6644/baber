import 'package:baber/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import '../../../data/model/item_model.dart';
import '../../base/chekbox_listtile.dart';

class AddonItem extends StatefulWidget {
  final Addon addon;
  final Function()? onSelect;
  const AddonItem({required this.addon, this.onSelect, Key? key})
      : super(key: key);

  @override
  State<AddonItem> createState() => _AddonItemState();
}

class _AddonItemState extends State<AddonItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
          child: CheckBoxListTile(
            title:widget.addon.name!,
            onChange:(value){setState(() {
              widget.addon.isSelected = value;
            });} ,
            check:widget.addon.isSelected!,
            description: "${widget.addon.price} ر.س",
          ),
        ),
        SizedBox(
          height: 12.h,
        )

      ],
    );
  }
}

