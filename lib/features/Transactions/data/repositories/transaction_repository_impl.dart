import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/transaction_local_datasource.dart';

class TransactionRepositoryImpl implements TransactionRepository{
  final TransactionLocalDataSource localDataSource;

  TransactionRepositoryImpl(this.localDataSource);

  @override
  Future<List<Transaction>> getAllTransactions() {
    return localDataSource.getAllTransactions();
  }

  @override
  Future<List<Transaction>> getTransactionsByAccountId(String accountId) {
    return localDataSource.getTransactionsByAccountId(accountId);
  }

  @override
  Future<void> addTransaction(Transaction transaction) {
    return localDataSource.addTransaction(transaction);
  }

  @override
  Future<void> updateTransaction(Transaction transaction) {
    return localDataSource.updateTransaction(transaction);
  }

  @override
  Future<void> deleteTransaction(String transactionId) {
    return localDataSource.deleteTransaction(transactionId);
  }
  
  

}