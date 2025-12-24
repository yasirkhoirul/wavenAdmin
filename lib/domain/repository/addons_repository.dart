import 'package:wavenadmin/domain/entity/list_addons.dart';

abstract class AddonsRepository {
  Future<ListAddons> getListAddons(int page,int limit,{String? search});
}