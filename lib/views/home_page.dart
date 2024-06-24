import 'package:flutter/material.dart';
import 'package:finanasal_saglik_raporu/views/home_screen.dart';
import 'package:finanasal_saglik_raporu/views/add_expense_page.dart';
import 'package:finanasal_saglik_raporu/services/firestore_service.dart';
import 'package:finanasal_saglik_raporu/models/expense.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finanasal_saglik_raporu/views/carbon_footprint_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> _pages = [HomeScreen(), AddExpensePage(), Placeholder(), Placeholder()];

  List<Expense> expenses = [];
  double totalLastMonth = 0;
  double totalThisMonth = 0;

  @override
  void initState() {
    super.initState();
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    final data = await FirestoreService().getExpenses();
    setState(() {
      expenses = data;
      calculateTotals();
      showMostCarbonFootprintCategory();
    });
  }

  void calculateTotals() {
    final DateTime now = DateTime.now();
    final DateTime lastMonth = DateTime(now.year, now.month - 1, 1);
    final DateTime thisMonth = DateTime(now.year, now.month, 1);

    totalLastMonth = expenses
        .where((expense) => DateTime.parse(expense.date).isAfter(lastMonth) && DateTime.parse(expense.date).isBefore(thisMonth))
        .fold(0, (sum, item) => sum + item.amount);

    totalThisMonth = expenses
        .where((expense) => DateTime.parse(expense.date).isAfter(thisMonth))
        .fold(0, (sum, item) => sum + item.amount);
  }

  void showMostCarbonFootprintCategory() {
    if (expenses.isNotEmpty) {
      final categoryTotals = <String, double>{};
      for (var expense in expenses) {
        final factor = getFactorForCategory(expense.category);
        categoryTotals[expense.category] = (categoryTotals[expense.category] ?? 0) + expense.amount * factor;
      }
      final mostImpactfulCategory = categoryTotals.entries.reduce((a, b) => a.value > b.value ? a : b).key;
      final mostImpactfulAmount = categoryTotals[mostImpactfulCategory]!;
      final percentChange = ((totalThisMonth - totalLastMonth) / totalLastMonth * 100).toStringAsFixed(1);

      String changeText;
      if (double.tryParse(percentChange)! > 0) {
        changeText = "arttı";
      } else if (double.tryParse(percentChange)! < 0) {
        changeText = "azaldı";
      } else {
        changeText = "değişmedi";
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Harcama Verileri'),
            backgroundColor: Colors.white,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                Text('Bu ay $mostImpactfulAmount TL ile en çok harcamayı $mostImpactfulCategory kategorisinde yaptınız.'),
                Text('Tüm harcamalarınız geçen aya göre %$percentChange $changeText.'),
                Image.asset('assets/images/rabbit.png', height: 200),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tamam'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CarbonFootprintPage(
                        userFootprint: calculateCarbonFootprint(),
                        expenses: expenses,
                      ),
                    ),
                  );
                },
                child: Text('Karbon Ayakizi Sayfasına Git', style: TextStyle(color: Colors.blue)),
              ),
            ],
          );
        },
      );
    }
  }

  double getFactorForCategory(String category) {
    switch (category) {
      case 'Eğitim':
        return 0.1;
      case 'Eğlence':
        return 0.2;
      case 'Elektronik':
        return 0.3;
      case 'Fatura':
        return 0.05;
      case 'Giyim':
        return 0.25;
      case 'Market':
        return 0.15;
      case 'Yeme-İçme':
        return 0.2;
      default:
        return 0.1;
    }
  }

  double calculateCarbonFootprint() {
    double total = 0;
    for (var expense in expenses) {
      total += expense.amount * getFactorForCategory(expense.category);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('İyi Günler,', style: TextStyle(fontSize: 14, color: Colors.white)),
                  Text('Utku', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.qr_code, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.notifications, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white, // Scaffold'un arka plan rengi beyaz
        body: _pages[_currentIndex], // Sayfa içeriğini güncelle
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.white, // Arka plan beyaz
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
            BottomNavigationBarItem(icon: Icon(Icons.business), label: 'İşlemler'),
            BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Varlıklar/Borçlar'),
            BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'Kampanyalar'),
          ],
          selectedItemColor: Colors.blue[800],
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true, // Tüm öğelerde yazı göster
        ),
      ),
    );
  }
}
