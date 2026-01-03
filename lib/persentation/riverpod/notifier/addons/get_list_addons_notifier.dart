

import 'dart:async';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/domain/entity/list_addons.dart';
import 'package:wavenadmin/persentation/riverpod/provider/usecase_providers.dart';

part 'get_list_addons_notifier.g.dart';

@riverpod
class GetListAddonsNotifier extends _$GetListAddonsNotifier{
  Timer? _debounceTimer;

  @override
  Future<ListAddons> build(int page, int limit, {String? search}) async{
    // Cancel timer when provider is disposed
    ref.onDispose(() {
      _debounceTimer?.cancel();
    });
    
    final usecase = ref.read(getListAddons);
    return await usecase.execute(page+1, limit, search: search);
  }

  void onBack()async{
    final currentpage = state.asData?.value;
    if(currentpage == null||currentpage.page <= 1) return;
    state = AsyncData(
      currentpage.copyWith(
        page: currentpage.page - 1
      )
    );
    
  }

  void onAdd(int limit, {String? search})async{
    final currentState = state.asData?.value;
    if(currentState == null||currentState.page >= currentState.totalPages)return;
    final nextPage = currentState.page + 1;
    state = AsyncData(
      currentState.copyWith(
        page: nextPage
      )
    );
    Logger().d("highest page ${currentState.highestpage} next page $nextPage");
    if(currentState.highestpage>=nextPage||currentState.isReached)return;
    state = AsyncLoading();
    final usecase = ref.read(getListAddons);
    final response = await usecase.execute(nextPage, limit,search: search);
    state = AsyncData(
      currentState.copyWith(
        page: nextPage,
        highestpage: nextPage,
        isReached: response.addons.length<limit,
      )
    );
    Logger().d("highest page ${currentState.page} next page $nextPage");
    state = AsyncData(
      state.asData?.value.appendMode(addons: response.addons)??currentState
    );
  }

  // Method untuk search dengan debouncing 2 detik
  void onSearch(int pages, int limit, {String? search}) {
    // Cancel timer sebelumnya jika ada
    _debounceTimer?.cancel();
    
    _debounceTimer = Timer(const Duration(seconds: 2), () async {
      state = const AsyncLoading();
      final response = await AsyncValue.guard(() async {
        final usecase = ref.read(getListAddons);
        return await usecase.execute(pages, limit, search: search);
      });
      state = response;
    });
  }
  
  // Method untuk refresh tanpa debouncing (untuk tombol refresh/load more)
  Future<void> refresh(int page, int limit, {String? search}) async {
    state = const AsyncLoading();
    final response = await AsyncValue.guard(() async {
      final usecase = ref.read(getListAddons);
      return await usecase.execute(page + 1, limit, search: search);
    });
    state = response;
  }
}