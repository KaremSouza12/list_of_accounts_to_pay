import 'package:flutter/material.dart';
import 'package:pay_count/repositories/accounts_repository.dart';
import 'package:pay_count/service/utils_service.dart';
import 'package:pay_count/widgets/accounts_tile_widget.dart';
import 'package:pay_count/widgets/alert_dialog_form.dart';
import 'package:provider/provider.dart';

class ListAccounts extends StatefulWidget {
  const ListAccounts({
    super.key,
  });

  @override
  State<ListAccounts> createState() => _ListAccountsState();
}

class _ListAccountsState extends State<ListAccounts> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController valueAccount = TextEditingController();
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
          valueAccount: valueAccount,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final accounts = context.watch<AccountsRepository>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Contas a Pagar',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
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
