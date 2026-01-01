
import 'package:wavenadmin/domain/entity/dashboard.dart';
import 'package:wavenadmin/domain/repository/dasboard_repository.dart';
class GetDashboard {
  final DasboardRepository dashbaordrepo;
  const GetDashboard(this.dashbaordrepo);

  Future<DashboardEntity> execute()async{
    return dashbaordrepo.getDashboard();
  }
}