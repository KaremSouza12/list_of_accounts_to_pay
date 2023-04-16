import 'package:flutter/material.dart';
import 'package:pay_count/models/accounts.dart';
import 'package:pay_count/repositories/accounts_repository.dart';
import 'package:pay_count/service/utils_service.dart';
import 'package:pay_count/widgets/accounts_tile_widget.dart';
import 'package:pay_count/widgets/alert_dialog_fome.dart';
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
  final UtilsServices utilsServices = UtilsServices();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  Future<void> _showForm(
      BuildContext context, AccountsRepository accountsRepository) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialogForm(
          titleController: titleController,
          dueDateController: dueDateController,
          accountsRepository: accountsRepository,
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
                return AccountsTileWidget(
                  account: c,
                  accountsRepository: accounts,
                );
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
