import 'dart:typed_data';

import 'package:wavenadmin/data/model/create_package_model.dart';
import 'package:wavenadmin/domain/repository/package_repository.dart';

class CreatePackage {
  final PackageRepository packageRepository;
  const CreatePackage(this.packageRepository);

  Future<CreatePackageResponse> execute(CreatePackageRequest request, Uint8List imageFile) async {
    return packageRepository.createPackage(request, imageFile);
  }
}
