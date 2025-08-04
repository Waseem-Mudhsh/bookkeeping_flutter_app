import 'package:bookkeeping_flutter_app/features/Accounts/domain/repositories/account_repository.dart';

import '../entities/account.dart';

class AddAccount {
  final AccountRepository accountRepository;

  AddAccount(this.accountRepository);
  Future<void> execute( Account account) async {
    await accountRepository.addAccount( account);
  }
}