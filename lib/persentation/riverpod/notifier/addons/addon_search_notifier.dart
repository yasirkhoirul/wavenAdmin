import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'addon_search_notifier.g.dart';

@riverpod
class AddonSearch extends _$AddonSearch {
  @override
  String build() {
    return '';
  }
  
  void update(String value) {
    state = value;
  }
}
