import 'package:baber/controller/auth_provider.dart';
import 'package:baber/presentation/auth/login_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'app/core/utils/app_storage_keys.dart';
import 'app/core/utils/un_focus.dart';
import 'app/theme/dark_theme.dart';
import 'app/theme/light_theme.dart';
import 'controller/banner_provider.dart';
import 'controller/home_categories_provider.dart';
import 'controller/city_provider.dart';
import 'controller/contact_provider.dart';
import 'controller/home_vendor_provider.dart';
import 'controller/item_provider.dart';
import 'controller/localization_provider.dart';
import 'controller/notifications_provider.dart';
import 'controller/profile_provider.dart';
import 'controller/theme_provider.dart';
import 'controller/vednor_prvider.dart';
import 'controller/vendors_by_category_provider.dart';
import 'di.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app/core/utils/app_strings.dart';
import 'domain/localization/app_localization.dart';
import 'navigation/custom_navigation.dart';
import 'navigation/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await di.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<LocalizationProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<ProfileProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<CityProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<BannerProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<HomeCategoryProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<HomeVendorProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<VendorsByCategoryProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<VendorProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<ItemProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<ContactProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<NotificationProvider>()),
  ], child: const MyApp()));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    List<Locale> locals = [];
    for (var language in AppStorageKey.languages) {
      locals.add(Locale(language.languageCode!, language.countryCode));
    }
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light));
    return MaterialApp(
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Unfocus(child: child!)),
      initialRoute: Routes.SPLASH,
      navigatorKey: CustomNavigator.navigatorState,
      onGenerateRoute: CustomNavigator.onCreateRoute,
      navigatorObservers: [CustomNavigator.routeObserver],
      title: AppStrings.appName,
      supportedLocales: locals,
      scaffoldMessengerKey: CustomNavigator.scaffoldState,
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context,).darkTheme ? dark : light,
      locale: Provider.of<LocalizationProvider>(context,).locale,
      localizationsDelegates: const [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const LoginPage(),

    );
  }
}
