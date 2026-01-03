import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/data/model/addon_detail_model.dart';
import 'package:wavenadmin/domain/usecase/create_addon.dart';
import 'package:wavenadmin/injection.dart';

part 'create_addon_notifier.g.dart';

@riverpod
class CreateAddonNotifier extends _$CreateAddonNotifier {
  @override
  AsyncValue<String?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> createAddon(String title, int price) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final usecase = locator<CreateAddon>();
      final request = CreateAddonRequest(
        title: title,
        price: price,
      );
      return await usecase.execute(request);
    });
  }
}
