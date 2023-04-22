import 'package:flutter/material.dart';
import 'package:pay_count/models/accounts.dart';
import 'package:pay_count/repositories/accounts_repository.dart';
import 'package:pay_count/service/utils_service.dart';
import 'package:pay_count/widgets/alert_dialog_form.dart';
import 'package:provider/provider.dart';

class AccountsTileWidget extends StatefulWidget {
  const AccountsTileWidget({
    super.key,
    required this.account,
    required this.accountsRepository,
  });

  final Account account;
  final AccountsRepository accountsRepository;

  @override
  State<AccountsTileWidget> createState() => _AccountsTileWidgetState();
}

class _AccountsTileWidgetState extends State<AccountsTileWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final account = context.watch<AccountsRepository>();
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: ListTile(
        leading: Checkbox(
          activeColor: Colors.green,
          value:
              widget.account.status == true ? widget.account.status : isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
              isChecked == true
                  ? account.updateStatus(widget.account.id, 1)
                  : account.updateStatus(widget.account.id, 0);
            });
          },
        ),
        title: Text(widget.account.title as String),
        subtitle: Text(widget.account.dueDate as String),
        trailing: SizedBox(
          width: 100,
          child: ActionButtomWidget(
            id: widget.account.id,
          ),
        ),
      ),
    );
  }
}

class ActionButtomWidget extends StatefulWidget {
  const ActionButtomWidget({
    super.key,
    required this.id,
  });

  final int? id;
  @override
  State<ActionButtomWidget> createState() => _ActionButtomWidgetState();
}

class _ActionButtomWidgetState extends State<ActionButtomWidget> {
  late final id = widget.id;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController valueAccount = TextEditingController();
  final UtilsServices utilsServices = UtilsServices();

  Future<void> _showForm(
    BuildContext context,
    AccountsRepository accountsRepository,
    bool? status,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialogForm(
          titleController: titleController,
          dueDateController: dueDateController,
          accountsRepository: accountsRepository,
          isUpdate: true,
          valueAccount: valueAccount,
          idCount: id,
          status: status,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final accountListen = context.watch<AccountsRepository>();
    return Container(
      width: 10,
      alignment: Alignment.bottomRight,
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              accountListen.deleteItem(id);
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () async {
              print(widget.id);
              final data = await accountListen.getItem(id);
              titleController.text = data.title;
              dueDateController.text = data.dueDate;
              valueAccount.text = data.valueAccount.toString();
              _showForm(context, accountListen, data.status);
            },
            icon: const Icon(Icons.update),
          )
        ],
      ),
    );
  }
}
