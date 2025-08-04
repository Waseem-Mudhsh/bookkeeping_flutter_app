import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

class GetTransactions {
   final TransactionRepository transactionRepository;
  GetTransactions(this.transactionRepository);

  Future<List<Transaction>> execute() async {
    return transactionRepository.getAllTransactions();
  }
}