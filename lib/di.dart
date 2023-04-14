import 'package:baber/controller/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/core/api/end_points.dart';
import 'controller/banner_provider.dart';
import 'controller/cart_provider.dart';
import 'controller/firebase_auth_provider.dart';
import 'controller/home_categories_provider.dart';
import 'controller/city_provider.dart';
import 'controller/contact_provider.dart';
import 'controller/home_vendors_provider.dart';
import 'controller/item_details_provider.dart';
import 'controller/language_provider.dart';
import 'controller/localization_provider.dart';
import 'controller/notifications_provider.dart';
import 'controller/products_provider.dart';
import 'controller/profile_provider.dart';
import 'controller/search_provider.dart';
import 'controller/settings_provider.dart';
import 'controller/theme_provider.dart';
import 'controller/vendor_provider.dart';
import 'controller/vendors_provider.dart';
import 'data/dio/dio_client.dart';
import 'data/dio/logging_interceptor.dart';
import 'domain/repository/auth_repo.dart';
import 'domain/repository/cart_repo.dart';
import 'domain/repository/city_repo.dart';
import 'domain/repository/contact_repo.dart';
import 'domain/repository/firebase_auth_repo.dart';
import 'domain/repository/home_repo.dart';
import 'domain/repository/item_details_repo.dart';
import 'domain/repository/notification_repo.dart';
import 'domain/repository/products_repo.dart';
import 'domain/repository/profile_repo.dart';
import 'domain/repository/search_repo.dart';
import 'domain/repository/settings_repo.dart';
import 'domain/repository/vendor_repo.dart';
import 'domain/repository/vendors_repo.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => DioClient(
        EndPoints.baseUrl,
        dio: sl(),
        loggingInterceptor: sl(),
    sharedPreferences:sl(), ));

  // Repository
  sl.registerLazySingleton(() => AuthRepo(sharedPreferences: sl(), dioClient: sl() ));
  sl.registerLazySingleton(() => FirebaseAuthRepo(sharedPreferences: sl(),dioClient: sl() ));
  sl.registerLazySingleton(() => ProfileRepo(dioClient: sl() ));
  sl.registerLazySingleton(() => CityRepo(dioClient: sl(),sharedPreferences: sl() ));
  sl.registerLazySingleton(() => HomeRepo(dioClient: sl(),sharedPreferences: sl()  ));
  sl.registerLazySingleton(() => VendorsRepo(dioClient: sl(),sharedPreferences: sl()));
  sl.registerLazySingleton(() => ProductsRepo(dioClient: sl()));
  sl.registerLazySingleton(() => VendorRepo(dioClient: sl() ));
  sl.registerLazySingleton(() => ItemDetailsRepo(dioClient: sl() ));
  sl.registerLazySingleton(() => NotificationRepo(dioClient: sl() ));
  sl.registerLazySingleton(() => ContactRepo(dioClient: sl() ));
  sl.registerLazySingleton(() => CartRepo(sharedPreferences: sl() ));
  sl.registerLazySingleton(() => SearchRepo(dioClient: sl() ));
  sl.registerLazySingleton(() => SettingsRepo(dioClient: sl() ));


  //provider

  sl.registerLazySingleton(() => LocalizationProvider(sharedPreferences: sl()));
  sl.registerLazySingleton(() => LanguageProvider());
   sl.registerLazySingleton(() => ThemeProvider(sharedPreferences: sl()));
   sl.registerLazySingleton(() => AuthProvider(authRepo: sl()));
   sl.registerLazySingleton(() => FirebaseAuthProvider(firebaseAuthRepo: sl()));
   sl.registerLazySingleton(() => ProfileProvider(profileRepo: sl()));
   sl.registerLazySingleton(() => CityProvider(cityRepo: sl()));
   sl.registerLazySingleton(() => BannerProvider(homeRepo: sl()));
   sl.registerLazySingleton(() => HomeCategoryProvider(homeRepo: sl()));
   sl.registerLazySingleton(() => HomeVendorsProvider(homeRepo: sl()));
   sl.registerLazySingleton(() => VendorsProvider(categoryRepo: sl()));
   sl.registerLazySingleton(() => VendorProvider(vendorRepo: sl()));
   sl.registerLazySingleton(() => ProductsProvider(productsRepo: sl()));
   sl.registerLazySingleton(() => ItemDetailsProvider(itemRepo: sl()));
   sl.registerLazySingleton(() => ContactProvider(contactRepo: sl()));
   sl.registerLazySingleton(() => NotificationProvider(notificationRepo: sl()));
   sl.registerLazySingleton(() => CartProvider(cartRepo: sl()));
   sl.registerLazySingleton(() => SearchProvider(searchRepo: sl()));
   sl.registerLazySingleton(() => SettingsProvider(settingsRepo: sl()));


  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
