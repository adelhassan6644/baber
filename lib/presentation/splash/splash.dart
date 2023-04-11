import 'dart:async';
import 'package:baber/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../app/core/utils/color_resources.dart';
import '../../app/core/utils/images.dart';
import '../../controller/auth_provider.dart';
import '../../controller/firebase_auth_provider.dart';
import '../../navigation/custom_navigation.dart';
import '../../navigation/routes.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with WidgetsBindingObserver {
  @override
  void initState() {

    WidgetsBinding.instance.addObserver(this);
    Future.delayed(const Duration(milliseconds: 4500), () {
      if (Provider.of<FirebaseAuthProvider>(CustomNavigator.navigatorState.currentContext!, listen: false).isLogin) {
        CustomNavigator.push(Routes.DASHBOARD,replace: true);
      }else{
        CustomNavigator.push(Routes.LOGIN,replace: true);
      }

    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.PRIMARY_COLOR,
        body: SafeArea(
          bottom: true,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: context.height,
                width: context.width,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: ColorResources.PRIMARY_COLOR
                ),
                child:const SizedBox()),
              Image.asset(
                Images.logo,
                color: Colors.black,
              ).animate()
                  .scale(duration: 500.ms)
                  .then(delay: 200.ms) // baseline=800ms
                  .slide()  .scaleXY(duration: 600.ms)  .then(delay: 200.ms).shimmer(duration: 1000.ms),
            ],
          ),
        ));
  }
}
