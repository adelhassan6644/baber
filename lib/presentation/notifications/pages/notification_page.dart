import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/extensions.dart';
import 'package:baber/controller/notifications_provider.dart';
import 'package:baber/presentation/base/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../domain/localization/language_constant.dart';
import '../../base/custom_app_bar.dart';
import '../widget/notification_card_view.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: getTranslated("notifications", context),
            withBack: true,
          ),
          Consumer<NotificationProvider>(
            builder: (BuildContext context, provider, Widget? child) {
              return provider.isLoading
                  ? Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: List.generate(
                            7,
                            (index) => Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12.h,
                                      horizontal:
                                          Dimensions.PADDING_SIZE_DEFAULT.w),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    enabled: true,
                                    child: Container(
                                      height: 100.h,
                                      width: context.width,
                                      decoration: const BoxDecoration(
                                        color: ColorResources.WHITE_COLOR,
                                      ),
                                    ),
                                  ),
                                )),
                      ),
                    )
                  : provider.notificationModel != null &&
                          provider.notificationModel!.notifications != null &&
                          provider.notificationModel!.notifications!.isNotEmpty
                      ? Expanded(
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            children: List.generate(
                                provider
                                    .notificationModel!.notifications!.length,
                                (index) => NotificationCardView(
                                      isOpened: true,
                                      isFirst: index == 0,
                                      notification: provider.notificationModel!
                                          .notifications![index],
                                    )),
                          ),
                        )
                      : const EmptyWidget();
            },
          ),
        ],
      ),
    );
  }
}
