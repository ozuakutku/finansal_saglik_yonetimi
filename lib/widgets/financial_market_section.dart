import 'package:flutter/material.dart';

class FinancialMarketSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.0), // Üstte biraz boşluk bırakalım
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Finansal Market',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              itemCount: 8, // Öğelerin sayısı
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Bir satırdaki öğe sayısı
                mainAxisSpacing: 20, // Satırlar arasındaki boşluk
                crossAxisSpacing: 10, // Sütunlar arasındaki boşluk
                childAspectRatio: 0.7, // Öğelerin en-boy oranı
              ),
              itemBuilder: (BuildContext context, int index) {
                return financialMarketItem(
                  titles[index],
                  imagePaths[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  final List<String> titles = [
    'FX Market',
    'Fon Market',
    'Borsa Market',
    'Alışgidiş',
    'Global Borsa',
    'Kripto Market',
    'BES / Sigorta',
    'Eurobond',
  ];

  final List<String> imagePaths = [
    'assets/images/fx_market.png',
    'assets/images/fon_market.png',
    'assets/images/borsa_market.png',
    'assets/images/alisgidiş.png',
    'assets/images/global_borsa.png',
    'assets/images/kripto_market.png',
    'assets/images/bes_sigorta.png',
    'assets/images/eurobond.png',
  ];

  Widget financialMarketItem(String title, String imagePath) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
          imagePath,
          width: 50,
          height: 50,
        ),
        SizedBox(height: 5),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 2), // İkon ve yazılardan sonra boşluk
      ],
    );
  }
}
