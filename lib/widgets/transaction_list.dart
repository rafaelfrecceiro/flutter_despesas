import 'package:flutter/material.dart';
import 'package:flutter_despesas/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final void Function(double) onRemoved;
  final List<Transaction> transactions;

  const TransactionList({
    super.key,
    required this.transactions,
    required this.onRemoved,
  });

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Center(
            child: Image.asset('assets/images/list_empty.jpg'),
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final tr = transactions[index];

              return Card(
                elevation: 5,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(child: Text('R\$${tr.value}')),
                    ),
                  ),
                  title: Text(tr.title),
                  subtitle: Text(DateFormat('d MMM y').format(tr.date)),
                  trailing: IconButton(
                    onPressed: () => onRemoved(double.parse(tr.id)),
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                  ),
                ),
              );
            },
          );
  }
}
