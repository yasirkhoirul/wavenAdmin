import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/domain/usecase/delete_addon.dart';
import 'package:wavenadmin/injection.dart';

part 'delete_addon_notifier.g.dart';

@riverpod
class DeleteAddonNotifier extends _$DeleteAddonNotifier {
  @override
  AsyncValue<String?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> deleteAddon(String addonId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final usecase = locator<DeleteAddon>();
      return await usecase.execute(addonId);
    });
  }
}
