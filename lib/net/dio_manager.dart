import 'dart:io';
import 'dart:convert';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:privacy_client/data/api/apis.dart';
import 'package:privacy_client/common/cmmon.dart';
import 'package:privacy_client/utils/index.dart';

Dio _dio = Dio();

/// 使用默认配置
Dio get dio => _dio;

/// dio 配置
class DioManager {
  bool isDebug = AppConfig.isDebug;

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

  //打印日志
  InterceptorsWrapper logInterceptor() {
    return InterceptorsWrapper(onRequest: (options, handler) {
      if (isDebug) {
        print('┌─────────────────────Begin Request─────────────────────');
        printKV('uri', options.uri);
        printKV('method', options.method);
        printKV('queryParameters', options.queryParameters);
        printKV('contentType', options.contentType.toString());
        printKV('responseType', options.responseType.toString());
        StringBuffer stringBuffer = new StringBuffer();
        options.headers.forEach((key, v) => stringBuffer.write('\n  $key: $v'));
        printKV('headers', stringBuffer.toString());
        stringBuffer.clear();

        if (options.data != null) {
          printKV('body', options.data);
        }
        print('└—————————————————————End Request———————————————————————\n\n');
      }
      handler.next(options);
    }, onResponse: (response, handler) {
      if (isDebug) {
        print('┌─────────────────────Begin Response—————————————————————');
        printKV('uri', response.requestOptions.uri);
        printKV('status', response.statusCode.toString());
        printKV(
            'responseType', response.requestOptions.responseType.toString());

        StringBuffer stringBuffer = new StringBuffer();
        response.headers
            .forEach((key, v) => stringBuffer.write('\n  $key: $v'));
        printKV('headers', stringBuffer.toString());
        stringBuffer.clear();

        // printLong('response: ' + response.toString());

        print('└—————————————————————End Response———————————————————————\n\n');
      }
      handler.next(response);
    }, onError: (DioError e, handler) {
      if (isDebug) {
        print('┌─────────────────────Begin Dio Error—————————————————————');
        printKV('error', e.toString());
        printKV('error message', (e.response?.toString() ?? ''));
        print('└—————————————————————End Dio Error———————————————————————\n\n');
      }
      handler.next(e);
    });
  }

  printKV(String key, Object value) {
    printLong('$key: $value');
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
