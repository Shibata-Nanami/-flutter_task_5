/// メモ一覧画面用のWidget
import 'package:flutter/material.dart';
import 'package:flutter_task_3/screen3.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'memo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required String titleName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'メモ一覧',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              context.goNamed(Screen3.routeName);
            },
            child: const Icon(Icons.cruelty_free),
          ),
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: context.watch<Memo>().list.length,
              itemBuilder: (context, index) {
                //以下の記載でModelクラスの単体のデータ取得が可能
                final modelData = context.watch<Memo>().list[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30), // 左側に空白を追加
                          child: Text(modelData.title),
                        ),
                        const Spacer(), //2つのウィジェットの間隔を押し広げる
                        Padding(
                          padding: const EdgeInsets.only(right: 20), //右側に空白を追加
                          child: InkWell(
                            child: IconButton(
                              icon: const Icon(Icons.delete),
                              iconSize: 35, // アイコンのサイズを指定
                              onPressed: () {
                                // 削除ボタンがタップされた時の処理
                                context
                                    .read<Memo>()
                                    .removeItem(context, modelData.id);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          onPressed: () {
            // "push"で新規画面に遷移
            context.go('/todo');
          },
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
