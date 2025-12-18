import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/domain/usecase/get_detail_admin.dart';
import 'package:wavenadmin/injection.dart';
import 'package:wavenadmin/domain/entity/detailAdmin.dart';



part 'admin_detail_notifier.g.dart';

final getDetailAdminUsecaseProvider = Provider<GetDetailAdmin>((ref) {
  return locator<GetDetailAdmin>();
});

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
}