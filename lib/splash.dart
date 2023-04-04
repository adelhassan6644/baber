import 'dart:async';
import 'package:baber/app/core/utils/dimensions.dart';
import 'package:baber/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'app/core/utils/color_resources.dart';
import 'app/core/utils/images.dart';
import 'controller/auth_provider.dart';
import 'navigation/custom_navigation.dart';
import 'navigation/routes.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with WidgetsBindingObserver {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 4500), () {

      if (Provider.of<AuthProvider>(context, listen: false).isLogin) {
        CustomNavigator.push(Routes.DASHBOARD,replace: true);
      }else{
        CustomNavigator.push(Routes.LOGIN,replace: true);
      }

    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          bottom: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Expanded(
                child: Center(
                  child:Image.asset(
                    Images.splash,
                    width: context.width*.7,

                  ),
                ).animate()
                    .scale(duration: 500.ms)
                    .then(delay: 200.ms) // baseline=800ms
                    .slide()  .scaleXY(duration: 600.ms)  .then(delay: 200.ms).shimmer(duration: 1000.ms) ,
              ),
              // RichText(
              //   text:  const TextSpan(text: "Powered By", children: [
              //     TextSpan(
              //         text: " software cloud 2",
              //         style: TextStyle(
              //             fontSize: 14,
              //             fontWeight: FontWeight.w700,
              //             color: ColorResources.PENDING))
              //   ],  style: TextStyle(
              //       fontSize: 14,
              //       fontWeight: FontWeight.w700,
              //       color: ColorResources.PRIMARY_COLOR)),
              // ).animate().slideY().then(delay: 2000.ms).slide() .shimmer(duration: 1000.ms) ,
              // SizedBox(height:40.h),
            ],
          ),
        ));
  }
}
