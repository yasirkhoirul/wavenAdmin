import 'package:wavenadmin/data/datasource/remote_data.dart';
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
  Future<AddonsDropdown> getAddonsDropdown(int page,int limit,{String? search}) async{
    final response = await remoteData.getAddonsDropdown(page, limit,search: search);
    return  response.toEntity();
  }

}