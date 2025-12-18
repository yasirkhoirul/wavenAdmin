import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitListenable extends ChangeNotifier {
  late final StreamSubscription _subscription;

  CubitListenable(BlocBase cubit) {
    _subscription = cubit.stream.listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}