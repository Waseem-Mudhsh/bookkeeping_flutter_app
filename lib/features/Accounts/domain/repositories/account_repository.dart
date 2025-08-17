import 'package:bookkeeping_flutter_app/features/Accounts/domain/entities/account.dart';

abstract class AccountRepository {
  Future<List<Account>> getAccounts();
  Future<void> addAccount(Account account);
  Future<void> updateAccount(Account account);
  Future<void> deleteAccount(String accountId);
  
}