// provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'jobtype_provider.g.dart';

@riverpod
class FormJobNameNotifier extends _$FormJobNameNotifier {
  @override
  String build () {
    return "";
  }
}

@riverpod
class FormLabelNameNotifier extends _$FormLabelNameNotifier {
  @override
  String build () {
    return "";
  }
}

@riverpod
class FormJobGenreNameNotifier extends _$FormJobGenreNameNotifier {
  @override
  String build () {
    return "";
  }
}

@riverpod
class FormJobPopupModalModeNotifier extends _$FormJobPopupModalModeNotifier {
  @override
  String build () {
    return "add";
  }
}

@riverpod
class FormJobDocIdNotifier extends _$FormJobDocIdNotifier {
  @override
  String build () {
    return "";
  }
}
