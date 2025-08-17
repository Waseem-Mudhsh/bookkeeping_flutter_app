import 'package:hive/hive.dart';

import '../../domain/entities/account.dart';

class AccountLocalDataSource {
  final Box<Account> _accountBox;

  AccountLocalDataSource(this._accountBox);

  Future<List<Account>> getAllAccounts() async {
    return _accountBox.values.toList();
  }
  Future<void> addAccount(Account account) async {
    await _accountBox.add(account);
  }
  Future<void> updateAccount(Account account) async {
    await _accountBox.put(account.id, account);
  }
  Future<void> deleteAccount(String accountId) async {
    await _accountBox.delete(accountId);
  }
}