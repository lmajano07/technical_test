import 'package:flutter/material.dart';

import 'package:transactions_app/core/core.dart';

import 'package:transactions_app/features/transactions/presentation/presentation.dart';

import 'package:transactions_app/features/shared/shared.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text(snapshot.error.toString()),
              ),
            );
          }

          return const HomePage();
        },
      ),
    );
  }
}
