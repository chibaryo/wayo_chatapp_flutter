import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'cond_selections_provider.g.dart';

@riverpod
class CondSelectionIsMarriedNotifier extends _$CondSelectionIsMarriedNotifier {
  @override
  List<String> build () {
    return [];
  }

  void addSelection(String el) {
    state = [...state, el];
  }

  void removeSelection(String el) {
    state = [
      for (final e in state)
        if (e != el) e,
    ];
  }

}
