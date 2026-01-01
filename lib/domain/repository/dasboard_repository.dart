import 'package:wavenadmin/domain/entity/dashboard.dart';

abstract class DasboardRepository {
  Future<DashboardEntity> getDashboard();
}