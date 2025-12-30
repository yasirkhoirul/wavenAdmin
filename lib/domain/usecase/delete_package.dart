import 'package:wavenadmin/data/model/create_package_model.dart';
import 'package:wavenadmin/domain/repository/package_repository.dart';

class DeletePackage {
  final PackageRepository packageRepository;
  const DeletePackage(this.packageRepository);

  Future<DeletePackageResponse> execute(String packageId) async {
    return packageRepository.deletePackage(packageId);
  }
}
