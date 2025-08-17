
import 'package:bookkeeping_flutter_app/features/Transactions/domain/use_cases/add_transaction.dart';
import 'package:bookkeeping_flutter_app/features/Transactions/domain/use_cases/get_transactions.dart';
import 'package:bookkeeping_flutter_app/features/Transactions/domain/use_cases/get_transactions_by_account_id.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/use_cases/delete_transaction.dart';
import '../../domain/use_cases/update_transaction.dart';

class TransactionViewModel extends StateNotifier<AsyncValue<List<Transaction>>> {
  final GetTransactions _getTransactions;
  final GetTransactionsByAccountId _getTransactionsByAccountId;
  final AddTransaction _addTransaction;
  final UpdateTransaction _updateTransaction;
  final DeleteTransaction _deleteTransaction;
  final String? accountId;

  TransactionViewModel({
    required GetTransactions getTransactions,
    required GetTransactionsByAccountId getTransactionsByAccountId,
    required AddTransaction addTransaction,
    required UpdateTransaction updateTransaction,
    required DeleteTransaction deleteTransaction,
    this.accountId,
  }) :  _getTransactions = getTransactions,
        _getTransactionsByAccountId = getTransactionsByAccountId,
        _addTransaction = addTransaction,
        _updateTransaction = updateTransaction,
        _deleteTransaction = deleteTransaction,
        super(const AsyncValue.loading()) {
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (accountId != null && accountId!.isNotEmpty )  {
        return await _getTransactionsByAccountId.execute(accountId!);
      } else {
        return await _getTransactions.execute();
      }
    });
  }

  Future<List<Transaction>> getTransactionsByAccountId( String accountId) async {
    return await _getTransactionsByAccountId.execute(accountId);
  }

  Future<void> addTransaction(Transaction transaction) async {
    await _addTransaction.execute(transaction);
    await _loadTransactions();
  }

  Future<void> updateTransaction(Transaction transaction) async {
    await _updateTransaction.execute(transaction);
    await _loadTransactions();
  }

  Future<void> deleteTransaction(String transactionId) async {
    await _deleteTransaction.execute(transactionId);
    await _loadTransactions();
  }
}