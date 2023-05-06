import 'package:baber/app/core/utils/text_styles.dart';
import 'package:baber/navigation/custom_navigation.dart';
import 'package:baber/presentation/base/custom_app_bar.dart';
import 'package:baber/presentation/base/custom_drop_down_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/core/network/netwok_info.dart';
import '../../app/core/utils/app_snack_bar.dart';
import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/dimensions.dart';
import '../../app/core/utils/images.dart';
import '../../controller/cart_provider.dart';
import '../../controller/city_provider.dart';
import '../../domain/localization/language_constant.dart';
import '../base/custom_button.dart';

class CityPage extends StatefulWidget {
  const CityPage({this.fromProfile = false, Key? key}) : super(key: key);
  final bool fromProfile;
  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  @override
  void initState() {
    if (widget.fromProfile == true) {
      Future.delayed(Duration.zero, () {
        Provider.of<CityProvider>(
                CustomNavigator.navigatorState.currentContext!,
                listen: false)
            .getCities();
        Provider.of<CityProvider>(
                CustomNavigator.navigatorState.currentContext!,
                listen: false)
            .getYourCity();
      });
    }
    if (widget.fromProfile == false) {
      NetworkInfo.checkConnectivity(onVisible: () async {
        await Provider.of<CityProvider>(
                CustomNavigator.navigatorState.currentContext!,
                listen: false)
            .getCities();
        Provider.of<CityProvider>(
                CustomNavigator.navigatorState.currentContext!,
                listen: false)
            .getYourCity();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACKGROUND_COLOR,
      body: Consumer<CityProvider>(builder: (child, provider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              title: widget.fromProfile
                  ? getTranslated("change_city", context)
                  : getTranslated("city", context),
              withBack: widget.fromProfile ? true : false,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                ),
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
                        child: Text(
                            widget.fromProfile
                                ? getTranslated("choose_your_new_city", context)
                                : getTranslated("choose_your_city", context),
                            textAlign: TextAlign.center,
                            style: AppTextStyles.w500.copyWith(
                                fontSize: 15, color: ColorResources.TITLE))),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                      child: CustomDropDownButton(
                        // onTap:(){
                        //   provider.cityModel?.cities == null && provider.cityModel!.cities!.isEmpty ?
                        //   CustomSnackBar.showSnackBar(
                        //       notification: AppNotification(
                        //           message: "انتظر من فضلك",
                        //           isFloating: false,
                        //           backgroundColor: ColorResources.PENDING,
                        //           borderColor: Colors.transparent)):null;
                        // },
                        items: provider.cityModel?.cities != null &&
                                provider.cityModel!.cities!.isNotEmpty
                            ? provider.cityModel!.cities!
                            : [],
                        name: provider.currentCity ??
                            getTranslated("city", context),
                        onChange: (location) {
                          provider.onSelectCity(location: location);
                        },
                        pAssetIcon: Images.city,
                      ),
                    ),
                    CustomButton(
                        isLoading: provider.isLoading,
                        height: 46.h,
                        onTap: () {
                          if (provider.city != null) {
                            provider.updateCity();
                            Provider.of<CartProvider>(context,listen: false).checkCity(city: provider.city!.id.toString());
                          } else {
                            CustomSnackBar.showSnackBar(
                                notification: AppNotification(
                                    message: getTranslated(
                                        "please_choose_city", context),
                                    isFloating: true,
                                    backgroundColor: ColorResources.IN_ACTIVE,
                                    borderColor: Colors.transparent));
                          }
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
