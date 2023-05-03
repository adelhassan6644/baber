import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../app/core/utils/text_styles.dart';
import '../../../controller/firebase_auth_provider.dart';
import '../../base/custom_images.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseAuthProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: 70.w,
                    height: 70.h,
                    decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  customImageIconSVG(imageName: SvgImages.maleAvatar),
                ],
              ),
              SizedBox(
                width: 24.h,
              ),
              (Provider.of<FirebaseAuthProvider>(context, listen: false)
                      .isLogin)
                  ? FirebaseAuth.instance.currentUser?.phoneNumber != null
                      ? Text(
                          "${FirebaseAuth.instance.currentUser?.phoneNumber?.replaceAll("+", "")}+",
                          style: AppTextStyles.w500.copyWith(
                              fontSize: 14, color: ColorResources.HINT_COLOR))
                      : Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          enabled: true,
                          child: Container(
                              width: 150.w,
                              height: 14.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                color: ColorResources.WHITE_COLOR,
                              )),
                        )
                  : Text("انت الان في وضع ضيف",
                      style: AppTextStyles.w500.copyWith(
                          fontSize: 14, color: ColorResources.HINT_COLOR)),
            ],
          ),
        );
      },
    );
  }
}
