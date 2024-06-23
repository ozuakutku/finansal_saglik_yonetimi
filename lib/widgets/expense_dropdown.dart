import 'package:flutter/material.dart';

class ExpenseDropdown extends StatelessWidget {
  final String selectedMonth;
  final ValueChanged<String?> onChanged;

  ExpenseDropdown({required this.selectedMonth, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButton<String>(
        value: selectedMonth,
        items: [
          DropdownMenuItem(value: '06', child: Text('Haziran')),
          DropdownMenuItem(value: '07', child: Text('Temmuz')),
        ],
        onChanged: onChanged,
      ),
    );
  }
}
