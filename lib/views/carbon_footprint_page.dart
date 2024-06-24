import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finanasal_saglik_raporu/models/expense.dart';

class CarbonFootprintPage extends StatelessWidget {
  final double userFootprint;
  final double turkeyFootprint = 492; // Aylık değer (kg CO2e)
  final double worldFootprint = 567; // Aylık değer (kg CO2e)
  final List<Expense> expenses;

  CarbonFootprintPage({
    required this.userFootprint,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Karbon Ayakizi'),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Karbon Ayakizi Karşılaştırması',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              buildFootprintComparison('Kullanıcı', userFootprint, Colors.green[700]!),
              buildFootprintComparison('Türkiye', turkeyFootprint, Colors.green[500]!),
              buildFootprintComparison('Dünya', worldFootprint, Colors.green[300]!),
              SizedBox(height: 40),
              Text(
                'Kullanıcı Ayakizi Dağılımı',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Container(
                height: 300,
                child: PieChart(
                  PieChartData(
                    sections: showingSections(),
                  ),
                ),
              ),
              buildLegend(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFootprintComparison(String label, double footprint, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Text(
            '$label: ${footprint.toStringAsFixed(2)} kg CO2e',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            height: 150,
            width: 150,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SvgPicture.asset(
                  'assets/images/footprint.svg',
                  color: Colors.grey[300],
                ),
                ClipRect(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    heightFactor: footprint / 3000, // Normalizasyon faktörü
                    child: SvgPicture.asset(
                      'assets/images/footprint.svg',
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    final Map<String, double> categoryTotals = {};
    for (var expense in expenses) {
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
      categoryTotals[expense.category] = (categoryTotals[expense.category] ?? 0) + expense.amount * factor;
    }

    final List<PieChartSectionData> sections = [];
    categoryTotals.forEach((category, total) {
      sections.add(PieChartSectionData(
        color: getColorForCategory(category),
        value: total,
        title: '${(total / userFootprint * 100).toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ));
    });

    return sections;
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

  Widget buildLegend() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          buildLegendItem('Eğitim', Colors.orange),
          buildLegendItem('Eğlence', Colors.red),
          buildLegendItem('Elektronik', Colors.blue),
          buildLegendItem('Fatura', Colors.yellow),
          buildLegendItem('Giyim', Colors.green),
          buildLegendItem('Market', Colors.purple),
          buildLegendItem('Yeme-İçme', Colors.pink),
        ],
      ),
    );
  }

  Widget buildLegendItem(String category, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        SizedBox(width: 8),
        Text(category),
      ],
    );
  }
}
