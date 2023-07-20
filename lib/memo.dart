import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'Model.dart';

class Memo extends ChangeNotifier {
  final List<Model> _list = [
    Model(id: '1', title: 'title1'),
    Model(id: '2', title: 'title2'),
    Model(id: '3', title: 'title3'),
  ];

  List<Model> get list => _list;

  // 配列にデータを追加するaddItemというメソッド
  // 引数にはStringのtitleを受け取る
  void addItem(BuildContext context, String title) {
    print('メモタイトル追加');
    _list.add(Model(id: '${_list.length + 1}', title: title));
    notifyListeners();
    context.pop();
  }

  void _handleOkButtonTap(BuildContext context, String targetId) {
    print('メモタイトル削除');
    //削除ボタンではいが押されたときの処理
    _list.removeWhere((item) => item.id == targetId);
    notifyListeners();
    context.pop();
  }

  // 配列にデータを削除するremoveItemというメソッド
  void removeItem(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: const Text('本当に削除しますか？'),
          actions: [
            TextButton(
              onPressed: () {
                context.pop(); //ダイアログを閉じる
              },
              child: const Text('いいえ'),
            ),
            TextButton(
              onPressed: () {
                _handleOkButtonTap(context, id); // OKボタンの処理を実行
                //ダイアログを閉じる
              },
              child: const Text('はい'),
            ),
          ],
        );
      },
    );
  }
}

      // _list.removeWhere((item) => item.id == 'id');
      // notifyListeners();