import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import 'package:wayo_chatapp/providers/firestore/job/job_provider.dart';
import 'package:wayo_chatapp/providers/form/jobtype_provider.dart';

import '../../providers/form/formparts_provider.dart';
import '../providers/firestore/user/user_provider.dart';

enum _haveChildren {
  noChild(title: "いない"),
  livingWith(title: "あり（同居）"),
  livingApart(title: "あり（別居）"),
  secret(title: "ナイショ");

  final String title;

  const _haveChildren({required this.title});
}

class AddJobPopup extends HookConsumerWidget {
  const AddJobPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _haveChildSelect = useState(_haveChildren.noChild);
    final _isOnline = useState<bool>(true);
    final List<String> _isOnlineChoicesStr = ["Online", "Offline"];

    final _formKey = useMemoized(() => GlobalKey<FormState>()); //GlobalKey<FormState>();

    final _job = ref.watch(formJobNameNotifierProvider);
    final _label = ref.watch(formLabelNameNotifierProvider);
    final _jobGenre = ref.watch(formJobGenreNameNotifierProvider);
    final _id = ref.watch(formJobDocIdNotifierProvider);
    final _popupMode = ref.watch(formJobPopupModalModeNotifierProvider);

    final _jobController = useTextEditingController(text: _job);
    final _labelController = useTextEditingController(text: _label);
    final _jobGenreController = useTextEditingController(text: _jobGenre);

    final _jobLists = ref.watch(jobStreamProvider);

    useEffect(() {
    }, const []);

    return AlertDialog(
      title: _popupMode == "add" ? const Text("ジョブ登録") : const Text("ジョブ編集"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  autofocus: true,
                  controller: _labelController,
                  decoration: const InputDecoration(hintText: "ジョブラベル（日本語）"),
                  onChanged: (text) {
                    ref.watch(formLabelNameNotifierProvider.notifier).state = text;
                  },
                ),
                TextFormField(
                  autofocus: true,
                  controller: _jobController,
                  decoration: const InputDecoration(hintText: "ジョブタグ（英語）"),
                  onChanged: (text) {
                    ref.watch(formJobNameNotifierProvider.notifier).state = text;
                  },
                ),
                TextFormField(
                  autofocus: true,
                  controller: _jobGenreController,
                  decoration: const InputDecoration(hintText: "ジャンル（英語）"),
                  onChanged: (text) {
                    ref.watch(formJobGenreNameNotifierProvider.notifier).state = text;
                  },
                ),
              ],
            ),
          ),
          Container(
            child: ElevatedButton(
              child: const Text("登録"),
              onPressed: () async {
                final serverDate = DateTime.now();
                if (ref.watch(formJobPopupModalModeNotifierProvider) == "add") {
                  ref.read(asyncFirebaseJobNotifierProvider.notifier).addFirebaseJob(
                    job: _job,
                    label: _label,
                    jobGenre: _jobGenre,
                  );
                } else if (ref.watch(formJobPopupModalModeNotifierProvider) == "edit") { // Edit
                  print("Edit mode!");
                  ref.read(asyncFirebaseJobNotifierProvider.notifier).updateFirebaseJob(
                    id: _id,
                    job: _job,
                    label: _label,
                    jobGenre: _jobGenre,
                  );
                }

                context.pop();
              },
            ),
          ),
        ],
      )
    );
  }
}