import 'package:wavenadmin/domain/entity/university_detail.dart';
import 'package:wavenadmin/domain/entity/university_dropdown.dart';

abstract class UniversityRepository {
  Future<UniversityDropdown> getUniversityDropdown(int page, int limit, {String? search});
  Future<String> createUniv(UniversityDetail payload);
  Future<String> deleteUniv(String idUniv);
}
