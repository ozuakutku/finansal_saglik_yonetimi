import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:finanasal_saglik_raporu/models/expense.dart';
import 'package:finanasal_saglik_raporu/services/firestore_service.dart';
import 'package:finanasal_saglik_raporu/widgets/expense_dropdown.dart';
import 'package:finanasal_saglik_raporu/widgets/pie_chart_section.dart';
import 'package:finanasal_saglik_raporu/widgets/expense_summary.dart';
import 'package:finanasal_saglik_raporu/views/carbon_footprint_page.dart';

class ExpenseReportPage extends StatefulWidget {
  @override
  _ExpenseReportPageState createState() => _ExpenseReportPageState();
}

class _ExpenseReportPageState extends State<ExpenseReportPage> {
  List<Expense> expenses = [];
  List<Expense> filteredExpenses = [];
  String selectedMonth = '06'; // Default to June

  @override
  void initState() {
    super.initState();
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    final data = await FirestoreService().getExpenses();
    setState(() {
      expenses = data;
      filterExpensesByMonth(selectedMonth);
    });
  }

  void filterExpensesByMonth(String month) {
    setState(() {
      filteredExpenses = expenses.where((expense) {
        final date = DateTime.parse(expense.date);
        return date.month.toString().padLeft(2, '0') == month;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalExpenses = getTotalExpenses();
    final categoryTotals = getCategoryTotals();
    return Scaffold(
      appBar: AppBar(
        title: Text('Finansal Sağlık Raporu'),
        backgroundColor: Colors.blue[800],
      ),
      body: expenses.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Harcama Dağılımı',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            ExpenseDropdown(
              selectedMonth: selectedMonth,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedMonth = value;
                    filterExpensesByMonth(value);
                  });
                }
              },
            ),
            PieChartSection(sections: showingSections()),
            ExpenseSummary(
              totalExpenses: totalExpenses,
              categoryTotals: categoryTotals,
              categoryColors: categoryColors,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CarbonFootprintPage(
                        userFootprint: calculateCarbonFootprint(),
                        expenses: filteredExpenses,
                      ),
                    ),
                  );
                },
                child: Text('Karbon Ayakizi Hesapla'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    final Map<String, double> categoryTotals = {};
    for (var expense in filteredExpenses) {
      categoryTotals[expense.category] = (categoryTotals[expense.category] ?? 0) + expense.amount;
    }

    final List<PieChartSectionData> sections = [];
    categoryTotals.forEach((category, total) {
      sections.add(PieChartSectionData(
        color: getColorForCategory(category),
        value: total,
        title: '${(total / getTotalExpenses() * 100).toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ));
    });

    return sections;
  }

  double getTotalExpenses() {
    return filteredExpenses.fold(0, (sum, item) => sum + item.amount);
  }

  Map<String, double> getCategoryTotals() {
    final Map<String, double> categoryTotals = {};
    for (var expense in filteredExpenses) {
      categoryTotals[expense.category] = (categoryTotals[expense.category] ?? 0) + expense.amount;
    }
    return categoryTotals;
  }

  double calculateCarbonFootprint() {
    double total = 0;
    filteredExpenses.forEach((expense) {
      double factor = 0;
      switch (expense.category) {
        case 'Eğitim':
          factor = 0.1;
          break;
        case 'Eğlence':
          factor = 0.2;
          break;
        case 'Elektronik':
          factor = 0.3;
          break;
        case 'Fatura':
          factor = 0.05;
          break;
        case 'Giyim':
          factor = 0.25;
          break;
        case 'Market':
          factor = 0.15;
          break;
        case 'Yeme-İçme':
          factor = 0.2;
          break;
        default:
          factor = 0.1;
      }
      total += expense.amount * factor;
    });
    return total;
  }

  Color getColorForCategory(String category) {
    switch (category) {
      case 'Eğitim':
        return Colors.orange;
      case 'Eğlence':
        return Colors.red;
      case 'Elektronik':
        return Colors.blue;
      case 'Fatura':
        return Colors.yellow;
      case 'Giyim':
        return Colors.green;
      case 'Market':
        return Colors.purple;
      case 'Yeme-İçme':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }

  Map<String, Color> get categoryColors => {
    'Eğitim': Colors.orange,
    'Eğlence': Colors.red,
    'Elektronik': Colors.blue,
    'Fatura': Colors.yellow,
    'Giyim': Colors.green,
    'Market': Colors.purple,
    'Yeme-İçme': Colors.pink,
  };
}
