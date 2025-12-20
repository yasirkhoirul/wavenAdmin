import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/domain/entity/detail_fotografer.dart';
import 'package:wavenadmin/persentation/riverpod/provider/usecase_providers.dart';

part 'fotografer_detail.g.dart';

@riverpod
class FotograferDetail extends _$FotograferDetail {
  @override
  FutureOr<DetailFotografer> build(String idFotografer) async {
    final usecase = ref.read(getDetailFotografer);
    return usecase.execute(idFotografer);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final usecase = ref.read(getDetailFotografer);
      return usecase.execute(idFotografer);
    });
  }
}

