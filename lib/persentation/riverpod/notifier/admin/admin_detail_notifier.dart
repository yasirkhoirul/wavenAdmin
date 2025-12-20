import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/domain/entity/detail_admin.dart';
import 'package:wavenadmin/persentation/riverpod/provider/usecase_providers.dart';



part 'admin_detail_notifier.g.dart';

@riverpod
class AdminDetail extends _$AdminDetail {
  @override
  FutureOr<DetailAdmin> build(String adminId) async {
    final usecase = ref.read(getDetailAdminUsecaseProvider);
    return usecase.execute(adminId);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final usecase = ref.read(getDetailAdminUsecaseProvider);
      return usecase.execute(adminId);
    });
  }

  Future<String> onUpdate(DetailAdmin payload) async {
    final prevState = state;
    state = const AsyncLoading();
    final updateResult = await AsyncValue.guard(() async {
      final usecase = ref.read(putDetailAdminUsecaseProvider);
      return usecase.execute(payload, adminId);
    });

    if (updateResult is AsyncError<String>) {
      state = prevState;
      Error.throwWithStackTrace(updateResult.error, updateResult.stackTrace);
    }
    final message = updateResult.requireValue;
    await refresh();
    return message;
  }
}