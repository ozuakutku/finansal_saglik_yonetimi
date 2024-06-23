import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CarbonFootprintPage extends StatelessWidget {
  final double carbonFootprint;

  CarbonFootprintPage({required this.carbonFootprint});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Karbon Ayakizi'),
        backgroundColor: Colors.blue[800],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Karbon Ayakizi: ${carbonFootprint.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              height: 400,
              width: 200, // İki ayağı yan yana sığdırmak için genişlik ayarlandı
              child: Stack(
                children: [
                  SvgPicture.asset(
                    'assets/images/footprint.svg',
                    color: Colors.grey,
                    height: 400,
                  ),
                  ClipRect(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      heightFactor: carbonFootprint / 1000, // Karbon ayak izi değerine göre ölçeklendirme
                      child: SvgPicture.asset(
                        'assets/images/footprint.svg',
                        color: Colors.green,
                        height: 400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
