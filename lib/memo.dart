import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'Model.dart';

class Memo extends ChangeNotifier {
  List<Model> _list = [];
  List<Model> get list => _list;
  //ログインしていなかったらisLoginはfalse
  bool isLoading = false;

  ///非同期一覧取得
  Future<List<Model>> fetchMemo() async {
    // isLoading = true;
    // notifyListeners();
    //2秒遅延させる
    await Future.delayed(const Duration(seconds: 2));
    final memoList = [
      Model(id: '1', title: 'title1'),
      Model(id: '2', title: 'title2'),
      Model(id: '3', title: 'title3'),
    ];
    _list = memoList;
    // isLoading = false;
    notifyListeners();
    return list;
  }

  // 配列にデータを追加するaddItemというメソッド
  // 引数にはStringのtitleを受け取る
  void addItem(BuildContext context, String title) {
    // print('メモタイトル追加');
    // _list.add(Model(id: '${_list.length + 1}', title: title));
    // notifyListeners();
    // context.pop();
    // int randomNumber = RandomNumber();
    final String randomId = const Uuid().v4();
    if (title.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('memo')
          .add({'id': randomId, 'title': title});
    }
  }

  // int RandomNumber() {
  //   Random random = Random();
  //   // 1000以上9999以下のランダムな整数を生成
  //   int randomNumber = random.nextInt(9000) + 1000;
  //   return randomNumber;
  // }

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
