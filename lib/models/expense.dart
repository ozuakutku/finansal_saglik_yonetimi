class Expense {
  final String date;
  final String store;
  final double amount;
  final String category;

  Expense({required this.date, required this.store, required this.amount, required this.category});

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'store': store,
      'amount': amount,
      'category': category,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      date: map['date'],
      store: map['store'],
      amount: map['amount'],
      category: map['category'],
    );
  }
}
