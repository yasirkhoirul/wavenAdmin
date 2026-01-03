import 'package:wavenadmin/data/datasource/base/base_remote_data_source.dart';
import 'package:wavenadmin/data/model/dashboard_model.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardResponse> getDashboard();
}

class DashboardRemoteDataSourceImpl extends BaseRemoteDataSource 
    implements DashboardRemoteDataSource {
  
  DashboardRemoteDataSourceImpl(super.dio);

  @override
  Future<DashboardResponse> getDashboard() async {
    try {
      final response = await dio.dio.get('v1/admin/dashboard');
      return handleResponse(response, (data) => DashboardResponse.fromJson(data));
    } catch (e) {
      throw AppException(friendlyErrorMessage(e));
    }
  }
}
