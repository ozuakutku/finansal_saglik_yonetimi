import 'package:flutter/material.dart';
import 'package:finanasal_saglik_raporu/widgets/tab_bar_section.dart';
import 'package:finanasal_saglik_raporu/widgets/account_section.dart';
import 'package:finanasal_saglik_raporu/widgets/financial_market_section.dart';
import 'package:finanasal_saglik_raporu/widgets/action_buttons_section.dart';

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
