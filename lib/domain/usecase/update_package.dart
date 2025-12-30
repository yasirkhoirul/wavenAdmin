import 'dart:typed_data';

import 'package:wavenadmin/data/model/package_detail_model.dart';
import 'package:wavenadmin/domain/repository/package_repository.dart';

class UpdatePackage {
  final PackageRepository packageRepository;
  const UpdatePackage(this.packageRepository);

  Future<String> execute(String idPackage,Uint8List image, PackageDetailData payload)async{
    return packageRepository.updatePackage(image, idPackage, payload);
  }
}