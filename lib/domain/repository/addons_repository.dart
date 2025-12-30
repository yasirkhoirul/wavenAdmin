import 'package:wavenadmin/domain/entity/addons_dropdown.dart';
import 'package:wavenadmin/domain/entity/list_addons.dart';

abstract class AddonsRepository {
  Future<ListAddons> getListAddons(int page,int limit,{String? search});
  Future<AddonsDropdown> getAddonsDropdown(int page,int limit,{String? search});
}