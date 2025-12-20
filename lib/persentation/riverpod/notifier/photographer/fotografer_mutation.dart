import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wavenadmin/domain/entity/detailFotografer.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/photographer/fotografer_detail.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/photographer/photographer_list.dart';
import 'package:wavenadmin/persentation/riverpod/provider/usecase_providers.dart';

final fotograferMutationProvider = AsyncNotifierProvider.family
    .autoDispose<FotograferMutation, String?, String>(FotograferMutation.new);

class FotograferMutation extends AsyncNotifier<String?> {
  FotograferMutation(this.idFotografer);

  final String idFotografer;

  @override
  Future<String?> build() async {
    return null;
  }

  void reset() {
    state = const AsyncData(null);
  }

  Future<void> submitUpdate(DetailFotografer payload) async {
    final link = ref.keepAlive();
    try {
      state = const AsyncLoading();
      final result = await AsyncValue.guard(() async {
        final usecase = ref.read(putDetailFotografer);
        return usecase.execute(payload, idFotografer);
      });

      if (result.hasError) {
        // Keep the error in state so UI can listen and show feedback.
        state = AsyncError(result.error!, result.stackTrace!);
        return;
      }

      final message = result.requireValue;
      state = AsyncData(message);

      // Refresh GET after successful update.
      ref.invalidate(fotograferDetailProvider(idFotografer));
      ref.read(photographerListProvider.notifier).loadFirstPage();
    } finally {
      link.close();
    }
  }

  Future<void> deleteFotografer() async {
    final link = ref.keepAlive();
    try {
      state = AsyncLoading();
      final response = await AsyncValue.guard(() {
        final usecase = ref.read(deleteFotograferUseCase);
        return usecase.execute(idFotografer);
      });
      if(response.hasError){
        state = AsyncError(response.error!, response.stackTrace!);
        return;
      }
      final message = response.requireValue;
      state = AsyncData(message);

    } finally{
      link.close();
    }
  }
}
