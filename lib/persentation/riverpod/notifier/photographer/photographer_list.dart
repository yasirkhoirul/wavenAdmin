import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/data/model/usermodel.dart';
import 'package:wavenadmin/persentation/riverpod/state/photographer_paged_state.dart';
import 'package:wavenadmin/persentation/riverpod/provider/usecase_providers.dart';

part 'photographer_list.g.dart';

@riverpod
class PhotographerList extends _$PhotographerList {
  static const int limit = 10;

  @override
  PhotographerPagedState build() {
    return const PhotographerPagedState(isLoading: true);
  }

  Future<void> loadFirstPage({String? search, Sort? sort,SortPhotographer? sortBy}) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final usecase = ref.read(getListPhotoGraperProvider);
      final result = await usecase.execute(1, limit, search: search, sort: sort,sortBy: sortBy);

      // Guard: check if still mounted after async gap
      if (!ref.mounted) return;

      state = state.copyWith(
        items: result.listData,
        metadata: result.metada??Metadata(count: 0, totalPages: 0, page: 0, limit: limit),
        currentPage: 0,
        highestPage: 0,
        hasMore: result.listData.length == limit,
        isLoading: false,
        clearError: true,
      );
    } catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(isLoading: false, error: e);
    }
  }
  void prevPage(){
    if(state.currentPage == 0)return;
    state  = state.copyWith(
      currentPage: state.currentPage -1
    );
  }

  Future<void> loadMore({String? search, Sort? sort,SortPhotographer? sortBy}) async {
    
    if (state.isLoading || state.isLoadingMore) return;
    if(state.currentPage==state.highestPage && !state.hasMore)return;
    state = state.copyWith(currentPage: state.currentPage+1);
    if (state.currentPage<=state.highestPage)return;
    
    state = state.copyWith(isLoadingMore: true, clearError: true);
    try {
      if(state.currentPage>state.highestPage) state = state.copyWith(highestPage: state.currentPage);
      final usecase = ref.read(getListPhotoGraperProvider);
      final result = await usecase.execute(state.highestPage+1, limit, search: search, sort: sort,sortBy: sortBy);

      // Guard: check if still mounted after async gap
      if (!ref.mounted) return;
      state = state.copyWith(
        items: [...state.items, ...result.listData],
        hasMore: result.listData.length == limit,
        isLoadingMore: false,
        clearError: true,
      );
    } catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(isLoadingMore: false, error: e);
    }
  }

  Future<void> refresh({String? search, Sort? sort}) async {
    state = const PhotographerPagedState(isLoading: true);
    await loadFirstPage(search: search, sort: sort);
  }
}