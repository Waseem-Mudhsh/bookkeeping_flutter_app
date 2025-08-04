import '../repositories/transaction_repository.dart';

class DeleteTransaction {
  final TransactionRepository transactionRepository;
  DeleteTransaction(this.transactionRepository);

  Future<void> execute (String transactionId) async {
    await transactionRepository.deleteTransaction(transactionId);
  }
}