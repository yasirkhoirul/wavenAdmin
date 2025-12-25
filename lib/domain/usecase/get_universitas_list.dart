import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/universitas_list.dart';
import 'package:wavenadmin/domain/repository/referensi_repository.dart';

class GetUniversitasList {
  final ReferensiRepository repository;

  GetUniversitasList(this.repository);

  Future<UniversitasList> execute(int page, int limit, {String? search, Sort? sort}) {
    return repository.getListUniversitas(page, limit, search: search, sort: sort);
  }
}
