import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

class GetTransactionsByAccountId {
  final TransactionRepository transactionRepository;
  GetTransactionsByAccountId(this.transactionRepository);

  Future<List<Transaction>> execute(String accountId) async {
    return transactionRepository.getTransactionsByAccountId(accountId);
  }
}