import 'package:wavenadmin/domain/entity/package_dropdown.dart';

abstract class PackageRepository {
  Future<PackageDropdown> getPackageDropdown(int page, int limit, {String? search});
}
