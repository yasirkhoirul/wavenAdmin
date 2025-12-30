import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/domain/entity/addons_dropdown.dart';
import 'package:wavenadmin/domain/usecase/get_addons_dropdown.dart';
import 'package:wavenadmin/injection.dart';

part 'get_dropdown_addons_notifier.g.dart';

@riverpod
class GetDropdownAddonsNotifier extends _$GetDropdownAddonsNotifier {

  @override
  Future<List<AddonDropdownItem>> build() async {
    return [];
  }

  Future<void> fetch(int page, int limit, {String? search}) async {
    state = const AsyncValue.loading();
    try {
      final usecase = locator<GetAddonsDropdown>();
      final result = await usecase.execute(page, limit, search: search);
      state = AsyncValue.data(result.addons);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}

Future<List<AddonDropdownItem>> getAddonsDropdownList(
  int page,
  int limit, {
  String? search,
}) async {
  try {
    final usecase = locator<GetAddonsDropdown>();
  final result = await usecase.execute(page, limit, search: search);
  return result.addons;
  } catch (e) {
    return [];
  }
}