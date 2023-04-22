import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:pay_count/models/accounts.dart';
import 'package:pay_count/repositories/accounts_repository.dart';
import 'package:pay_count/service/utils_service.dart';

class AlertDialogForm extends StatefulWidget {
  const AlertDialogForm({
    super.key,
    required this.titleController,
    required this.dueDateController,
    required this.accountsRepository,
    required this.valueAccount,
    this.isUpdate = false,
    this.idCount,
    this.status,
  });

  final TextEditingController titleController;
  final TextEditingController dueDateController;
  final TextEditingController valueAccount;
  final AccountsRepository accountsRepository;
  final bool? isUpdate;
  final int? idCount;
  final bool? status;

  @override
  State<AlertDialogForm> createState() => _AlertDialogFormState();
}

class _AlertDialogFormState extends State<AlertDialogForm> {
  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
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
        height: 270,
        width: 250,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: TextFormField(
                controller: widget.titleController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.list,
                    color: Colors.grey.shade500,
                  ),
                  hintText: 'Título da conta',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.date_range,
                    color: Colors.grey.shade500,
                  ),
                  hintText: 'Valor da conta',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                controller: widget.valueAccount,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                ],
                validator: (value) {
                  if (value!.isEmpty) return 'Informe o valor do saldo';
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: widget.dueDateController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.date_range,
                    color: Colors.grey.shade500,
                  ),
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

                  widget.dueDateController.text =
                      utilsServices.formatDateTime(date!);
                },
              ),
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
            if (widget.titleController.text == '' ||
                widget.dueDateController.text == '' ||
                widget.valueAccount.text == '') {
              Fluttertoast.showToast(
                  msg: "Preencha um dos campos",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black38,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              Navigator.of(context).pop(true);

              final data = Account(
                title: widget.titleController.text,
                dueDate: widget.dueDateController.text,
                status: false,
                valueAccount: double.parse(widget.valueAccount.text),
              );

              widget.isUpdate == true
                  ? widget.accountsRepository.updateValues(
                      widget.idCount,
                      widget.titleController.text,
                      widget.dueDateController.text,
                      double.parse(widget.valueAccount.text),
                      widget.status,
                    )
                  : widget.accountsRepository.createData(data);
            }
          },
          child: const Text('Sim'),
        )
      ],
    );
  }
}
