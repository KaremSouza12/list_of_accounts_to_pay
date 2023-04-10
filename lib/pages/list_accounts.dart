import 'package:flutter/material.dart';
import 'package:pay_count/models/accounts.dart';
import 'package:pay_count/repositories/accounts_repository.dart';
import 'package:pay_count/service/utils_service.dart';
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
        return AlertDialog(
          contentPadding: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Cadastrar conta',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: SizedBox(
            height: 160,
            width: 160,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.list),
                      hintText: 'Título da conta',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  controller: dueDateController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.date_range),
                    hintText: 'Data de vencimento',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onTap: () async {
                    DateTime? date = DateTime(1900);
                    FocusScope.of(context).requestFocus(FocusNode());
                    date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100));

                    dueDateController.text =
                        utilsServices.formatDateTime(date!);
                    print(dueDateController);
                  },
                )
              ],
            ),
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
                  status: false,
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
                print('DATA:$c');
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
