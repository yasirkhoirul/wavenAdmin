import 'package:wavenadmin/data/model/addon_detail_model.dart';
import 'package:wavenadmin/domain/repository/addons_repository.dart';

class CreateAddon {
  final AddonsRepository repository;

  CreateAddon(this.repository);

  Future<String> execute(CreateAddonRequest request) async {
    return repository.createAddon(request);
  }
}
