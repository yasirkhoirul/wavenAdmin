import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/data/datasource/base/base_remote_data_source.dart';
import 'package:wavenadmin/data/model/universitas_list_model.dart';
import 'package:wavenadmin/data/model/university_detail_model.dart';
import 'package:wavenadmin/data/model/university_dropdown_model.dart';

abstract class UniversityRemoteDataSource {
  Future<UniversitasListModel> getListUniversitas(int page, int limit, {String? search, Sort? sort});
  Future<UniversityDropdownResponse> getUniversityDropdown(int page, int limit, {String? search});
  Future<String> createUniv(UniversityDetailData payload);
  Future<void> deleteUniv(String idUniv);
  Future<UniversityDetailResponse> getDetailUniversity(String universityId);
  Future<UpdateUniversityResponse> updateUniversity(String universityId, UpdateUniversityRequest request);
}

class UniversityRemoteDataSourceImpl extends BaseRemoteDataSource 
    implements UniversityRemoteDataSource {
  
  UniversityRemoteDataSourceImpl(super.dio);

  @override
  Future<UniversityDropdownResponse> getUniversityDropdown(int page, int limit, {String? search}) async {
    try {
      final response = await dio.dio.get('v1/admin/master/universities/dropdown',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (search != null) 'search': search,
        });
      return handleResponse(response, (data) => UniversityDropdownResponse.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<UniversityDetailResponse> getDetailUniversity(String universityId) async {
    try {
      final response = await dio.dio.get('v1/admin/master/universities/$universityId');
      return handleResponse(response, (data) => UniversityDetailResponse.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<UpdateUniversityResponse> updateUniversity(String universityId, UpdateUniversityRequest request) async {
    try {
      final response = await dio.dio.put(
        'v1/admin/master/universities/$universityId',
        data: request.toJson(),
      );
      return handleResponse(response, (data) => UpdateUniversityResponse.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<UniversitasListModel> getListUniversitas(int page, int limit, {String? search, Sort? sort}) async {
    try {
      final response = await dio.dio.get('v1/admin/master/universities',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (search != null) 'search': search,
          if (sort != null) 'sort': sort.name
        });
      return handleResponse(response, (data) => UniversitasListModel.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<String> createUniv(UniversityDetailData payload) async {
    try {
      final response = await dio.dio.post('vv1/admin/master/universitiess',
        data: payload.toJson());
      return handleResponse(response, (data) => data['message'] as String);
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<void> deleteUniv(String idUniv) async {
    try {
      final response = await dio.dio.delete('v1/admin/master/universities/$idUniv');
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw AppException(response.data['message'] ?? 'Delete failed');
      }
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }
}
