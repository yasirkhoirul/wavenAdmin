import 'package:image_picker/image_picker.dart';
import 'package:wavenadmin/domain/repository/package_repository.dart';

class CreatePorto {
  final PackageRepository packageRepository;
  const CreatePorto(this.packageRepository);
  Future<String> execute(XFile image,String packageId)async{
    return packageRepository.addPorto(image,packageId);
  }
}