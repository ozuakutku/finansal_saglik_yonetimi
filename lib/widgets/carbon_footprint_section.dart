import 'package:flutter/material.dart';
import '../utils/footprint_visualization.dart';

class CarbonFootprintSection extends StatelessWidget {
  final double totalCarbonFootprint;
  final VoidCallback onCalculate;

  CarbonFootprintSection({required this.totalCarbonFootprint, required this.onCalculate});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: onCalculate,
            child: Text('Karbon Ayak İzini Hesapla'),
          ),
        ),
        if (totalCarbonFootprint > 0)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CarbonFootprintVisualization(footprintValue: totalCarbonFootprint),
          ),
      ],
    );
  }
}
