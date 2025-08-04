import 'package:bookkeeping_flutter_app/features/Accounts/domain/entities/account.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/domain/repositories/account_repository.dart';

class UpdateAccount {
  final AccountRepository accountRepository;

  UpdateAccount(this.accountRepository);
  Future<void> execute(Account account) async {
    await accountRepository.updateAccount(account);
  }
}