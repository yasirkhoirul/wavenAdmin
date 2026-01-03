import 'package:wavenadmin/data/datasource/remote_data.dart';
import 'package:wavenadmin/data/model/addon_detail_model.dart';
import 'package:wavenadmin/domain/entity/addon_detail.dart';
import 'package:wavenadmin/domain/entity/addons_dropdown.dart';
import 'package:wavenadmin/domain/entity/list_addons.dart';
import 'package:wavenadmin/domain/repository/addons_repository.dart';

class AddonsRepositoryImpl implements AddonsRepository{
  final RemoteData remoteData;
  const AddonsRepositoryImpl(this.remoteData);
  @override
  Future<ListAddons> getListAddons(int page, int limit, {String? search})async {
    final responseData = await remoteData.getListAddons(page, limit,search: search);
    return responseData.toEntity();
  }

  @override
  Future<AddonDetail> getAddonDetail(String addonId) async {
    final response = await remoteData.getAddonDetail(addonId);
    return response.toEntity();
  }

  @override
  Future<String> updateAddon(String addonId, UpdateAddonRequest request) async {
    final response = await remoteData.updateAddon(addonId, request);
    return response;
  }

  @override
  Future<String> createAddon(CreateAddonRequest request) async {
    final response = await remoteData.createAddon(request);
    return response.message;
  }

  @override
  Future<String> deleteAddon(String addonId) async {
    final response = await remoteData.deleteAddon(addonId);
    return response.message;
  }
  
  @override
  Future<AddonsDropdown> getAddonsDropdown(int page,int limit,{String? search}) async{
    final response = await remoteData.getAddonsDropdown(page, limit,search: search);
    return  response.toEntity();
  }

}