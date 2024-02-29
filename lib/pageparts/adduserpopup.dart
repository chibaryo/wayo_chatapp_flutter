import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import 'package:wayo_chatapp/providers/firestore/job/job_provider.dart';

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

class AddUserPopup extends HookConsumerWidget {
  const AddUserPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _haveChildSelect = useState(_haveChildren.noChild);
    final _isOnline = useState<bool>(true);
    final List<String> _isOnlineChoicesStr = ["Online", "Offline"];

    final _formKey = useMemoized(() => GlobalKey<FormState>()); //GlobalKey<FormState>();

    final _name = ref.watch(formNameNotifierProvider);
    final _email = ref.watch(formEmailAddrNotifierProvider);
    final _password = ref.watch(formPasswordNotifierProvider);
    final _job = ref.watch(formJobNotifierProvider);
    final _imagepath = ref.watch(formImagepathNotifierProvider);
    final _datetime = ref.watch(formlastActiveDateNotifierProvider);

    final _nameController = useTextEditingController(text: _name);
    final _emailController = useTextEditingController(text: _email);
    final _passwordController = useTextEditingController(text: _password);
    final _imagepathController = useTextEditingController(text: _imagepath);

    final _jobLists = ref.watch(jobStreamProvider);


    return AlertDialog(
      title: const Text("ユーザ登録"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: FractionallySizedBox(
                        widthFactor: 1,
                        child: ChoiceChip(
                          label: const Text("オンライン"),
                          selected: _isOnline.value == true,
                          backgroundColor: Colors.grey[600],
                          selectedColor: Colors.white,
                          onSelected: (bool selected) {
                            selected ? _isOnline.value = true : null;
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: FractionallySizedBox(
                        widthFactor: 1,
                        child: ChoiceChip(
                          label: const Text("オフライン"),
                          selected: _isOnline.value == false,
                          backgroundColor: Colors.grey[600],
                          selectedColor: Colors.white,
                          onSelected: (bool selected) {
                            selected ? _isOnline.value = false : null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  autofocus: true,
                  controller: _nameController,
                  decoration: const InputDecoration(hintText: "名前"),
                  onChanged: (text) {
                    ref.watch(formNameNotifierProvider.notifier).state = text;
                  },
                ),
                TextFormField(
                  autofocus: true,
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: "メールアドレス"),
                  onChanged: (text) {
                    ref.watch(formEmailAddrNotifierProvider.notifier).state = text;
                  },
                ),
                TextFormField(
                  autofocus: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(hintText: "パスワード"),
                  onChanged: (text) {
                    ref.watch(formPasswordNotifierProvider.notifier).state = text;
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: _jobLists.when(
                    data: (jobs) {
                      if (jobs != null) {
                        return DropdownButtonFormField<String>(
//                          isExpanded: true,
                          isDense: true,
                          menuMaxHeight: 256,
//                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          decoration: const InputDecoration(
                            labelText: "職業を選択",
                            border: OutlineInputBorder(),
                          ),
                          items: jobs.map<DropdownMenuItem<String>>((e) {
                            return DropdownMenuItem(
                              value: e.job,
                              child: Text(e.label),
                            );
                            }
                          ).toList(),
                          onChanged: (String? value) {
                            ref.read(formJobNotifierProvider.notifier).state = value!;
                          },
                        );
                      }
                    },
                    loading: () => Center(child: CircularProgressIndicator()),
                    error: (error, stackTrace) =>
                      Center(child: Text('Error: $error')),
                  )
                ),
                // haveChildren?
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: DropdownButtonFormField<_haveChildren>(
                    isDense: true,
                    decoration: const InputDecoration(hintText: "子どもの有無"),
                    onChanged: (newValue) {
                      _haveChildSelect.value = newValue!;
                      print(_haveChildSelect.value);
                    },
                    items: _haveChildren.values.map((e) {
                      return DropdownMenuItem<_haveChildren>(
                        value: e,
                        child: Text(e.title),
                      );
                    }).toList(),
                  )
                ),
                TextFormField(
                  autofocus: true,
                  controller: _imagepathController,
                  decoration: const InputDecoration(hintText: "画像パス"),
                  onChanged: (text) {
                    ref.watch(formImagepathNotifierProvider.notifier).state = text;
                  },
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            DatePicker.showDateTimePicker(
                              context,
                              // 選択できる日時の範囲
                              minTime: DateTime(2023, 6, 1),
                              maxTime: DateTime(2024, 2, 29),
                        
                              // ドラムロールを変化させたときの処理
                              onChanged: (dateTime) {
                                print('OnChanged: ${dateTime}');
                              },
                              // 「完了」を押したときの処理
                              onConfirm: (dateTime) {
                                print('OnConfirm: ${dateTime}');
                                var formatter = new DateFormat("yyyy/MM/dd hh:mm:ss");
                                var formatted = formatter.format(dateTime);
                                ref.read(formlastActiveDateNotifierProvider.notifier).state = formatted;
                              },
                              // 「キャンセル」を押したときの処理
                              onCancel: () {
                                print('cancel');
                              },
                        
                              //言語
                              locale: LocaleType.jp, 
                            );
                          },
                          child: const Text("最終ログイン日時"),
                        ),
                        Flexible(
                          flex: 1,
                          child: _datetime != ""
                            ? Text(_datetime.toString())
                            : const Text("日付を選択...")
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: ElevatedButton(
              child: const Text("登録"),
              onPressed: () async {
                final serverDate = DateTime.now();
                ref.read(asyncFirebaseUserNotifierProvider.notifier).addFirebaseUser(
                  name: _name,
                  email: _email,
                  password: _password,
                  job: _job,
                  haveChildren: _haveChildSelect.value.title,
                  imagepath: _imagepath,
                  lastActive: ref.watch(formlastActiveDateNotifierProvider),
                  isOnline: _isOnline.value,
                );

                context.pop();
              },
            ),
          )
        ],
      )
    );
  }
}