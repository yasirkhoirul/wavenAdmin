import 'package:wavenadmin/data/datasource/remote_data.dart';
import 'package:wavenadmin/domain/entity/package_dropdown.dart';
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
}
