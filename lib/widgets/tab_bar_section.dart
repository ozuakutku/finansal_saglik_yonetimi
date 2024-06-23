import 'package:flutter/material.dart';
import 'package:finanasal_saglik_raporu/views/expense_report_page.dart';

class TabBarSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TabBar(
        labelColor: Colors.blue[800],
        unselectedLabelColor: Colors.grey,
        indicatorColor: Colors.blue[800],
        tabs: [
          Tab(text: 'Hesaplarım'),
          Tab(text: 'Kredilerim / Kartlarım'),
          Tab(text: 'Yatırımlarım'),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExpenseReportPage()),
              );
            },
            child: Tab(text: 'Finansal Sağlık'),
          ),
        ],
      ),
    );
  }
}
