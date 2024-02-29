import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selectedjob_provider.g.dart';

@riverpod
class SelectedJobNotifier extends _$SelectedJobNotifier {

  @override
  List<String> build() {
    return [];
  }

  void addJob(String job) {
    state = [...state, job];
  }

  void removeJob(String job) {
    state = [
      for (final el in state)
        if (el != job) el,
    ];
  }
}
