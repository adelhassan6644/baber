import 'package:flutter/material.dart';
import '../../../domain/localization/language_constant.dart';
import '../../base/custom_app_bar.dart';
import '../widgets/notification_card_view.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title:  getTranslated("notifications", context),
            withBack: true,
          ),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
            NotificationCardView(isOpened: false,isFirst: true),
            NotificationCardView(isOpened: true),
            NotificationCardView(isOpened: false),
            NotificationCardView(isOpened: true),
            NotificationCardView(isOpened: false),
            NotificationCardView(isOpened: true),
            NotificationCardView(isOpened: false),
            NotificationCardView(isOpened: true),
            NotificationCardView(isOpened: false),
          ],),
        )
          
          ],
        ),
    );
  }
}
