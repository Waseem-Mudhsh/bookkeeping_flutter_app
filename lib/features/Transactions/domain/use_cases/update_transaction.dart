
import 'package:bookkeeping_flutter_app/features/Transactions/domain/entities/transaction.dart';

import '../repositories/transaction_repository.dart';

class UpdateTransaction {
  final TransactionRepository transactionRepository;
  UpdateTransaction(this.transactionRepository);

  Future<void> execute(Transaction transaction) async {
    await transactionRepository.updateTransaction(transaction);
  }
}