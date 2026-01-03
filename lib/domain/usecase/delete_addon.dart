import 'package:wavenadmin/domain/repository/addons_repository.dart';

class DeleteAddon {
  final AddonsRepository repository;

  DeleteAddon(this.repository);

  Future<String> execute(String addonId) async {
    return repository.deleteAddon(addonId);
  }
}
