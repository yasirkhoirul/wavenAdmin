import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/data/datasource/base/base_remote_data_source.dart';
import 'package:wavenadmin/data/model/create_package_model.dart';
import 'package:wavenadmin/data/model/package_detail_model.dart';
import 'package:wavenadmin/data/model/package_dropdown_model.dart';
import 'package:wavenadmin/data/model/package_list_model.dart';
import 'package:wavenadmin/data/model/porto_list_model.dart';

abstract class PackageRemoteDataSource {
  Future<PackageDropdownResponse> getPackageDropdown(int page, int limit, {String? search});
  Future<PackageDetailResponse> getPackageDetail(String packageId);
  Future<PackageListModel> getPackageList(int page, int limit, {String? search, Sort? sort, bool? status});
  Future<String> updatePackage(Uint8List gambar, PackageDetailData packageDetail, String idPackage);
  Future<CreatePackageResponse> createPackage(CreatePackageRequest request, Uint8List imageFile);
  Future<DeletePackageResponse> deletePackage(String packageId);
  Future<PortoListResponse> getListPorto(String packageId);
  Future<String> addPorto(XFile image, String packageId);
  Future<String> deletePorto(String portoId);
}

class PackageRemoteDataSourceImpl extends BaseRemoteDataSource 
    implements PackageRemoteDataSource {
  
  PackageRemoteDataSourceImpl(super.dio);

  @override
  Future<PackageDropdownResponse> getPackageDropdown(int page, int limit, {String? search}) async {
    try {
      final response = await dio.dio.get('v1/admin/packages/dropdown',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (search != null) 'search': search,
        });
      return handleResponse(response, (data) => PackageDropdownResponse.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<PackageDetailResponse> getPackageDetail(String packageId) async {
    try {
      final response = await dio.dio.get('v1/admin/packages/$packageId');
      return handleResponse(response, (data) => PackageDetailResponse.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<PackageListModel> getPackageList(int page, int limit, {String? search, Sort? sort, bool? status}) async {
    try {
      final response = await dio.dio.get('v1/admin/packages',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (search != null && search.isNotEmpty) 'search': search,
          if (sort != null) 'sort': sort.name,
          if (status != null) 'status': status,
        });
      return handleResponse(response, (data) => PackageListModel.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<String> updatePackage(Uint8List gambar, PackageDetailData payload, String idPackage) async {
    try {
      final formMap = FormData();

      formMap.fields.add(MapEntry("data", jsonEncode({
        'title': payload.title,
        'description': payload.description,
        'price': payload.price,
        'is_active': payload.isActive,
        'benefits': payload.benefits
      })));
      formMap.files.add(
        MapEntry('image', MultipartFile.fromBytes(gambar, filename: "image.png")),
      );

      final response = await dio.dio.put('v1/admin/packages/$idPackage', data: formMap);
      if (response.statusCode != 200) {
        throw AppException(response.data['message']);
      }
      return response.data['message'];
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<CreatePackageResponse> createPackage(CreatePackageRequest request, Uint8List imageFile) async {
    try {
      final formMap = FormData();
      
      formMap.fields.add(MapEntry("data", jsonEncode(request.toJson())));
      formMap.files.add(
        MapEntry('image', MultipartFile.fromBytes(imageFile, filename: "image.png")),
      );
      
      final response = await dio.dio.post('v1/admin/packages', data: formMap);
      if (response.statusCode != 201) {
        throw AppException(response.data['message']);
      }
      return CreatePackageResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<DeletePackageResponse> deletePackage(String packageId) async {
    try {
      final response = await dio.dio.delete('v1/admin/packages/$packageId');
      return handleResponse(response, (data) => DeletePackageResponse.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<String> addPorto(XFile image, String packageId) async {
    try {
      final formData = FormData();
      final List<int> imageData = await image.readAsBytes();
      formData.files.add(MapEntry(
        "image", MultipartFile.fromBytes(imageData, filename: "image.png")));

      formData.fields.add(MapEntry("data", jsonEncode({
        'package_id': packageId
      })));
      final response = await dio.dio.post("v1/admin/master/portfolios", data: formData);
      if (response.statusCode != 201) {
        throw AppException(response.data['message']);
      }
      return response.data['message'];
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<String> deletePorto(String portoId) async {
    try {
      final response = await dio.dio.delete("v1/admin/master/portfolios/$portoId");
      if (response.statusCode != 200) {
        throw AppException(response.data['message']);
      }
      return response.data['message'];
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }

  @override
  Future<PortoListResponse> getListPorto(String packageId) async {
    try {
      final response = await dio.dio.get("v1/admin/master/portfolios", queryParameters: {
        'package': packageId
      });
      if (response.statusCode != 200) {
        throw AppException(response.data['message']);
      }
      return PortoListResponse.fromJson(response.data);
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }
}
