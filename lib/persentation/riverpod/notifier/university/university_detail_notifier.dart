import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/domain/entity/university_detail.dart';
import 'package:wavenadmin/injection.dart';
import 'package:wavenadmin/domain/usecase/get_university_detail.dart';
import 'package:wavenadmin/domain/usecase/get_university_detail.dart' as usecase;

part 'university_detail_notifier.g.dart';

@riverpod
class UniversityDetailNotifier extends _$UniversityDetailNotifier {
  @override
  Future<UniversityDetail> build(String universityId) async {
    final getDetail = locator<GetUniversityDetail>();
    return await getDetail(universityId);
  }

  Future<void> updateUniversity({
    required String name,
    required String briefName,
    required String address,
    required bool isActive,
  }) async {
    final universityId = state.value?.id;
    if (universityId == null) return;

    state = const AsyncValue.loading();
    
    try {
      final updateUsecase = locator<usecase.UpdateUniversity>();
      await updateUsecase(universityId, name, briefName, address, isActive);
      
      // Reload data after update
      final getDetail = locator<GetUniversityDetail>();
      final updatedData = await getDetail(universityId);
      state = AsyncValue.data(updatedData);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
  
}
