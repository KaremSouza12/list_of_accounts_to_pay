import 'package:flutter/material.dart';
import 'package:pay_count/models/accounts.dart';
import 'package:pay_count/repositories/accounts_repository.dart';
import 'package:pay_count/widgets/accounts_tile_widget.dart';
import 'package:provider/provider.dart';

class ListAccounts extends StatefulWidget {
  const ListAccounts({super.key, required this.title});

  final String title;

  @override
  State<ListAccounts> createState() => _ListAccountsState();
}

class _ListAccountsState extends State<ListAccounts> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final List<Account> account = [];

  Future<void> getAccounts() async {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();

    getAccounts();
  }

  Future<void> _showForm(
      BuildContext context, AccountsRepository accountsRepository) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Deseja cadastrar outra conta'),
          content: Column(
            children: [
              TextField(
                controller: titleController,
              ),
              TextField(
                controller: dueDateController,
              ),
            ],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Nao'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed: () {
                Navigator.of(context).pop(true);

                final data = Account(
                  title: titleController.text,
                  dueDate: dueDateController.text,
                );

                accountsRepository.createData(data);
              },
              child: const Text('Sim'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final accounts = context.watch<AccountsRepository>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: accounts.accounts.length,
              itemBuilder: (_, index) {
                final c = accounts.accounts[index];
                return AccountsTileWidget(account: c);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(context, accounts),
        tooltip: 'add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
