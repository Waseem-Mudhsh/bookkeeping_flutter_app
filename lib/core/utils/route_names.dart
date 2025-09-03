import 'package:bookkeeping_flutter_app/features/Accounts/domain/entities/account.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/presentation/screens/add_new_account_screen.dart';
import 'package:bookkeeping_flutter_app/features/Customers/presentation/screens/customers_screen.dart';
import 'package:bookkeeping_flutter_app/features/Home/presentation/screens/home_main_screen.dart';
import 'package:flutter/material.dart';

import '../../features/Accounts/presentation/screens/account_details_screen.dart';
import '../../features/Customers/presentation/screens/add_new_customer_form.dart';
import '../../features/Home/presentation/screens/finance_screen.dart';
import '../../features/Home/presentation/screens/settings_screen.dart';
import '../../features/Notifications/presentation/screens/notifications_screen.dart';
import '../../features/Transactions/domain/entities/transaction.dart';
import '../../features/Transactions/presentation/widgets/add_transaction_form.dart';

enum RouteNames {
  home,
  customers,
  finance,
  settings,
  accounts,
  notifications,
  accountDetails;
  

  Widget get screen {
    switch (this) {
      case RouteNames.home:
        return HomeMainScreen();
      case RouteNames.customers:
        return CustomersScreen();
      case RouteNames.finance:
        return FinanceScreen();
      case RouteNames.settings:
        return SettingsScreen();
      case RouteNames.notifications:
        return NotificationsScreen(mockNotifications: []);
      case RouteNames.accountDetails:
        return AccountDetailsScreen();
      default:
       return Scaffold(body: Center(child: Text('No screen found')));
    }
  }
  
}
// Usage
// Navigator.push(
//   context,
//   MaterialPageRoute(builder: (context) => RouteNames.customers.screen),
// );

enum CustomerSubRoutes {
  list,
  details,
  create,
  edit;


  Widget get screen {
    switch (this) {
      case CustomerSubRoutes.create:
        return AddNewCustomerForm();
      default:
        return Scaffold(body: Center(child: Text('No customer screen found'))); // or some other default widget
    }
  }
}
enum AccountSubRoutes {
  list,
  details,
  create,
  edit;

  Widget get screen {
    switch (this) {
      case AccountSubRoutes.create:
        return AddNewAccountScreen();
      default:
        return Scaffold(body: Center(child: Text('No account screen found'))); // or some other default widget
    }
  }
  Widget screenEdit(Account account) {
    return AddNewAccountScreen(existingAccount: account);
  }
}
enum TransactionSubRoutes {
  create,
  edit;

  Widget screenAdd(String accountId) {
  return AddTransactionForm(accountId: accountId);
  }
  Widget screenEdit(String accountId, Transaction transaction) {
    return AddTransactionForm(accountId: accountId, existingTransaction: transaction);
  }
}

