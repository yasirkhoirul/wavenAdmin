import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/package_list.dart';
import 'package:wavenadmin/domain/repository/package_repository.dart';

class GetPackageList {
  final PackageRepository repository;

  GetPackageList(this.repository);

  Future<PackageList> execute(int page, int limit, {String? search, Sort? sort, bool? status}) {
    return repository.getPackageList(page, limit, search: search, sort: sort, status: status);
  }
}
