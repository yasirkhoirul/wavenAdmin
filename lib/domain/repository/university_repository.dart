import 'package:wavenadmin/domain/entity/university_dropdown.dart';

abstract class UniversityRepository {
  Future<UniversityDropdown> getUniversityDropdown(int page, int limit, {String? search});
}
