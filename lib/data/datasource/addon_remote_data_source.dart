import 'package:wavenadmin/data/datasource/base/base_remote_data_source.dart';
import 'package:wavenadmin/data/model/addon_detail_model.dart';
import 'package:wavenadmin/data/model/addons_dropdown_model.dart';
import 'package:wavenadmin/data/model/list_addons_model.dart';

abstract class AddonRemoteDataSource {
  Future<ListAddonsResponse> getListAddons(int page, int limit, {String? search});
  Future<AddonDetailResponse> getAddonDetail(String addonId);
  Future<String> updateAddon(String addonId, UpdateAddonRequest request);
  Future<CreateAddonResponse> createAddon(CreateAddonRequest request);
  Future<DeleteAddonResponse> deleteAddon(String addonId);
  Future<AddonsDropdownResponse> getAddonsDropdown(int page, int limit, {String? search});
}

class AddonRemoteDataSourceImpl extends BaseRemoteDataSource 
    implements AddonRemoteDataSource {
  
  AddonRemoteDataSourceImpl(super.dio);

  @override
  Future<ListAddonsResponse> getListAddons(int page, int limit, {String? search}) async {
    try {
      final response = await dio.dio.get("v1/admin/addons",
        queryParameters: {
          'page': page,
          'limit': limit,
          if (search != null) 'search': search,
          'status': "all"
        }
      );
      return handleResponse(response, (data) => ListAddonsResponse.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<AddonDetailResponse> getAddonDetail(String addonId) async {
    try {
      final response = await dio.dio.get('v1/admin/addons/$addonId');
      return handleResponse(response, (data) => AddonDetailResponse.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<String> updateAddon(String addonId, UpdateAddonRequest request) async {
    try {
      final response = await dio.dio.put(
        'v1/admin/addons/$addonId',
        data: request.toJson(),
      );
      return handleResponse(response, (data) => data['message'] as String);
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<CreateAddonResponse> createAddon(CreateAddonRequest request) async {
    try {
      final response = await dio.dio.post(
        'v1/admin/addons',
        data: request.toJson(),
      );
      return handleResponse(response, (data) => CreateAddonResponse.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<DeleteAddonResponse> deleteAddon(String addonId) async {
    try {
      final response = await dio.dio.delete('v1/admin/addons/$addonId');
      return handleResponse(response, (data) => DeleteAddonResponse.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }
  
  @override
  Future<AddonsDropdownResponse> getAddonsDropdown(int page, int limit, {String? search}) async {
    try {
      final response = await dio.dio.get('v1/admin/addons/dropdown',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (search != null) 'search': search,
        });
      return handleResponse(response, (data) => AddonsDropdownResponse.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }
}
