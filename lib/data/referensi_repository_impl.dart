import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/data/datasource/remote_data.dart';
import 'package:wavenadmin/data/model/university_detail_model.dart';
import 'package:wavenadmin/domain/entity/universitas_list.dart';
import 'package:wavenadmin/domain/entity/university_detail.dart';
import 'package:wavenadmin/domain/repository/referensi_repository.dart';

class ReferensiRepositoryImpl implements ReferensiRepository {
  final RemoteData remoteData;

  ReferensiRepositoryImpl(this.remoteData);

  @override
  Future<UniversitasList> getListUniversitas(int page, int limit, {String? search, Sort? sort}) async {
    final model = await remoteData.getListUniversitas(page, limit, search: search, sort: sort);
    
    return UniversitasList(
      message: model.message,
      metadata: UniversityMetadata(
        count: model.metadata?.count,
        totalPages: model.metadata?.totalPages,
        page: model.metadata?.page,
        limit: model.metadata?.limit,
      ),
      data: model.data.map((item) => UniversityItem(
        id: item.id,
        name: item.name,
        briefName: item.briefName,
        address: item.address,
        isActive: item.isActive,
        createdAt: item.createdAt,
      )).toList(),
    );
  }

  @override
  Future<UniversityDetail> getDetailUniversity(String universityId) async {
    final response = await remoteData.getDetailUniversity(universityId);
    return UniversityDetail(
      id: response.data.id,
      name: response.data.name,
      briefName: response.data.briefName,
      address: response.data.address,
      isActive: response.data.isActive,
      createdAt: response.data.createdAt,
    );
  }

  @override
  Future<String> updateUniversity(String universityId, String name, String briefName, String address, bool isActive) async {
    final request = UpdateUniversityRequest(
      name: name,
      briefName: briefName,
      address: address,
      isActive: isActive,
    );
    final response = await remoteData.updateUniversity(universityId, request);
    return response.message;
  }
}