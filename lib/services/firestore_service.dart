import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finanasal_saglik_raporu/models/expense.dart';

class FirestoreService {
  final CollectionReference expenseCollection = FirebaseFirestore.instance.collection('expenses');

  Future<void> addExpense(Expense expense) {
    return expenseCollection.add(expense.toMap());
  }

  Future<List<Expense>> getExpenses() async {
    QuerySnapshot querySnapshot = await expenseCollection.get();
    return querySnapshot.docs.map((doc) => Expense.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }
}
