import 'package:wavenadmin/domain/entity/university_detail.dart';
import 'package:wavenadmin/domain/repository/referensi_repository.dart';

class GetUniversityDetail {
  final ReferensiRepository repository;

  GetUniversityDetail(this.repository);

  Future<UniversityDetail> call(String universityId) {
    return repository.getDetailUniversity(universityId);
  }
}

class UpdateUniversity {
  final ReferensiRepository repository;

  UpdateUniversity(this.repository);

  Future<String> call(String universityId, String name, String briefName, String address, bool isActive) {
    return repository.updateUniversity(universityId, name, briefName, address, isActive);
  }
}
