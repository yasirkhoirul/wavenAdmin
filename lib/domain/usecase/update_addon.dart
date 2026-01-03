import 'package:wavenadmin/data/model/addon_detail_model.dart';
import 'package:wavenadmin/domain/entity/addon_detail.dart';
import 'package:wavenadmin/domain/repository/addons_repository.dart';

class UpdateAddon {
  final AddonsRepository repository;
  const UpdateAddon(this.repository);

  Future<String> execute(String addonId, UpdateAddonRequest request) async {
    return repository.updateAddon(addonId, request);
  }
}
