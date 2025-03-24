import 'package:bookkeeping_flutter_app/models/transaction.dart';

class TransactionService {
  List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
  }

  void removeTransaction(String id) {
    _transactions.removeWhere((transaction) => transaction.id == id);
  }
}