import 'package:wavenadmin/domain/entity/package_dropdown.dart';
import 'package:wavenadmin/domain/repository/package_repository.dart';

class GetPackageDropdown {
  final PackageRepository repository;
  const GetPackageDropdown(this.repository);

  Future<PackageDropdown> execute(int page, int limit, {String? search}) async {
    return await repository.getPackageDropdown(page, limit, search: search);
  }
}
