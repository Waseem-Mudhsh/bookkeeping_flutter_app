import 'package:flutter/material.dart';
import 'package:bookkeeping_flutter_app/models/transaction.dart';
import 'package:bookkeeping_flutter_app/services/transaction_service.dart';

class TransactionViewModel with ChangeNotifier {
  final TransactionService _transactionService = TransactionService();

  List<Transaction> get transactions => _transactionService.transactions;

  void addTransaction(Transaction transaction) {
    _transactionService.addTransaction(transaction);
    notifyListeners();
  }

  void removeTransaction(String id) {
    _transactionService.removeTransaction(id);
    notifyListeners();
  }
}