import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddExpensePage extends StatefulWidget {
  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final TextEditingController storeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  Future<void> addExpense(String store, double amount) async {
    await FirebaseFirestore.instance.collection('expenses').add({
      'store': store,
      'amount': amount,
      'category': 'Diğer', // Kategori varsayılan olarak Diğer
      'date': DateTime.now().toIso8601String(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fatura Oluştur'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: storeController,
              decoration: InputDecoration(labelText: 'Mağaza'),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Tutar (TL)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final String store = storeController.text;
                final double amount = double.tryParse(amountController.text) ?? 0.0;
                if (store.isNotEmpty && amount > 0) {
                  addExpense(store, amount);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Fatura başarıyla eklendi')),
                  );
                }
              },
              child: Text('Fatura Ekle'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]),
            ),
          ],
        ),
      ),
    );
  }
}
