import 'package:flutter/material.dart';

import 'package:transactions_app/core/core.dart';

import 'package:transactions_app/shared/shared.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: TransactionsApp()));
}

class TransactionsApp extends ConsumerStatefulWidget {
  const TransactionsApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransactionsAppState();
}

class _TransactionsAppState extends ConsumerState<TransactionsApp> {
  late Future _setUpFuture;

  Future _setUp() async {
    await dotenv.load(fileName: '.env');
    await Future.delayed(const Duration(seconds: 3));
  }

  @override
  void initState() {
    _setUpFuture = _setUp();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = ref.watch(themeNotifierProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Transactions App',
      theme: appTheme.getTheme(),
      home: FutureBuilder(
        future: _setUpFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const SplashPage();
          }

          return const MyHomePage(title: 'Transactions');
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() => _counter++);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
