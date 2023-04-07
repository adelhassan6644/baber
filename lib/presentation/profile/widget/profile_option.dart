import 'package:baber/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/text_styles.dart';
import '../../base/custom_images.dart';


class ProfileOption extends StatelessWidget {
  const ProfileOption(
      {Key? key,
      required this.onTap,
      required this.title,
      required this.iconName,
      this.iconColor = Colors.black,
      this.txtColor = Colors.black,
      this.showDivider = true,
      this.showIcon = true})
      : super(key: key);
  final Function() onTap;
  final String iconName, title;
  final Color iconColor, txtColor;
  final bool showDivider, showIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            onTap: onTap,
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,),
            leading:
                customImageIconSVG(
                    imageName: iconName,
                    color: iconColor,
                    width: 24.w,
                    height: 24.w),
            minLeadingWidth: 24.w,
            title: Text(title,
                style:
                    AppTextStyles.w500.copyWith(fontSize: 14, color: txtColor)),
            trailing: Visibility(
                visible: showIcon, child: const Icon(Icons.arrow_forward_ios,size: 14,))),
        if (showDivider)
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: const Divider(height: 0)),
      ],
    );
  }
}
