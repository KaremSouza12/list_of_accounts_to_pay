import 'package:flutter/material.dart';
import 'package:pay_count/models/accounts.dart';
import 'package:pay_count/repositories/accounts_repository.dart';
import 'package:pay_count/service/utils_service.dart';
import 'package:pay_count/widgets/alert_dialog_fome.dart';
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
                  ? account.updateItem(widget.account.id, 1)
                  : account.updateItem(widget.account.id, 0);
            });
          },
        ),
        title: Text(widget.account.title),
        subtitle: Text(widget.account.dueDate),
        trailing: SizedBox(
          width: 100,
          child: _CheckPaymantWidget(
            id: widget.account.id,
          ),
        ),
      ),
    );
  }
}

class _CheckPaymantWidget extends StatefulWidget {
  const _CheckPaymantWidget({
    required this.id,
  });

  final int? id;
  @override
  State<_CheckPaymantWidget> createState() => __CheckPaymantWidgetState();
}

class __CheckPaymantWidgetState extends State<_CheckPaymantWidget> {
  late final id = widget.id;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final UtilsServices utilsServices = UtilsServices();

  Future<void> _showForm(
      BuildContext context, AccountsRepository accountsRepository) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialogForm(
          titleController: titleController,
          dueDateController: dueDateController,
          accountsRepository: accountsRepository,
          isUpdate: true,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final accountListen = context.watch<AccountsRepository>();
    return Container(
      width: 60,
      alignment: Alignment.bottomRight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade300),
        ],
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
              onPressed: () {
                accountListen.getItem(id);
                _showForm(context, accountListen);
              },
              icon: const Icon(Icons.update))
        ],
      ),
    );
  }
}
