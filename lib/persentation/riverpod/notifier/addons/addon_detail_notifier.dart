import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/data/model/addon_detail_model.dart';
import 'package:wavenadmin/domain/entity/addon_detail.dart';
import 'package:wavenadmin/domain/usecase/get_addon_detail.dart';
import 'package:wavenadmin/domain/usecase/update_addon.dart';
import 'package:wavenadmin/injection.dart';

part 'addon_detail_notifier.g.dart';

@riverpod
class AddonDetailNotifier extends _$AddonDetailNotifier {
  @override
  Future<AddonDetail> build(String addonId) async {
    final usecase = locator<GetAddonDetail>();
    return await usecase.execute(addonId);
  }

  Future<void> updateAddon(String addonId, String title, int price, bool isActive) async {
    state = const AsyncValue.loading();
    try {
      final updateUsecase = locator<UpdateAddon>();
      final request = UpdateAddonRequest(
        title: title,
        price: price,
        isActive: isActive,
      );
      
      await updateUsecase.execute(addonId, request);
      ref.invalidateSelf();
    } catch (error,s) {
      state = AsyncError(error, s);
    }
  }
}
