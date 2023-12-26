import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hip_quest/helper/NetworkInfo.dart';
import 'package:hip_quest/Provider/Providers.dart';
import 'package:hip_quest/data/controller/Controllers.dart';
import 'package:hip_quest/data/dataSource/remote/dio/DioClient.dart';
import 'package:hip_quest/data/dataSource/remote/dio/DioInterceptor.dart';
import 'package:hip_quest/util/AppConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => NetworkInfo(sl()));
  sl.registerLazySingleton(
    () => DioClient(
      AppConstants.baseUrl,
      sl(),
      dioInterceptor: sl(),
      sharedPreferences: sl(),
    ),
  );

  // Controller
  sl.registerLazySingleton(() => LoginController(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => RegisterController(dioClient: sl()));
  sl.registerLazySingleton(() => ForgotController(dioClient: sl()));
  sl.registerLazySingleton(() => UserInfoController(dioClient: sl()));
  sl.registerLazySingleton(() => BlogController(dioClient: sl()));
  sl.registerLazySingleton(() => EventController(dioClient: sl()));
  sl.registerLazySingleton(() => VideoLibraryController(dioClient: sl()));
  sl.registerLazySingleton(() => ChatUserController(dioClient: sl()));
  sl.registerLazySingleton(() => ChangePasswordController(dioClient: sl()));
  sl.registerLazySingleton(() => FreePdfController(dioClient: sl()));
  sl.registerLazySingleton(() => EbookController(dioClient: sl()));
  sl.registerLazySingleton(() => CourseController(dioClient: sl()));
  sl.registerLazySingleton(() => LearningController(dioClient: sl()));

  // Provider
  sl.registerFactory(() => UserInfoProvider(userInfoController: sl(), loginController: sl(), prefs: sl()));
  sl.registerFactory(() => LoginProvider(loginController: sl(), prefs: sl()));
  sl.registerFactory(() => RegisterProvider(registerController: sl(), loginController: sl()));
  sl.registerFactory(() => ForgotProvider(forgotController: sl()));
  sl.registerFactory(() => BlogProvider(blogController: sl()));
  sl.registerFactory(() => EventProvider(eventController: sl()));
  sl.registerFactory(() => VideoLibraryProvider(videoLibraryController: sl()));
  sl.registerFactory(() => ChatUserProvider(chatUserController: sl()));
  sl.registerFactory(() => ChangePasswordProvider(changePasswordController: sl()));
  sl.registerFactory(() => FreePdfProvider(freePdfController: sl()));
  sl.registerFactory(() => EBookProvider(ebookController: sl(), learningController: sl(), prefs: sl()));
  sl.registerFactory(() => CourseProvider(courseController: sl(), learningController: sl(), prefs: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => DioInterceptor());
  sl.registerLazySingleton(() => Connectivity());
}
