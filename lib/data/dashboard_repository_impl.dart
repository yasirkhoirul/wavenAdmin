import 'package:wavenadmin/data/datasource/remote_data.dart';
import 'package:wavenadmin/domain/entity/dashboard.dart';
import 'package:wavenadmin/domain/repository/dasboard_repository.dart';

class DashboardRepositoryImpl implements DasboardRepository {
  final RemoteData remoteData;
  const DashboardRepositoryImpl(this.remoteData);
  @override
  Future<DashboardEntity> getDashboard() async{
    try {
      final response = await remoteData.getDashboard();
      return response.data.toEntity();
    } catch (e) {
      rethrow;
    }
  }
  
  
}