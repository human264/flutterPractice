import 'package:actual/common/const/data.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({required this.storage,});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      if (token != null) {
        options.headers['authorization'] = 'Bearer $token';
      } else {
        print("Token is null");
      }
    }

    if (options.headers['refreshToken'] == 'true') {
      options.headers.remove('refreshToken');

      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      if (token != null) {
        options.headers['authorization'] = 'Bearer $token';
      } else {
        print("Token is null");
      }
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {

    if (kDebugMode) {
      print('[ERR] [${err.requestOptions.method}], [${err.requestOptions.uri}] ');
    }

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    if(refreshToken == null) {
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    if(isStatus401 && !isPathRefresh) {

      final dio = Dio();

      try {
        final resp = await dio.post(
            'http://$ip/auth/token', options: Options(
          headers: {
            'authorization' :'Bearer $refreshToken',
          },
        ));
        final accessToken = resp.data['accessToken'];
        final options = err.requestOptions;

        // 토큰 변경
        options.headers.addAll({
          'authorization' : 'Bearer $refreshToken',
        });

        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        // 요창 재요청
        final response = await dio.fetch(options);

        return handler.resolve(response);

      } on DioException catch (e) {
        return handler.reject(e);
      }
    }

    return handler.reject(err);

  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {

    print('[RES] [${response.requestOptions.method}], ${response.requestOptions.uri}');

    return super.onResponse(response, handler);
  }

}
