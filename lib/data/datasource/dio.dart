import 'package:dio/dio.dart';
import 'package:wavenadmin/data/datasource/local_data.dart';

class DioClient {
  late Dio _dio;
  final baseurl = "https://waven-development.site/";
  final LocalData localData;
  final Function()? onUnauthorized;
  bool _isRefreshing = false;
  
  DioClient(this.localData, {this.onUnauthorized}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseurl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        responseType: ResponseType.json,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = await localData.getAccesToken();
          if (token != null&&token.isNotEmpty) {
            options.headers['Authorization'] = "Bearer $token";
          }
          return handler.next(options);
        },

        onError: (error, handler) async{
          if (error.response?.statusCode == 401) {
            if (error.requestOptions.path.contains('refresh-token')) {
              return handler.next(error);
            }

            if (!_isRefreshing) {
              _isRefreshing = true;

              final newtoken = await _refreshTokenApi();

              _isRefreshing = false;

              if (newtoken!=null) {
                error.requestOptions.headers['Authorization'] =
                    'Bearer $newtoken';

                try {
                  final clonedRequest = await _dio.fetch(error.requestOptions);
                  return handler.resolve(
                    clonedRequest,
                  );
                } catch (e) {
                  return handler.next(error);
                }
              } else {
                onUnauthorized?.call();
                return handler.next(error);
              }
            }
          } else {
            
            return handler.next(error);
          }
        },
      ),
    );
  }

  Dio get dio => _dio;

  Future<String?> _refreshTokenApi() async {
    try {
      String? refreshToken = await localData.getRefreshToken();

      // Pakai Dio baru (polos) agar tidak kena interceptor loop
      final dioRefresh = Dio(BaseOptions(baseUrl: baseurl));

      final response = await dioRefresh.post(
        'v1/auth/refresh',
        data: {'refresh_token': refreshToken},
      );
      if (response.statusCode == 200) {
        final newAccessToken = response.headers.value('X-Access-Token');
        final newRefreshToken = response.headers.value('X-Refresh-Token');
        if (newAccessToken != null) {
          await localData.saveToken(
            newAccessToken,
            newRefreshToken ??
                refreshToken!,
          );
        }
        return newAccessToken;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
