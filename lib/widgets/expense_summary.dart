import 'package:flutter/material.dart';

class ExpenseSummary extends StatelessWidget {
  final double totalExpenses;
  final Map<String, double> categoryTotals;
  final Map<String, Color> categoryColors;

  ExpenseSummary({required this.totalExpenses, required this.categoryTotals, required this.categoryColors});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Toplam Harcama: ₺${totalExpenses.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              for (var entry in categoryTotals.entries)
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      color: categoryColors[entry.key],
                    ),
                    SizedBox(width: 8),
                    Text('${entry.key}: ₺${entry.value.toStringAsFixed(2)}'),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
