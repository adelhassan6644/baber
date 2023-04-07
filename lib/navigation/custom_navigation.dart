import 'package:baber/presentation/category/category_page.dart';
import 'package:flutter/material.dart';
import '../data/model/home_model.dart';
import '../main.dart';
import '../presentation/about/about_page.dart';
import '../presentation/auth/login_page.dart';
import '../presentation/auth/verification_page.dart';
import '../presentation/dashboard/dashbboard.dart';
import '../presentation/location/location_page.dart';
import '../presentation/notifications/pages/notification_page.dart';
import '../presentation/privacy/privacy_page.dart';
import '../presentation/splash/splash.dart';
import '../presentation/vendor/vendor_page.dart';
import 'routes.dart';

abstract class CustomNavigator {
  static final GlobalKey<NavigatorState> navigatorState =
      GlobalKey<NavigatorState>();
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldState =
      GlobalKey<ScaffoldMessengerState>();

  static Route<dynamic> onCreateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.APP:
        return _pageRoute(const MyApp());
      case Routes.SPLASH:
        return _pageRoute(const Splash());
      case Routes.LOGIN:
        return _pageRoute(const LoginPage());
      case Routes.VERIFICATION:
        return _pageRoute(const VerificationPage());
      case Routes.Location:
        return _pageRoute(LocationPage(
          fromProfile:
              settings.arguments != null ? settings.arguments as bool : false,
        ));
      case Routes.DASHBOARD:
        return _pageRoute(DashBoard(
          index: settings.arguments != null ? settings.arguments as int : null,
        ));
      case Routes.CATEGORIES:
        return _pageRoute(CategoryPage(
          categories: settings.arguments as List<HomeCategoryModel>,
        ));
      case Routes.VENDOR:
        return _pageRoute(const VendorPage());
      case Routes.NOTIFICATION:
        return _pageRoute(const NotificationPage());
      case Routes.PRIVACY:
        return _pageRoute(const PrivacyPage());
      case Routes.ABOUT:
        return _pageRoute(const AboutPage());

      default:
        return MaterialPageRoute(builder: (_) => const MyApp());
    }
  }

  static PageRouteBuilder<dynamic> _pageRoute(Widget child) => PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (c, anim, a2, child) {
        var begin = const Offset(1.0, 0.0);
        var end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var curveAnimation =
            CurvedAnimation(parent: anim, curve: Curves.linearToEaseOut);
        return SlideTransition(
          position: tween.animate(curveAnimation),
          child: child,
        );
      },
      opaque: false,
      pageBuilder: (_, __, ___) => child);

  static pop({dynamic result}) {
    if (navigatorState.currentState!.canPop()) {
      navigatorState.currentState!.pop(result);
    }
  }

  static push(String routeName,
      {arguments, bool replace = false, bool clean = false}) {
    if (clean) {
      return navigatorState.currentState!.pushNamedAndRemoveUntil(
          routeName, (_) => false,
          arguments: arguments);
    } else if (replace) {
      return navigatorState.currentState!.pushReplacementNamed(
        routeName,
        arguments: arguments,
      );
    } else {
      return navigatorState.currentState!
          .pushNamed(routeName, arguments: arguments);
    }
  }
}
