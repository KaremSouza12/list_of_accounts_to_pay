import 'package:flutter/material.dart';
import 'package:pay_count/pages/list_accounts.dart';
import 'package:pay_count/repositories/accounts_repository.dart';

import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AccountsRepository()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: Colors.black,
          seedColor: const Color.fromARGB(255, 10, 10, 10),
        ),
        useMaterial3: true,
      ),
      home: const ListAccounts(
        title: 'Lista de Contas a pagar',
      ),
    );
  }
}
