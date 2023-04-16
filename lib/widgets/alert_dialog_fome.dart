import 'package:flutter/material.dart';
import 'package:pay_count/models/accounts.dart';
import 'package:pay_count/repositories/accounts_repository.dart';
import 'package:pay_count/service/utils_service.dart';

class AlertDialogForm extends StatefulWidget {
  const AlertDialogForm({
    super.key,
    required this.titleController,
    required this.dueDateController,
    required this.accountsRepository,
    this.isUpdate = false,
  });

  final TextEditingController titleController;
  final TextEditingController dueDateController;
  final AccountsRepository accountsRepository;
  final bool? isUpdate;

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
        height: 160,
        width: 160,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: TextFormField(
                controller: widget.titleController,
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
              controller: widget.dueDateController,
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

                widget.dueDateController.text =
                    utilsServices.formatDateTime(date!);
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
              title: widget.titleController.text,
              dueDate: widget.dueDateController.text,
              status: false,
            );

            widget.isUpdate == true
                ? 'teste'
                : widget.accountsRepository.createData(data);
          },
          child: const Text('Sim'),
        )
      ],
    );
  }
}
