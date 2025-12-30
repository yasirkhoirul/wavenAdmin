import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/data/model/create_package_model.dart';
import 'package:wavenadmin/domain/usecase/create_package.dart';
import 'package:wavenadmin/injection.dart';

part 'create_package_notifier.g.dart';

@riverpod
class CreatePackageNotifier extends _$CreatePackageNotifier {
  @override
  FutureOr<String?> build() {
    return null;
  }

  Future<void> createPackage(CreatePackageRequest request, Uint8List imageFile) async {
    state = const AsyncLoading();
    try {
      final usecase = locator<CreatePackage>();
      final response = await usecase.execute(request, imageFile);
      // Only set state if provider is still mounted
      if (ref.mounted) {
        state = AsyncData(response.message);
      }
    } catch (e, s) {
      Logger().e('Error creating package', error: e, stackTrace: s);
      // Only set state if provider is still mounted
      if (ref.mounted) {
        state = AsyncError(e, s);
      }
    }
  }
}
