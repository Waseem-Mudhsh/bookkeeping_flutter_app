import 'package:bookkeeping_flutter_app/features/Transactions/domain/entities/transaction.dart';
import 'package:hive/hive.dart';



class TransactionLocalDataSource {
  final Box<Transaction> _transactionBox;

  TransactionLocalDataSource(this._transactionBox);
  Future<List<Transaction>> getAllTransactions() async {
    return _transactionBox.values.toList();
  }

  Future<List<Transaction>> getTransactionsByAccountId(String accountId) async {
    return _transactionBox.values.where((transaction) => transaction.accountId == accountId).toList();
  }

  Future<void> addTransaction(Transaction transaction) async {
    await _transactionBox.put(transaction.id, transaction);
  }

  Future<void> updateTransaction(Transaction transaction) async {
    await _transactionBox.put(transaction.id, transaction);
  }

  Future<void> deleteTransaction(String transactionId) async {
    await _transactionBox.delete(transactionId);
  }
}