import 'package:baber/controller/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/core/api/end_points.dart';
import 'controller/banner_provider.dart';
import 'controller/categories_provider.dart';
import 'controller/home_vendor_provider.dart';
import 'controller/item_provider.dart';
import 'controller/language_provider.dart';
import 'controller/localization_provider.dart';
import 'controller/location_provider.dart';
import 'controller/theme_provider.dart';
import 'controller/vednor_prvider.dart';
import 'controller/vendors_by_category_provider.dart';
import 'data/dio/dio_client.dart';
import 'data/dio/logging_interceptor.dart';
import 'domain/repositery/auth_repo.dart';
import 'domain/repositery/category_repo.dart';
import 'domain/repositery/home_repo.dart';
import 'domain/repositery/item_repo.dart';
import 'domain/repositery/location_repo.dart';
import 'domain/repositery/vendor_repo.dart';


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
  sl.registerLazySingleton(() => LocationRepo(dioClient: sl() ));
  sl.registerLazySingleton(() => HomeRepo(dioClient: sl() ));
  sl.registerLazySingleton(() => CategoryRepo(dioClient: sl() ));
  sl.registerLazySingleton(() => VendorRepo(dioClient: sl() ));
  sl.registerLazySingleton(() => ItemRepo(dioClient: sl() ));


  //provider

  sl.registerLazySingleton(() => LocalizationProvider(sharedPreferences: sl()));
  sl.registerLazySingleton(() => LanguageProvider());
   sl.registerLazySingleton(() => ThemeProvider(sharedPreferences: sl()));
   sl.registerLazySingleton(() => AuthProvider(authRepo: sl()));
   sl.registerLazySingleton(() => LocationProvider(locationRepo: sl()));
   sl.registerLazySingleton(() => BannerProvider(homeRepo: sl()));
   sl.registerLazySingleton(() => CategoryProvider(homeRepo: sl()));
   sl.registerLazySingleton(() => HomeVendorProvider(homeRepo: sl()));
   sl.registerLazySingleton(() => VendorsByCategoryProvider(categoryRepo: sl()));
   sl.registerLazySingleton(() => VendorProvider(vendorRepo: sl()));
   sl.registerLazySingleton(() => ItemProvider(itemRepo: sl()));


  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
