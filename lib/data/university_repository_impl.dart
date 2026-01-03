import 'package:wavenadmin/data/datasource/university_remote_data_source.dart';
import 'package:wavenadmin/data/model/university_detail_model.dart';
import 'package:wavenadmin/domain/entity/university_detail.dart';
import 'package:wavenadmin/domain/entity/university_dropdown.dart';
import 'package:wavenadmin/domain/repository/university_repository.dart';

class UniversityRepositoryImpl implements UniversityRepository {
  final UniversityRemoteDataSource remoteData;
  const UniversityRepositoryImpl(this.remoteData);

  @override
  Future<UniversityDropdown> getUniversityDropdown(int page, int limit, {String? search}) async {
    final response = await remoteData.getUniversityDropdown(page, limit, search: search);
    return response.toEntity();
  }

  @override
  Future<String> createUniv(UniversityDetail payload)async {
    // Convert entity to model
    final model = UniversityDetailData(
      id: payload.id,
      name: payload.name,
      briefName: payload.briefName,
      address: payload.address,
      isActive: payload.isActive,
      createdAt: payload.createdAt
    );
    final response = await remoteData.createUniv(model);
    return response;
  }
  
  @override
  Future<String> deleteUniv(String idUniv) async{
    await remoteData.deleteUniv(idUniv);
    return "Univ berhasil dihapus"; 
  }
}
