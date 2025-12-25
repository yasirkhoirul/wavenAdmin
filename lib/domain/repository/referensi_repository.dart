import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/universitas_list.dart';
import 'package:wavenadmin/domain/entity/university_detail.dart';

abstract class ReferensiRepository {
  Future<UniversitasList> getListUniversitas(int page, int limit, {String? search, Sort? sort});
  Future<UniversityDetail> getDetailUniversity(String universityId);
  Future<String> updateUniversity(String universityId, String name, String briefName, String address, bool isActive);
}