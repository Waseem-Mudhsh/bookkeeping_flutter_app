import 'package:bookkeeping_flutter_app/features/Accounts/domain/usecases/add_account.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/domain/usecases/get_accounts.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/domain/usecases/update_account.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/account.dart';
import '../../domain/usecases/delete_account.dart';

class AccountViewModel  extends StateNotifier<AsyncValue<List<Account>>>{
  final GetAccounts _getAccounts;
  final AddAccount _addAccount;
  final UpdateAccount _updateAccount;
  final DeleteAccount _deleteAccount;

  AccountViewModel({
    required GetAccounts getAccounts,
    required AddAccount addAccount,
    required UpdateAccount updateAccount,
    required DeleteAccount deleteAccount,
  })  : _getAccounts = getAccounts,
        _addAccount = addAccount,
        _updateAccount = updateAccount,
        _deleteAccount = deleteAccount,
        super(const AsyncValue.loading()) {
    loadAccounts();
  }

  Future<void> loadAccounts() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _getAccounts.execute();
    });
  }

  Future<void> addAccount(Account account) async {
    await _addAccount.execute(account);
    await loadAccounts();
  }
  Future<void> updateAccount(Account account) async {
    await _updateAccount.execute(account);
    await loadAccounts();
  }
  Future<void> deleteAccount(int idAccount) async {
    await _deleteAccount.execute(idAccount);
    await loadAccounts();
  }
}
