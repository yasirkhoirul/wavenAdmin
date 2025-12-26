import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/schedule_entity.dart';
import 'package:wavenadmin/persentation/riverpod/provider/usecase_providers.dart';

part 'get_list_schedule.g.dart';

@riverpod
class GetListSchedule extends _$GetListSchedule {
  @override
  Future<List<ScheduleEntity>> build(int month,int year,VerificationStatus? status  ){
    final usecase = ref.read(getListScheduleUseCase);
    return usecase.execute(month, year,status: status);
  }


  Future<void> onRefresh(int month, int year) async {
    // set loading state
    state = const AsyncValue.loading();

    // run usecase and capture result into AsyncValue
    final result = await AsyncValue.guard<List<ScheduleEntity>>(() async {
      final usecase = ref.read(getListScheduleUseCase);
      return await usecase.execute(month, year);
    });

    // update state with result (data or error)
    state = result;
  }
}