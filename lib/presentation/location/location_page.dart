import 'package:baber/app/core/utils/text_styles.dart';
import 'package:baber/app/core/utils/validation.dart';
import 'package:baber/navigation/custom_navigation.dart';
import 'package:baber/presentation/base/custom_app_bar.dart';
import 'package:baber/presentation/base/custom_drop_down_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/core/utils/app_snack_bar.dart';
import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/dimensions.dart';
import '../../app/core/utils/images.dart';
import '../../controller/location_provider.dart';
import '../../domain/localization/language_constant.dart';
import '../../navigation/routes.dart';
import '../base/custom_button.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({this.fromProfile = false, Key? key}) : super(key: key);
  final bool fromProfile;
  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isValid = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACKGROUND_COLOR,
      body: Consumer<LocationProvider>(builder: (child, provider, _) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                title: widget.fromProfile
                    ? getTranslated("change_city", context)
                    : getTranslated("city", context),
                withBack: true,
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
                                  ? getTranslated(
                                      "choose_your_new_city", context)
                                  : getTranslated("choose_your_city", context),
                              textAlign: TextAlign.center,
                              style: AppTextStyles.w500.copyWith(
                                  fontSize: 15, color: ColorResources.TITLE))),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                        child: CustomDropDownButton(
                          items: provider.locations?.locations != null &&
                                  provider.locations!.locations!.isNotEmpty
                              ? provider.locations!.locations!
                              : [],
                          name: getTranslated("city", context),
                          onChange: (location) {
                            provider.onSelectLocation(
                                location: location.toString());
                          },
                          validation: Validations.city,
                          // pSvgIcon: SvgImages.cityIcon,
                          pAssetIcon: Images.city,
                        ),
                      ),
                      CustomButton(
                          isLoading: provider.isLoading,
                          isError: provider.isError,
                          height: 46.h,
                          onTap: () {
                            if (provider.location != null &&
                                provider.location != "" &&
                                formKey.currentState!.validate()) {
                              provider.setLocations();
                            } else {
                              CustomSnackBar.showSnackBar(
                                  notification: AppNotification(
                                      message: getTranslated(
                                          "please_choose_city", context),
                                      isFloating: true,
                                      backgroundColor: ColorResources.IN_ACTIVE,
                                      borderColor: Colors.transparent));
                            }
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
          ),
        );
      }),
    );
  }
}
