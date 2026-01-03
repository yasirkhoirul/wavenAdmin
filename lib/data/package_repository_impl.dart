import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/data/datasource/remote_data.dart';
import 'package:wavenadmin/data/model/create_package_model.dart';
import 'package:wavenadmin/data/model/package_detail_model.dart';
import 'package:wavenadmin/domain/entity/package_dropdown.dart';
import 'package:wavenadmin/domain/entity/package_list.dart';
import 'package:wavenadmin/domain/entity/porto_list.dart';
import 'package:wavenadmin/domain/repository/package_repository.dart';

class PackageRepositoryImpl implements PackageRepository {
  final RemoteData remoteData;
  const PackageRepositoryImpl(this.remoteData);

  @override
  Future<PackageDropdown> getPackageDropdown(int page, int limit, {String? search}) async {
    try {
      final response = await remoteData.getPackageDropdown(page, limit, search: search);
      return response.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PackageDetailResponse> getPackageDetail(String packageId) async {
    try {
      final response = await remoteData.getPackageDetail(packageId);

      Uint8List? bannerBytes;
      try {
        final bannerUrl = response.data.bannerUrl;
        if (bannerUrl.isNotEmpty) {
          final dio = Dio();
          final uri = Uri.parse(bannerUrl);
          final resp = await dio.getUri(uri, options: Options(responseType: ResponseType.bytes));
          final data = resp.data;
          if (data is Uint8List) {
            bannerBytes = data;
          } else if (data is List<int>) {
            bannerBytes = Uint8List.fromList(data);
          }
        }
      } catch (_) {
        // ignore image fetch errors, return without image bytes
        bannerBytes = null;
      }

      final newData = PackageDetailData(
        id: response.data.id,
        title: response.data.title,
        price: response.data.price,
        bannerUrl: response.data.bannerUrl,
        description: response.data.description,
        isActive: response.data.isActive,
        createdAt: response.data.createdAt,
        benefits: response.data.benefits,
        gambarDetail: bannerBytes,
      );

      return PackageDetailResponse(message: response.message, data: newData);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PackageList> getPackageList(int page, int limit, {String? search, Sort? sort, bool? status}) async {
    try {
      final response = await remoteData.getPackageList(page, limit, search: search, sort: sort, status: status);
      
      return PackageList(
        metadata: PackageMetadataEntity(
          count: response.metadata?.count??0,
          totalPages: response.metadata?.totalPages??0,
          page: response.metadata?.page??0,
          limit: response.metadata?.limit??limit,
        ),
        data: response.data.map((item) => PackageItem(
          id: item.id,
          title: item.title,
          price: item.price,
          bannerUrl: item.bannerUrl,
          description: item.description,
          benefits: item.benefits,
        )).toList(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> updatePackage(Uint8List image, String idPackage, PackageDetailData payload) async{
    try {
      final response = await remoteData.updatePackage(image, payload, idPackage);
      return  response;
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<CreatePackageResponse> createPackage(CreatePackageRequest request, Uint8List imageFile) async {
    try {
      final response = await remoteData.createPackage(request, imageFile);
      return response;
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<DeletePackageResponse> deletePackage(String packageId) async {
    try {
      final response = await remoteData.deletePackage(packageId);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> addPorto(XFile image,String packageId) async{
    try {
      final response = await remoteData.addPorto(image,packageId);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> deletePorto(String portoId) async{
    try {
      final response = await remoteData.deletePorto(portoId);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PortoList> getListPorto(String packageId)async {
    try {
      final response = await remoteData.getListPorto(packageId);
      return response.toEntity();
    } catch (e) {
      rethrow;
    }
  }
}