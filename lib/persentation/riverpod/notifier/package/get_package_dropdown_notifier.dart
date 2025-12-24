import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/domain/entity/package_dropdown.dart';
import 'package:wavenadmin/persentation/riverpod/provider/usecase_providers.dart';

part 'get_package_dropdown_notifier.g.dart';

@riverpod
class GetPackageDropdownNotifier extends _$GetPackageDropdownNotifier {
  Timer? _debounceTimer;

  @override
  Future<PackageDropdown> build(int page, int limit, {String? search}) async {
    ref.onDispose(() {
      _debounceTimer?.cancel();
    });
    
    final usecase = ref.read(getPackageDropdown);
    return await usecase.execute(page, limit, search: search);
  }

  void onSearch(int page, int limit, {String? search}) {
    _debounceTimer?.cancel();
    
    _debounceTimer = Timer(const Duration(seconds: 2), () async {
      state = const AsyncLoading();
      final response = await AsyncValue.guard(() async {
        final usecase = ref.read(getPackageDropdown);
        return await usecase.execute(page, limit, search: search);
      });
      state = response;
    });
  }
  
  Future<void> refresh(int page, int limit, {String? search}) async {
    state = const AsyncLoading();
    final response = await AsyncValue.guard(() async {
      final usecase = ref.read(getPackageDropdown);
      return await usecase.execute(page, limit, search: search);
    });
    state = response;
  }
}
