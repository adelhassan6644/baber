import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import '../../../domain/localization/language_constant.dart';
import '../../controller/settings_provider.dart';
import '../../main_widgets/Item_card.dart';
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
          Consumer<SettingsProvider>(
            builder: (BuildContext context, provider, Widget? child) {
              return provider.isLoading
                  ? Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: List.generate(7,
                          (index) => Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal:
                            Dimensions.PADDING_SIZE_DEFAULT.w),
                        child: TextShimmer(width: context.width,height: 20.h,),
                      )),
                ),
              )
                  :    Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Html(
                        data: provider.settingsModel!.about??"",
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
