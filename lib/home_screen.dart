import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_3/screen3.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required String titleName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//メモ一覧のデータ呼び出し
  // Future<List<Map<String, dynamic>>> getCollectionData() async {
  //   try {
  //     final snapshot = await FirebaseFirestore.instance
  //         .collection('memo')
  //         .orderBy('id')
  //         .get();
  //     print(snapshot);
  //     return snapshot.docs.map((doc) => doc.data()).toList();
  //     // return [];
  //   } catch (e) {
  //     print(e);
  //     return [];
  //   }
  // }
  Future<List<Map<String, dynamic>>> getCollectionData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('memo')
          .orderBy('id')
          .get();
      print(snapshot);
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': data['id'],
          'title': data['title'],
          'documentId': doc.id,
        };
      }).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

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
        //FutureBuilderを使用する場合は、<void>ではなく、今回の場合は<List<Map<String, dynamic>>>と定義しないといけない
        child: FutureBuilder<List<Map<String, dynamic>>>(
          //Memoデータを取得
          future: getCollectionData(),
          //snapshotは非同期処理の結果を保持しており、その状態に応じて処理を分岐
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              //null（値がない場合がある）でエラーになる場合は「！（非nullである）」を付けるとエラー解消される
              final data = snapshot.data!;
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      print(item);
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
                                padding: const EdgeInsets.only(left: 30),
                                child: Text(item['title']),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: InkWell(
                                  child: IconButton(
                                    icon: const Icon(Icons.delete),
                                    iconSize: 35,
                                    onPressed: () async {
                                      ///メモの削除方法
                                      await FirebaseFirestore.instance
                                          .collection('memo')
                                          .doc(item['documentId'])
                                          .delete();

                                      ///更新及び更新するデータがない場合の登録方法
                                      // await FirebaseFirestore.instance
                                      //     .collection('memo')
                                      //     .doc('0rR1envaueV9CiJPExxx')
                                      //     .set({'id': 'xxx', 'title': 'B'});
                                      /// 削除ボタンがタップされた時の処理
                                      // context.read<Memo>().removeItem(context, modelData.id);
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
              );
              //ローディングインジケーター（CircularProgressIndicator）を表示
            } else {
              print('非同期処理中:');
              // ローディング画面
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
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
