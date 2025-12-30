import 'package:wavenadmin/domain/entity/addons_dropdown.dart';
import 'package:wavenadmin/domain/repository/addons_repository.dart';

class GetAddonsDropdown {
  final AddonsRepository addonsRepository;
  const GetAddonsDropdown(this.addonsRepository);

  Future<AddonsDropdown> execute(int page,int limit,{String? search})async{
    return addonsRepository.getAddonsDropdown(page, limit,search: search);
  }
}