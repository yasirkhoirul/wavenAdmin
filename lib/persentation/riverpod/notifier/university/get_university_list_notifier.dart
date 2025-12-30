import 'package:logger/web.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/universitas_list.dart';
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
    final data = await usecase.execute(page+1, limit, search: search, sort: sort);
    
    return UniversitasListState(
      currentPage: page,
      highestPage: page,
      isReached: data.data.length < limit,
      item: data.data,
      limit: limit,
      metadata:data.metadata.totalPages == null? UniversityMetadata(count: 0, totalPages: 0, page: 0, limit: limit): data.metadata,
    );
  }

  Future<void> appendData() async {
    final currentState = state.value;
    Logger().d("ini adalah kondisi current page ${currentState?.currentPage} isloading more = ${currentState?.isloadingmore} dan current state = $currentState");
    if (currentState == null||currentState.isloadingmore) return;
    
    final nextPage = currentState.currentPage + 1;
    
    // Check if already reached or already have data for next page
    if(currentState.isReached || nextPage <= currentState.highestPage) {
      // Just update currentPage for navigation
      state = AsyncValue.data(
        currentState.copyWith(
          currentPage: nextPage
        )
      );
      Logger().d("masuk ke next page");
      return;
    }
    
    // Set loading state
    state = AsyncValue.data(
      currentState.copyWith(
        currentPage: nextPage,
        isloading: true
      )
    );
    
    Logger().d("fetching page $nextPage");
    final usecase = ref.read(getListUniversitasUseCse);
    final data = await usecase.execute(nextPage+1, limit, search: search, sort: sort);

    state = AsyncValue.data(
      currentState.copyWith(
        currentPage: nextPage,
        highestPage: nextPage > currentState.highestPage ? nextPage : currentState.highestPage,
        isReached: data.data.length < limit,
        isloading: false,
      ).appendData(item: data.data),
    );
    Logger().d("current page setelah append ${state.value?.currentPage}");
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
