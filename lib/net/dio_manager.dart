import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:privacy_client/data/api/apis.dart';

Dio _dio = Dio();

/// 使用默认配置
Dio get dio => _dio;

/// dio 配置
class DioManager {
  static Future init() async {
    dio.options.baseUrl = Apis.BASE_HOST;
    dio.options.connectTimeout = 30 * 1000;
    dio.options.sendTimeout = 30 * 1000;
    dio.options.receiveTimeout = 30 * 1000;
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };

    // TODO 网络环境监听
    // dio.interceptors.add(LogInterceptors());
    // dio.interceptors.add(CookieInterceptor2());

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path + "/dioCookie";
    print('DioUtil : http cookie path = $tempPath');
    CookieJar cj =
        PersistCookieJar(storage: FileStorage(tempPath), ignoreExpires: true);
    dio.interceptors.add(CookieManager(cj));
  }

  static String handleError(error, {String defaultErrorStr = '未知错误~'}) {
    // 定义一个命名参数的方法
    var errStr;
    if (error is DioError) {
      if (error.type == DioErrorType.connectTimeout) {
        errStr = '连接超时';
      } else if (error.type == DioErrorType.sendTimeout) {
        errStr = '请求超时';
      } else if (error.type == DioErrorType.receiveTimeout) {
        errStr = '响应超时';
      } else if (error.type == DioErrorType.cancel) {
        errStr = '请求取消';
      } else if (error.type == DioErrorType.response) {
        int statusCode = error.response!.statusCode!;
        String? msg = error.response!.statusMessage;

        /// TODO 异常状态码的处理
        switch (statusCode) {
          case 500:
            errStr = '服务器异常';
            break;
          case 404:
            errStr = '未找到资源';
            break;
          default:
            errStr = '$msg[$statusCode]';
            break;
        }
      } else if (error.type == DioErrorType.other) {
        errStr = '${error.message}';
        if (error.error is SocketException) {
          errStr = '网络连接超时';
        }
      } else {
        errStr = '未知错误';
      }
    }
    return errStr ?? defaultErrorStr;
  }
}