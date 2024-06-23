import 'package:flutter/material.dart';

class ActionButtonsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.blue[800], // Arka plan mavi
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          circularIconWithLabel('Para Transferi', Icons.swap_horiz),
          circularIconWithLabel('Kredi Ödeme', Icons.payment),
          circularIconWithLabel('QR ile Para Çek', Icons.qr_code),
          circularIconWithLabel('Banka / Kurum Ekle', Icons.account_balance),
        ],
      ),
    );
  }

  Widget circularIconWithLabel(String label, IconData icon) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white, // Beyaz arka plan
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2), // Beyaz kenar çizgisi
          ),
          padding: EdgeInsets.all(8), // Padding'i küçülttük
          child: Icon(icon, color: Colors.blue[800], size: 24), // İkon boyutunu küçülttük
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 10), // Metin boyutunu küçülttük
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
