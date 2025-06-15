import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/main_account.dart';



// Define a provider that fetches and manages the list of main accounts
class MainAccountsNotifier extends StateNotifier<List<MainAccountModel>> {
  MainAccountsNotifier() : super([]); // Initialize with an empty list

  // Method to load main accounts (e.g., from a database or API)
  Future<void> loadMainAccounts() async {
    // Simulate loading data from a source
    await Future.delayed(const Duration(seconds: 1)); // Simulate a delay

    // Replace this with your actual data loading logic
    final List<MainAccountModel> loadedAccounts = [
  MainAccountModel(id: 1, name: 'شخصي', totalBalance: 3500.0),
  MainAccountModel(id: 2, name: 'عمل', totalBalance: 12500.0),
  MainAccountModel(id: 3, name: 'عائلي', totalBalance: 4300.0),
  MainAccountModel(id: 4, name: 'ادخار', totalBalance: 9200.0),
];

    state = loadedAccounts; // Update the state with the loaded data
  }

  // Method to add a new main account
  void addMainAccount(MainAccountModel account) {
    state = [...state, account]; // Add the new account to the list
  }

  // Method to update an existing main account
  void updateMainAccount(MainAccountModel updatedAccount) {
    state = [
      for (final account in state)
        if (account.id == updatedAccount.id) updatedAccount else account,
    ];
  }

  // Method to delete a main account
  void deleteMainAccount(String accountId) {
    state = state.where((account) => account.id != accountId).toList();
  }
}

// Create the StateNotifierProvider
final mainAccountsProvider =
    StateNotifierProvider<MainAccountsNotifier, List<MainAccountModel>>(
        (ref) => MainAccountsNotifier());