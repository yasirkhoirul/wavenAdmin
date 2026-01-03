import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/data/datasource/base/base_remote_data_source.dart';
import 'package:wavenadmin/data/model/photographer_booking_model.dart';
import 'package:wavenadmin/data/model/photographer_detail_model.dart';
import 'package:wavenadmin/data/model/photographer_payment_model.dart';
import 'package:wavenadmin/data/model/user_photographer_dropdown.dart';

abstract class PhotographerRemoteDataSource {
  Future<PhotographerPaymentResponse> getPhotographerPaymentList(
    int page,
    int limit, {
    String? search,
    DateTime? startTime,
    DateTime? endTime,
    String? sortBy,
    Sort? sort,
  });
  
  Future<PhotographerDetailResponse> getPhotographerDetail(String id);
  
  Future<PhotographerBookingResponse> getPhotographerBookings(
    String photographerId,
    int page,
    int limit, {
    String? search,
    DateTime? startTime,
    DateTime? endTime,
  });
  
  Future<PhotographerDropdownResponse> getPhotographerDropdown(
    int page,
    int limit, {
    String? search,
  });
}

class PhotographerRemoteDataSourceImpl extends BaseRemoteDataSource 
    implements PhotographerRemoteDataSource {
  
  PhotographerRemoteDataSourceImpl(super.dio);

  @override
  Future<PhotographerPaymentResponse> getPhotographerPaymentList(
    int page,
    int limit, {
    String? search,
    DateTime? startTime,
    DateTime? endTime,
    String? sortBy,
    Sort? sort,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {
        'page': page,
        'limit': limit,
      };

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      if (startTime != null) {
        queryParams['start_time'] = startTime.toIso8601String().split('T')[0];
      }

      if (endTime != null) {
        queryParams['end_time'] = endTime.toIso8601String().split('T')[0];
      }

      if (sortBy != null) {
        queryParams['sort_by'] = sortBy;
      }

      if (sort != null) {
        queryParams['sort'] = sort == Sort.asc ? 'asc' : 'desc';
      }

      final response = await dio.dio.get(
        'v1/admin/photographers/payment-info',
        queryParameters: queryParams,
      );

      return handleResponse(
        response,
        (data) => PhotographerPaymentResponse.fromJson(data),
      );
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<PhotographerDetailResponse> getPhotographerDetail(String id) async {
    try {
      final response = await dio.dio.get(
        'v1/admin/photographers/$id/payment-info',
      );

      return handleResponse(
        response,
        (data) => PhotographerDetailResponse.fromJson(data),
      );
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<PhotographerBookingResponse> getPhotographerBookings(
    String photographerId,
    int page,
    int limit, {
    String? search,
    DateTime? startTime,
    DateTime? endTime,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {
        'page': page,
        'limit': limit,
      };

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      if (startTime != null) {
        queryParams['start_time'] = startTime.toIso8601String().split('T')[0];
      }

      if (endTime != null) {
        queryParams['end_time'] = endTime.toIso8601String().split('T')[0];
      }

      final response = await dio.dio.get(
        'v1/admin/photographers/$photographerId/bookings',
        queryParameters: queryParams,
      );

      return handleResponse(
        response,
        (data) => PhotographerBookingResponse.fromJson(data),
      );
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<PhotographerDropdownResponse> getPhotographerDropdown(
    int page,
    int limit, {
    String? search,
  }) async {
    try {
      final response = await dio.dio.get(
        'v1/admin/photographers/dropdown',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (search != null) 'search': search,
        },
      );

      return handleResponse(
        response,
        (data) => PhotographerDropdownResponse.fromJson(data),
      );
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }
}
