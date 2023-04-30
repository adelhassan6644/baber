import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/domain/localization/language_constant.dart';
import 'package:flutter/material.dart';
import '../../../presentation/base/image_widget.dart';
import '../utils/images.dart';
import '../utils/text_styles.dart';

class CheckConnectionDialog extends StatelessWidget {
  const CheckConnectionDialog(
      {required this.isConnected,
      Key? key})
      : super(key: key);
final bool isConnected;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isConnected? ImageWidget.assets(Images.connected,
            height: 90, width: 90, color: Colors.green):
        ImageWidget.assets(Images.noConnection,
            height: 90, width: 90, color: Colors.red),
        SizedBox(
          height: 16.h,
        ),
        Text(
          getTranslated( isConnected?"connected":"no_connection", context),
          textAlign: TextAlign.center,
          style: AppTextStyles.w400.copyWith(
            fontSize: 14,
            // color: ColorResources.DETAILS_COLOR
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
      ],
    );
  }
}
