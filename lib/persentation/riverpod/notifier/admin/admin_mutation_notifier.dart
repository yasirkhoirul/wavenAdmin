import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wavenadmin/domain/entity/detail_admin.dart';
import 'package:wavenadmin/persentation/riverpod/provider/usecase_providers.dart';

final adminMutationProvider =
    AsyncNotifierProvider.family.autoDispose<AdminMutation, void, String>(
  AdminMutation.new,
);

class AdminMutation extends AsyncNotifier<void> {
  AdminMutation(this.data);

  final String data;

  @override
  Future<void> build() async {
  }

  Future<void> createAdmin(DetailAdmin payload) async {
    final link = ref.keepAlive();
    try {
      state = const AsyncLoading();
      final result = await AsyncValue.guard(() async {
        final usecase = ref.read(createAdminUseCaseProvider);
        return usecase.execute(payload);
      });
      if (result.hasError) {
        state = const AsyncData(null);
        Error.throwWithStackTrace(result.error!, result.stackTrace!);
      }
      state = const AsyncData(null);
    } finally {
      link.close();
    }

  }

  Future<void> deleteAdmin(String idAdmin)async{
    final link = ref.keepAlive();
    try {
      state = const AsyncLoading();
      final result = await AsyncValue.guard(() async {
        final usecase = ref.read(deleteAdminUseCaseProvider);
        await usecase.execute(idAdmin);
      });

      if (result.hasError) {
        state = const AsyncData(null);
        Error.throwWithStackTrace(result.error!, result.stackTrace!);
      }
      state = const AsyncData(null);
    } finally {
      link.close();
    }
  }
}
