import 'package:flutter/material.dart';
import 'package:flutter_despesas/models/transaction.dart';
import 'package:flutter_despesas/widgets/chart_bar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.recentTransactions});

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );

        double totalSum = 0.0;
        for (var i = 0; i < recentTransactions.length; i++) {
          bool sameDay = recentTransactions[i].date.day == weekDay.day;
          bool sameMonth = recentTransactions[i].date.month == weekDay.month;
          bool sameYear = recentTransactions[i].date.year == weekDay.year;

          if (sameDay && sameMonth && sameYear) {
            totalSum += recentTransactions[i].value;
          }
        }

        return {
          'day': DateFormat.E().format(weekDay)[0],
          'value': totalSum.toStringAsFixed(2),
        };
      },
    ).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, element) {
      return sum + double.parse(element['value'].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: e['day'].toString(),
                value: double.parse(e['value'].toString()),
                percentage:
                    (double.parse(e['value'].toString()) / _weekTotalValue)
                            .isNaN
                        ? 0.0
                        : double.parse(e['value'].toString()) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
