import 'package:wavenadmin/data/datasource/remote_data.dart';
import 'package:wavenadmin/domain/entity/university_detail.dart';
import 'package:wavenadmin/domain/entity/university_dropdown.dart';
import 'package:wavenadmin/domain/repository/university_repository.dart';

class UniversityRepositoryImpl implements UniversityRepository {
  final RemoteData remoteData;
  const UniversityRepositoryImpl(this.remoteData);

  @override
  Future<UniversityDropdown> getUniversityDropdown(int page, int limit, {String? search}) async {
    try {
      final response = await remoteData.getUniversityDropdown(page, limit, search: search);
      return response.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> createUniv(UniversityDetail payload)async {
    try {
      final response = await remoteData.createUniv(payload);
      return response;
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<String> deleteUniv(String idUniv) async{
    try {
      await remoteData.deleteUniv(idUniv);
      return "Univ berhasil dihapus"; 
    } catch (e) {
      rethrow;
    }
  }
}
