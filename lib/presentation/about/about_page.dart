import 'package:baber/app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import '../../../domain/localization/language_constant.dart';
import '../../app/core/utils/text_styles.dart';
import '../base/custom_app_bar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: getTranslated("about_baber", context),
            withBack: true,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Text(
                      "Your order is on the way, Get ready!Your order is on the way, Get ready!Your order is on the way, Get ready!Your order is on the way, Get ready!Your order is on the way, Get ready!",
                      textAlign: TextAlign.start,style: AppTextStyles.w500.copyWith(
                    fontSize: 16,
                  )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
