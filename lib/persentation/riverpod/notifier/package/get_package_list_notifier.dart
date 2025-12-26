import 'package:logger/web.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/usecase/get_package_list.dart';
import 'package:wavenadmin/injection.dart';
import 'package:wavenadmin/persentation/riverpod/state/package_list_state.dart';

part 'get_package_list_notifier.g.dart';

@riverpod
class GetPackageListNotifier extends _$GetPackageListNotifier {
  @override
  Future<PackageListState> build(
    int page,
    int limit, {
    String? search,
    Sort? sort,
    bool? status,
  }) async {
    Logger().d("dibuat");
    final usecase = locator<GetPackageList>();
    final data = await usecase.execute(page + 1, limit, search: search, sort: sort, status: status);
    
    return PackageListState(
      currentPage: page,
      highestPage: page,
      isReached: data.data.length < limit,
      item: data.data,
      limit: limit,
      metadata: data.metadata,
    );
  }

  Future<void> appendData() async {
    final currentState = state.value;
    Logger().d("Package list - current page ${currentState?.currentPage}");
    if (currentState == null || currentState.isloadingmore) return;
    
    final nextPage = currentState.currentPage + 1;
    
    // Check if already reached or already have data for next page
    if (currentState.isReached || nextPage <= currentState.highestPage) {
      // Just update currentPage for navigation
      state = AsyncValue.data(
        currentState.copyWith(currentPage: nextPage)
      );
      return;
    }
    
    // Set loading state
    state = AsyncValue.data(
      currentState.copyWith(
        currentPage: nextPage,
        isloading: true
      )
    );
    
    final usecase = locator<GetPackageList>();
    final data = await usecase.execute(nextPage + 1, limit, search: search, sort: sort, status: status);

    state = AsyncValue.data(
      currentState.copyWith(
        currentPage: nextPage,
        highestPage: nextPage > currentState.highestPage ? nextPage : currentState.highestPage,
        isReached: data.data.length < limit,
        isloading: false,
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
