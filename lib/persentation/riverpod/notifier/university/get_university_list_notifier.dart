import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/persentation/riverpod/provider/usecase_providers.dart';
import 'package:wavenadmin/persentation/riverpod/state/universitas_list_state.dart';

part 'get_university_list_notifier.g.dart';

@riverpod
class GetUniversityListNotifier extends _$GetUniversityListNotifier {
  @override
  Future<UniversitasListState> build(
    int page,
    int limit, {
    String? search,
    Sort? sort,
  }) async {
    final usecase = ref.read(getListUniversitasUseCse);
    final data = await usecase.execute(page, limit, search: search, sort: sort);
    
    return UniversitasListState(
      currentPage: 0,
      highestPage: 0,
      isReached: data.data.length < limit,
      item: data.data,
      limit: limit,
      metadata: data.metadata,
      page: page,
    );
  }

  Future<void> appendData(int page,
    int limit, {
    String? search,
    Sort? sort,
  }) async {
    final currentState = state.value;
    if (currentState == null||currentState.isloadingmore) return;
    state = AsyncValue.data(
      currentState.copyWith(
        currentPage: currentState.currentPage+1
      )
    );
    if(currentState.isReached||currentState.currentPage<currentState.highestPage)return;
    state = AsyncValue.data(
      currentState.copyWith(
        isloading: true
      )
    );
    final usecase = ref.read(getListUniversitasUseCse);
    final data = await usecase.execute(currentState.page, limit, search: search, sort: sort);

    state = AsyncValue.data(
      currentState.copyWith(
        highestPage: currentState.page > currentState.highestPage ? currentState.page : currentState.highestPage,
        isReached: data.data.length < limit,
        page: currentState.page,
      ).appendData(item: data.data),
    );
  }

  void back() {
    final currentState = state.value;
    if (currentState == null || currentState.currentPage <= 0) return;

    state = AsyncValue.data(
      currentState.copyWith(
        currentPage: currentState.currentPage - 1,
      ),
    );
  }
}
