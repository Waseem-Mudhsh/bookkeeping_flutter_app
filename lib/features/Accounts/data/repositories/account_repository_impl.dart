import 'package:bookkeeping_flutter_app/features/Accounts/data/datasources/account_local_datasource.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/domain/entities/account.dart';

import '../../domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository{
  final AccountLocalDataSource accountLocalDatasource;

  AccountRepositoryImpl(this.accountLocalDatasource);
  
  @override
  Future<List<Account>> getAccounts() async {
    return accountLocalDatasource.getAllAccounts();
  }
  @override
  Future<void> addAccount(Account account) async {
    await accountLocalDatasource.addAccount(account);
  }
  @override
  Future<void> updateAccount(Account account) async {
    await accountLocalDatasource.updateAccount(account);
  }
  @override
  Future<void> deleteAccount(String idAccount) async {
    await accountLocalDatasource.deleteAccount(idAccount);
  }
}