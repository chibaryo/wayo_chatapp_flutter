// provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'isloading_provider.g.dart';

@riverpod
class isLoadingNotifier extends _$isLoadingNotifier {
  @override
  bool build () {
    return false;
  }
}
