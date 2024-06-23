import 'package:flutter/material.dart';

class CampaignBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[600],
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ekstra Kazanmaya Devam!',
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'Kiraz Hesap’ınıza %0,25 ek faiz kazandınız, 4 hedefle %3,5 kazanın!',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          SizedBox(height: 5),
          Text(
            'Ekstra Kazan',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
