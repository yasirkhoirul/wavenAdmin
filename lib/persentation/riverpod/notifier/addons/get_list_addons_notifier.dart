

import 'dart:async';
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
    return await usecase.execute(page, limit, search: search);
  }

  // Method untuk search dengan debouncing 2 detik
  void onSearch(int page, int limit, {String? search}) {
    // Cancel timer sebelumnya jika ada
    _debounceTimer?.cancel();
    
    _debounceTimer = Timer(const Duration(seconds: 2), () async {
      state = const AsyncLoading();
      final response = await AsyncValue.guard(() async {
        final usecase = ref.read(getListAddons);
        return await usecase.execute(page, limit, search: search);
      });
      state = response;
    });
  }
  
  // Method untuk refresh tanpa debouncing (untuk tombol refresh/load more)
  Future<void> refresh(int page, int limit, {String? search}) async {
    state = const AsyncLoading();
    final response = await AsyncValue.guard(() async {
      final usecase = ref.read(getListAddons);
      return await usecase.execute(page, limit, search: search);
    });
    state = response;
  }
}