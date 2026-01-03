import 'package:wavenadmin/domain/entity/addon_detail.dart';
import 'package:wavenadmin/domain/repository/addons_repository.dart';

class GetAddonDetail {
  final AddonsRepository repository;
  const GetAddonDetail(this.repository);

  Future<AddonDetail> execute(String addonId) async {
    return repository.getAddonDetail(addonId);
  }
}
