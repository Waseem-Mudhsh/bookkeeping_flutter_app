import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../data/datasources/account_local_datasource.dart';

import '../../data/repositories/account_repository_impl.dart';
import '../../domain/entities/account.dart';
import '../../domain/usecases/add_account.dart';
import '../../domain/usecases/delete_account.dart';
import '../../domain/usecases/get_accounts.dart';
import '../../domain/usecases/update_account.dart';
import '../viewModel/account_viewmodel.dart';

final accountDataSourceProvider = Provider<AccountLocalDataSource>((ref) {
  return AccountLocalDataSource(Hive.box<Account>('accounts'));
}); //ينشئ مصدر البيانات المحلي (Hive Box).

final accountRepositoryProvider = Provider<AccountRepositoryImpl>((ref) {
  return AccountRepositoryImpl(ref.read(accountDataSourceProvider));
});

final getAccountsProvider = Provider<GetAccounts>((ref) {
  return GetAccounts(ref.read(accountRepositoryProvider));
});
final addAccountProvider = Provider<AddAccount>((ref) {
  return AddAccount(ref.read(accountRepositoryProvider));
});
final updateAccountProvider = Provider<UpdateAccount>((ref) {
  return UpdateAccount(ref.read(accountRepositoryProvider));
});
final deleteAccountProvider = Provider<DeleteAccount>((ref) {
  return DeleteAccount(ref.read(accountRepositoryProvider));
});

final accountViewModelProvider =
    StateNotifierProvider<AccountViewModel, AsyncValue<List<Account>>>((ref) {
  return AccountViewModel(
    getAccounts: ref.read(getAccountsProvider),
    addAccount: ref.read(addAccountProvider),
    updateAccount: ref.read(updateAccountProvider),
    deleteAccount: ref.read(deleteAccountProvider),
  );
});
