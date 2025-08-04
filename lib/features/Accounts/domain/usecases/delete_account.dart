import '../repositories/account_repository.dart';

class DeleteAccount {
  final AccountRepository accountRepository;

  DeleteAccount(this.accountRepository);
  Future<void> execute(int id) async {
    await accountRepository.deleteAccount(id);
  }
  
}