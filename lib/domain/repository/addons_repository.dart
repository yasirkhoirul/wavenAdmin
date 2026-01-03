import 'package:wavenadmin/data/model/addon_detail_model.dart';
import 'package:wavenadmin/domain/entity/addon_detail.dart';
import 'package:wavenadmin/domain/entity/addons_dropdown.dart';
import 'package:wavenadmin/domain/entity/list_addons.dart';

abstract class AddonsRepository {
  Future<ListAddons> getListAddons(int page,int limit,{String? search});
  Future<AddonDetail> getAddonDetail(String addonId);
  Future<String> updateAddon(String addonId, UpdateAddonRequest request);
  Future<String> createAddon(CreateAddonRequest request);
  Future<String> deleteAddon(String addonId);
  Future<AddonsDropdown> getAddonsDropdown(int page,int limit,{String? search});
}