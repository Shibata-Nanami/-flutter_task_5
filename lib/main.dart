import 'package:flutter/material.dart';
import 'package:flutter_task_3/counter.dart';
import 'package:flutter_task_3/router.dart';
import 'package:provider/provider.dart';
import 'memo.dart';

void main() {
  /// 最初に表示するWidget
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider(create: (_) => Memo()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: goRouter.routeInformationParser,
      routerDelegate: goRouter.routerDelegate,
      routeInformationProvider: goRouter.routeInformationProvider,
    );
  }
}
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'My Todo App',

      /// リスト一覧画面を表示
//       home: HomeScreenState(),
//     );
//   }
// }
