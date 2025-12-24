import 'package:wavenadmin/domain/entity/university_dropdown.dart';
import 'package:wavenadmin/domain/repository/university_repository.dart';

class GetUniversityDropdown {
  final UniversityRepository repository;
  const GetUniversityDropdown(this.repository);

  Future<UniversityDropdown> execute(int page, int limit, {String? search}) async {
    return await repository.getUniversityDropdown(page, limit, search: search);
  }
}
