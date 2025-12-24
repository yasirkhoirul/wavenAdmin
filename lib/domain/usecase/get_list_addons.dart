import 'package:wavenadmin/domain/entity/list_addons.dart';
import 'package:wavenadmin/domain/repository/addons_repository.dart';

class GetListAddons {
  final AddonsRepository addonsRepository;
  const GetListAddons(this.addonsRepository);

  Future<ListAddons> execute(int page, int limit, {String? search})async{
    return addonsRepository.getListAddons(page, limit,search: search);
  }
}