import 'package:wavenadmin/domain/entity/porto_list.dart';
import 'package:wavenadmin/domain/repository/package_repository.dart';

class GetPorto{
  final PackageRepository packageRepository;
  const GetPorto(this.packageRepository);

  Future<PortoList> execute(String packageId)async{
    return packageRepository.getListPorto(packageId);
  }
}