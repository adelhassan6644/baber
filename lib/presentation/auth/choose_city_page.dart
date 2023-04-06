import 'package:baber/app/core/utils/text_styles.dart';
import 'package:baber/navigation/custom_navigation.dart';
import 'package:baber/presentation/base/custom_app_bar.dart';
import 'package:baber/presentation/base/custom_drop_down_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/dimensions.dart';
import '../../app/core/utils/images.dart';
import '../../controller/auth_provider.dart';
import '../../domain/localization/language_constant.dart';
import '../../navigation/routes.dart';
import '../base/custom_button.dart';

class ChooseCityPage extends StatefulWidget {
  const ChooseCityPage({Key? key}) : super(key: key);

  @override
  State<ChooseCityPage> createState() => _ChooseCityPageState();
}

class _ChooseCityPageState extends State<ChooseCityPage> {
  bool isValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACKGROUND_COLOR,
      body: Consumer<AuthProvider>(builder: (child, authProvider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              title: getTranslated("city", context),
              showLeading: true,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 80.h,
                    ),
                    Image.asset(
                      Images.chooseCity,
                      width: 190.w,
                      height: 160.h,
                    ),
                    Center(
                        child: Text(getTranslated("choose_your_city", context),
                            textAlign: TextAlign.center,
                            style: AppTextStyles.w500.copyWith(
                                fontSize: 15, color: ColorResources.TITLE))),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                      child: CustomDropDownButton(
                          items: const ["الرياض","جدة",],
                          name: getTranslated("city", context),
                         // pSvgIcon: SvgImages.cityIcon,
                        pAssetIcon: Images.city,
                      ),
                    ),
                    CustomButton(
                        isLoading: authProvider.isSubmit,
                        isError: authProvider.isErrorOnSubmit,
                        height: 46.h,
                        onTap: () {
                          CustomNavigator.push(Routes.DASHBOARD);
                        },
                        textColor: ColorResources.WHITE_COLOR,
                        text: getTranslated("confirm", context),
                        backgroundColor: ColorResources.PRIMARY_COLOR),
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
