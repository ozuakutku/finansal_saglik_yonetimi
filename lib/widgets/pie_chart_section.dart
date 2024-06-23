import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartSection extends StatelessWidget {
  final List<PieChartSectionData> sections;

  PieChartSection({required this.sections});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16.0),
      child: PieChart(
        PieChartData(
          sections: sections,
        ),
      ),
    );
  }
}
