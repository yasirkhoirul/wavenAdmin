import 'package:wavenadmin/domain/repository/package_repository.dart';

class DeletePorto {
  final PackageRepository packageRepository;
  const DeletePorto(this.packageRepository);
  Future<String> execute(String portoId)async{
    return packageRepository.deletePorto(portoId);
  }
}