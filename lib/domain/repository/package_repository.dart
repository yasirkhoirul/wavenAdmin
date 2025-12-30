import 'dart:typed_data';

import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/data/model/create_package_model.dart';
import 'package:wavenadmin/data/model/package_detail_model.dart';
import 'package:wavenadmin/domain/entity/package_dropdown.dart';
import 'package:wavenadmin/domain/entity/package_list.dart';

abstract class PackageRepository {
  Future<PackageDropdown> getPackageDropdown(int page, int limit, {String? search});
  Future<PackageDetailResponse> getPackageDetail(String packageId);
  Future<PackageList> getPackageList(int page, int limit, {String? search, Sort? sort, bool? status});
  Future<String> updatePackage(Uint8List image,String idPackage,PackageDetailData payload);
  Future<CreatePackageResponse> createPackage(CreatePackageRequest request, Uint8List imageFile);
  Future<DeletePackageResponse> deletePackage(String packageId);
}
