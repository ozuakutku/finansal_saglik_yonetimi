import 'package:flutter/material.dart';

class ExpenseDropdown extends StatelessWidget {
  final String selectedMonth;
  final ValueChanged<String?> onChanged;
  final List<String> availableMonths; // Yeni parametre

  ExpenseDropdown({
    required this.selectedMonth,
    required this.onChanged,
    required this.availableMonths, // Yeni parametre
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedMonth,
      onChanged: onChanged,
      items: availableMonths.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
