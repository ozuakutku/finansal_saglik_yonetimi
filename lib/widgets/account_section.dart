import 'package:flutter/material.dart';

class AccountSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fibabanka Mobil\'e özel avantajlı faiz oranları ile yüksek getiri fırsatlarını kaçırmayın.',
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
        SizedBox(height: 10),
        Center(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[800],
            ),
            child: Text('Hesap Aç', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
