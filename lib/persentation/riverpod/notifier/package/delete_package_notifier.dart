import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/domain/usecase/delete_package.dart';
import 'package:wavenadmin/injection.dart';

part 'delete_package_notifier.g.dart';

@riverpod
class DeletePackageNotifier extends _$DeletePackageNotifier {
  @override
  FutureOr<String?> build() {
    return null;
  }

  Future<void> deletePackage(String packageId) async {
    state = const AsyncLoading();
    try {
      final usecase = locator<DeletePackage>();
      final response = await usecase.execute(packageId);
      // Only set state if provider is still mounted
      if (ref.mounted) {
        state = AsyncData(response.message);
      }
    } catch (e, s) {
      Logger().e('Error deleting package', error: e, stackTrace: s);
      // Only set state if provider is still mounted
      if (ref.mounted) {
        state = AsyncError(e, s);
      }
      throw Exception(e.toString());
    }
  }
}
