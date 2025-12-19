import 'package:flutter_riverpod/legacy.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/user/user_list_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/state/user_list_state.dart';
import 'package:wavenadmin/injection.dart';

final userGetListProvider =
    StateNotifierProvider<UserListNotifier, UserListState>(
      (ref) => locator<UserListNotifier>(),
    );
