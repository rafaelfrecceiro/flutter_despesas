import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm({super.key, required this.onSubmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleEC = TextEditingController();
  final valueEC = TextEditingController();

  DateTime? _selectedDate;

  @override
  void dispose() {
    super.dispose();
    titleEC.dispose();
    valueEC.dispose();
  }

  void _submitForm() {
    if (titleEC.text.isNotEmpty && double.parse(valueEC.text) > 0) {
      widget.onSubmit(
        titleEC.text,
        double.parse(valueEC.text),
        _selectedDate ?? DateTime.now(),
      );
    }
  }

  void _showDatePicker() async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then(
      (value) {
        if (value == null) {
          return;
        }
        setState(() {
          _selectedDate = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: titleEC,
              decoration: const InputDecoration(labelText: 'Título'),
              onSubmitted: (value) => _submitForm(),
            ),
            TextField(
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              controller: valueEC,
              decoration: const InputDecoration(labelText: 'Valor (R\$)'),
              onSubmitted: (value) => _submitForm(),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Text(DateFormat('d MMM y')
                      .format(_selectedDate ?? DateTime.now())),
                  TextButton(
                    onPressed: () {
                      _showDatePicker();
                    },
                    child: const Text('Selecionar Data'),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _submitForm();
              },
              style: const ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(Colors.blueGrey),
              ),
              child: const Text(
                'Nova Transação',
              ),
            )
          ],
        ),
      ),
    );
  }
}
