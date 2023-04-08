import 'package:flutter/material.dart';
import 'package:pay_count/models/accounts.dart';

class AccountsTileWidget extends StatefulWidget {
  const AccountsTileWidget({
    super.key,
    required this.account,
  });

  final Account account;

  @override
  State<AccountsTileWidget> createState() => _AccountsTileWidgetState();
}

class _AccountsTileWidgetState extends State<AccountsTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: ListTile(
        title: Text(widget.account.title),
        subtitle: Text(widget.account.dueDate),
        trailing: const SizedBox(
          width: 100,
          child: _CheckPaymantWidget(),
        ),
      ),
    );
  }
}

class _CheckPaymantWidget extends StatefulWidget {
  const _CheckPaymantWidget({
    this.isChecked = false,
    super.key,
  });

  final bool? isChecked;

  @override
  State<_CheckPaymantWidget> createState() => __CheckPaymantWidgetState();
}

class __CheckPaymantWidgetState extends State<_CheckPaymantWidget> {
  @override
  Widget build(BuildContext context) {
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
          // Checkbox(value: widget.isChecked, onChanged: (bool? value) {}),
          IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.update))
        ],
      ),
    );
  }
}
