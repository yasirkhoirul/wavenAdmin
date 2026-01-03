import 'package:dio/dio.dart';
import 'package:wavenadmin/data/datasource/dio.dart';

class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => message;
}

abstract class BaseRemoteDataSource {
  final DioClient dio;

  const BaseRemoteDataSource(this.dio);

  /// Centralized error message handler
  String friendlyErrorMessage(dynamic error) {
    if (error is DioException) {
      if (error.response?.data != null) {
        try {
          final data = error.response!.data;
          if (data is Map && data['message'] != null) {
            return data['message'].toString();
          }
        } catch (_) {}
      }

      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return 'Koneksi timeout. Periksa koneksi internet Anda.';
        case DioExceptionType.connectionError:
          return 'Tidak dapat terhubung ke server. Periksa koneksi internet Anda.';
        case DioExceptionType.badResponse:
          return 'Server error: ${error.response?.statusCode}';
        default:
          return 'Terjadi kesalahan: ${error.message}';
      }
    }

    if (error is AppException) {
      return error.message;
    }

    return error.toString();
  }

  /// Helper untuk handle standard response
  T handleResponse<T>(
    Response response,
    T Function(dynamic data) parser,
  ) {
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw AppException(
        response.data['message'] ?? 'Request failed',
      );
    }
    return parser(response.data);
  }
}
