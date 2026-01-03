import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/data/datasource/base/base_remote_data_source.dart';
import 'package:wavenadmin/data/model/admin_detail_model.dart';
import 'package:wavenadmin/data/model/create_fotografer_request.dart';
import 'package:wavenadmin/data/model/delete_batch_user_model.dart';
import 'package:wavenadmin/data/model/update_user_request_model.dart';
import 'package:wavenadmin/data/model/user_admin_model.dart';
import 'package:wavenadmin/data/model/user_detial_fotografer_model.dart';
import 'package:wavenadmin/data/model/user_detial_model.dart';
import 'package:wavenadmin/data/model/user_photographer_model.dart';
import 'package:wavenadmin/data/model/usermodel.dart';

abstract class UserRemoteDataSource {
  Future<UserListResponse> getListUser(int page, int limit, {String? search, Sort? sort, SortUser? sortBy});
  Future<UserListResponseAdmin> getListUserAdmin(int page, int limit, {String? search, Sort? sort, SortAdmin? sortAdmin});
  Future<UserFotograferListResponse> getListPhotographer(int page, int limit, {String? search, Sort? sort, SortPhotographer? sortBy});
  Future<UserDetailResponse> getDetailUser(String idUser);
  Future<UserDetailFotograferResponse> getDetailUserFotografer(String idUser);
  Future<AdminDetailResponse> getUserAdminDetail(String id);
  Future<String> putDetailAdmin(AdminDetailModel payload, String idAdmin);
  Future<String> putDetailFotografer(UserDetailFotograferModel payload, String idFotografer);
  Future<String> createAdmin(AdminDetailModel payload);
  Future<String> createFotografer(CreateFotograferRequest payload);
  Future<void> deleteAdmin(String idAdmin);
  Future<String> deleteFotografer(String idFotografer);
  Future<UpdateUserResponse> updateUser(String userId, UpdateUserRequest request);
  Future<String> deleteUser(String userId);
  Future<DeleteBatchUserResponse> deleteBatchUser(List<String> userIds);
}

class UserRemoteDataSourceImpl extends BaseRemoteDataSource 
    implements UserRemoteDataSource {
  
  UserRemoteDataSourceImpl(super.dio);

  @override
  Future<UserListResponse> getListUser(int page, int limit, {String? search, Sort? sort, SortUser? sortBy}) async {
    try {
      final response = await dio.dio.get('v1/admin/users', queryParameters: {
        'page': page,
        'limit': limit,
        if (search != null) 'search': search,
        if (sort != null) 'sort': sort.name,
        if (sortBy != null) 'sort_by': sortBy.name
      });
      return handleResponse(response, (data) => UserListResponse.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<UserListResponseAdmin> getListUserAdmin(int page, int limit, {String? search, Sort? sort, SortAdmin? sortAdmin}) async {
    try {
      final response = await dio.dio.get('v1/admin/admins',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (search != null) 'search': search,
          if (sort != null) 'sort': sort.name,
          if (sortAdmin != null) 'sort_by': sortAdmin.name
        });
      return handleResponse(response, (data) => UserListResponseAdmin.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<UserFotograferListResponse> getListPhotographer(int page, int limit, {String? search, Sort? sort, SortPhotographer? sortBy}) async {
    try {
      final response = await dio.dio.get('v1/admin/photographers',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (search != null) 'search': search,
          if (sort != null) 'sort': sort.name,
          if (sortBy != null) 'sort_by': sortBy.name
        });
      return handleResponse(response, (data) => UserFotograferListResponse.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<UserDetailResponse> getDetailUser(String idUser) async {
    try {
      final response = await dio.dio.get('v1/admin/users/$idUser');
      return handleResponse(response, (data) => UserDetailResponse.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<UserDetailFotograferResponse> getDetailUserFotografer(String idUser) async {
    try {
      final response = await dio.dio.get('v1/admin/photographers/$idUser');
      return handleResponse(response, (data) => UserDetailFotograferResponse.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<AdminDetailResponse> getUserAdminDetail(String id) async {
    try {
      final response = await dio.dio.get('v1/admin/admins/$id');
      return handleResponse(response, (data) => AdminDetailResponse.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<String> putDetailAdmin(AdminDetailModel payload, String idAdmin) async {
    try {
      final response = await dio.dio.put(
        'v1/admin/admins/$idAdmin',
        data: payload.toUpdateJson(),
      );
      return handleResponse(response, (data) {
        if (data is Map && data['message'] is String) {
          return data['message'] as String;
        }
        return "sukses";
      });
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<String> putDetailFotografer(UserDetailFotograferModel payload, String idFotografer) async {
    try {
      final response = await dio.dio.put(
        'v1/admin/photographers/$idFotografer',
        data: payload.toJson()
      );
      return handleResponse(response, (data) => data['message'] as String);
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<String> createAdmin(AdminDetailModel payload) async {
    try {
      final response = await dio.dio.post(
        'v1/admin/admins',
        data: {
          'username': payload.username,
          'password': payload.pw,
          'email': payload.email,
          'name': payload.name,
          'phone_number': payload.phoneNumber
        },
      );
      return handleResponse(response, (data) {
        if (data is Map && data['message'] is String) {
          return data['message'] as String;
        }
        return "sukses";
      });
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<String> createFotografer(CreateFotograferRequest payload) async {
    try {
      final response = await dio.dio.post(
        "v1/admin/photographers",
        data: payload.toJson()
      );
      return handleResponse(response, (data) => data['message'] as String);
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<void> deleteAdmin(String idAdmin) async {
    try {
      final response = await dio.dio.delete('v1/admin/admins/$idAdmin');
      handleResponse(response, (data) => data);
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<String> deleteFotografer(String idFotografer) async {
    try {
      final response = await dio.dio.delete('v1/admin/photographers/$idFotografer');
      return handleResponse(response, (data) => "Foto Grafer Berhasil Di Hapus");
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<UpdateUserResponse> updateUser(String userId, UpdateUserRequest request) async {
    try {
      final response = await dio.dio.put(
        'v1/admin/users/$userId',
        data: request.toJson(),
      );
      return handleResponse(response, (data) => UpdateUserResponse.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<String> deleteUser(String userId) async {
    try {
      final response = await dio.dio.delete('v1/admin/users/$userId');
      return handleResponse(response, (data) {
        if (data is Map && data['message'] is String) {
          return data['message'] as String;
        }
        return 'User deleted successfully';
      });
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<DeleteBatchUserResponse> deleteBatchUser(List<String> userIds) async {
    try {
      final request = DeleteBatchUserRequest(ids: userIds);
      final response = await dio.dio.delete(
        'v1/admin/users/delete-batch',
        data: request.toJson(),
      );
      return handleResponse(response, (data) => DeleteBatchUserResponse.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }
}
