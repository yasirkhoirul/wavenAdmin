import 'package:wavenadmin/data/model/package_detail_model.dart';
import 'package:wavenadmin/domain/entity/package_dropdown.dart';

abstract class PackageRepository {
  Future<PackageDropdown> getPackageDropdown(int page, int limit, {String? search});
  Future<PackageDetailResponse> getPackageDetail(String packageId);
}
