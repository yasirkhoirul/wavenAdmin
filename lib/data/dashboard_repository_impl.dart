import 'package:wavenadmin/data/datasource/dashboard_remote_data_source.dart';
import 'package:wavenadmin/domain/entity/dashboard.dart';
import 'package:wavenadmin/domain/repository/dasboard_repository.dart';

class DashboardRepositoryImpl implements DasboardRepository {
  final DashboardRemoteDataSource remoteData;
  const DashboardRepositoryImpl(this.remoteData);
  @override
  Future<DashboardEntity> getDashboard() async{
    final response = await remoteData.getDashboard();
    return response.data.toEntity();
  }
  
  
}