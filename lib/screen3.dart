import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'counter.dart';

class Screen3 extends StatefulWidget {
  const Screen3({super.key});
  static const String routeName = 'screen3';
  static const String routePath = 'screen3';

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text(
        /// Calls `context.watch` to make [Count] rebuild when [Counter] changes.
        //（StatefulWidget内でcontext.watchを呼び出して、Counterの変化に応じてCountが再構築される）
        '${context.watch<Counter>().count}',
        key: const Key('counterState'),
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('increment_floatingActionButton'),

        /// Calls `context.read` instead of `context.watch` so that it does not rebuild
        //（Counterの変更によってCountを再構築しないようにするために、context.watchの代わりにcontext.readを呼び出す）
        /// when [Counter] changes.
        //（カウンターの値が変更されるときに、context.readなのでウィジェットが変更通知を受け取らず再構築されない）
        onPressed: () => context.read<Counter>().increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
