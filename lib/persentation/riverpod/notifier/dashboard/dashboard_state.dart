

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/domain/entity/dashboard.dart';
import 'package:wavenadmin/persentation/riverpod/provider/usecase_providers.dart';


part 'dashboard_state.g.dart';

@riverpod
Future<DashboardEntity> getDashboardState(Ref ref){
  final usecase = ref.read(getDashboardProviderUseCase);
  return usecase.execute();
}