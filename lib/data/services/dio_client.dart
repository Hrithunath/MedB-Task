import 'dart:developer';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';

import 'package:med_b/data/services/storage_service.dart';

class DioClient {
  final Dio _dio = Dio();
  late PersistCookieJar cookieJar;

  DioClient() {
    _init();
  }

  Future<void> _init() async {
    final dir = await getApplicationDocumentsDirectory();
    cookieJar = PersistCookieJar(storage: FileStorage('${dir.path}/.cookies/'));
    _dio.interceptors.add(CookieManager(cookieJar));

    _dio.options = BaseOptions(
      baseUrl: "https://testapi.medb.co.in/api/",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 90),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final accessToken = await SecureStorageService.getAccessToken();
          if (accessToken != null) {
            options.headers["Authorization"] = "Bearer $accessToken";
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
         
          if (error.response?.statusCode == 401) {
              await SecureStorageService.clearAll();
    await cookieJar.deleteAll();
       log("401 Unauthorized - Cleared access tokens and cookies.");
          }
          return handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;

 
}
