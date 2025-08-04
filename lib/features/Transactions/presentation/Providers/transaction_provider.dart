import 'package:bookkeeping_flutter_app/features/Transactions/domain/use_cases/get_transactions.dart';
import 'package:bookkeeping_flutter_app/features/Transactions/domain/use_cases/get_transactions_by_account_id.dart';
import 'package:bookkeeping_flutter_app/features/Transactions/domain/use_cases/update_transaction.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../data/datasources/transaction_local_datasource.dart';
import '../../data/repositories/transaction_repository_impl.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/use_cases/add_transaction.dart';
import '../../domain/use_cases/delete_transaction.dart';
import '../viewModel/transaction_viewmodel.dart';




final transactionDataSourceProvider = Provider<TransactionLocalDataSource>((ref) {
  return TransactionLocalDataSource(Hive.box<Transaction>('transactions'));
});

final transactionRepositoryProvider = Provider<TransactionRepositoryImpl>((ref) {
  return TransactionRepositoryImpl(ref.read(transactionDataSourceProvider));
});
final getTransactionsProvider = Provider<GetTransactions>((ref){
  return GetTransactions(ref.read(transactionRepositoryProvider));
});
final getTransactionsByAccountIdProvider = Provider<GetTransactionsByAccountId>((ref) {
  return GetTransactionsByAccountId(ref.read(transactionRepositoryProvider));
});
final addTransactionProvider = Provider<AddTransaction>((ref) {
  return AddTransaction(ref.read(transactionRepositoryProvider));
});
final updateTransactionProvider = Provider<UpdateTransaction>((ref){
  return UpdateTransaction(ref.read(transactionRepositoryProvider));
});
final deleteTransactionProvider = Provider<DeleteTransaction>((ref){
  return DeleteTransaction(ref.read(transactionRepositoryProvider));
});

final transactionViewModelProvider = StateNotifierProvider<TransactionViewModel, AsyncValue<List<Transaction>>>((ref) {
  return TransactionViewModel(
    getTransactions: ref.read(getTransactionsProvider),
    getTransactionsByAccountId: ref.read(getTransactionsByAccountIdProvider),
    addTransaction: ref.read(addTransactionProvider),
    updateTransaction: ref.read(updateTransactionProvider),
    deleteTransaction: ref.read(deleteTransactionProvider), 
  );
});