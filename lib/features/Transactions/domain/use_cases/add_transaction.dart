import 'package:bookkeeping_flutter_app/features/Transactions/domain/entities/transaction.dart';
import 'package:bookkeeping_flutter_app/features/Transactions/domain/repositories/transaction_repository.dart';


class AddTransaction {
  final TransactionRepository repository;

  AddTransaction(this.repository);

  Future<void> execute(Transaction transaction) async {
    await repository.addTransaction(transaction);
  }
}