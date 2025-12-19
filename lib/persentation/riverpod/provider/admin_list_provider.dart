import 'package:flutter_riverpod/legacy.dart';
import 'package:wavenadmin/injection.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/admin/admin_list_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/state/admin_list_state.dart';

final userAdminGetListProvider =
    StateNotifierProvider<AdminListNotifier, AdminListState>(
      (ref) => locator<AdminListNotifier>(),
    );
