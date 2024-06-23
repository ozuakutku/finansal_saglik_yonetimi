import 'package:flutter/material.dart';
import 'package:finanasal_saglik_raporu/widgets/tab_bar_section.dart';
import 'package:finanasal_saglik_raporu/widgets/account_section.dart';
import 'package:finanasal_saglik_raporu/widgets/financial_market_section.dart';
import 'package:finanasal_saglik_raporu/widgets/action_buttons_section.dart';
import 'package:finanasal_saglik_raporu/services/firestore_service.dart';
import 'package:finanasal_saglik_raporu/models/expense.dart';
import 'package:finanasal_saglik_raporu/views/add_expense_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> _pages = [HomeScreen(), AddExpensePage(), Placeholder(), Placeholder()];

  List<Expense> expenses = [];

  @override
  void initState() {
    super.initState();
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    final data = await FirestoreService().getExpenses();
    setState(() {
      expenses = data;
      showMostCarbonFootprintCategory();
    });
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

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Karbon Ayakizi Uyarısı'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/sad_rabbit.png', height: 100), // Üzgün tavşan resmi
                SizedBox(height: 10),
                Text('Bu ay en çok $mostImpactfulCategory kategorisinde karbon ayak izi oluşturdunuz: ${mostImpactfulAmount.toStringAsFixed(2)} kg CO2e.'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tamam'),
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

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[800], // Arka plan mavi
      child: Column(
        children: <Widget>[
          TabBarSection(),
          Container(
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white, // İç kısmın beyaz olması
              borderRadius: BorderRadius.circular(10),
            ),
            child: AccountSection(),
          ),
          ActionButtonsSection(), // ActionButtonsSection widget'ı eklendi
          Expanded(child: FinancialMarketSection()), // Expanded widget ile FinancialMarketSection genişletildi
        ],
      ),
    );
  }
}
