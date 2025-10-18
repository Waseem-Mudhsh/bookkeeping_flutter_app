
import 'package:bookkeeping_flutter_app/features/Accounts/domain/entities/account.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/presentation/screens/account_ceiling_screen.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/presentation/screens/add_new_account_screen.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/presentation/screens/beneficiaries_screen.dart';
import 'package:bookkeeping_flutter_app/features/Home/presentation/screens/about_app_screen.dart';
import 'package:bookkeeping_flutter_app/features/Home/presentation/screens/about_us_screen.dart';
import 'package:bookkeeping_flutter_app/features/Home/presentation/screens/home_main_screen.dart';
import 'package:bookkeeping_flutter_app/features/Home/presentation/screens/support_screen.dart';
import 'package:bookkeeping_flutter_app/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:bookkeeping_flutter_app/features/auth/presentation/screens/otp_verification_screen.dart';
import 'package:bookkeeping_flutter_app/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:bookkeeping_flutter_app/features/auth/presentation/screens/login_screen.dart';
import 'package:bookkeeping_flutter_app/features/auth/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';

import '../../features/Accounts/presentation/screens/clientsScreen/debts_of_client_screen.dart';
import '../../features/Accounts/presentation/screens/account_details_screen.dart';
import '../../features/Accounts/presentation/screens/clientsScreen/merchant_ledger_screen.dart';
import '../../features/Home/presentation/screens/finance_screen.dart';
import '../../features/Home/presentation/screens/profile_screen.dart';
import '../../features/Home/presentation/screens/settings_screen.dart';
import '../../features/Notifications/presentation/screens/notifications_screen.dart';
import '../../features/Transactions/domain/entities/transaction.dart';
import '../../features/Transactions/presentation/widgets/add_transaction_form.dart';

enum RouteNames {
  home,
  profile,
  finance,
  settings,
  accounts,
  notifications,
  accountDetails,
  loginScreen,
  debtsOfClientScreen,
  merchantLedgerScreen,
  accountCeilingScreen,
  beneficiariesScreen,
  signUpScreen, 
  supportScreen, 
  aboutUsScreen,
  aboutAppScreen,
  forgotPasswordScreen,
  otpVerificationScreen,
  resetPasswordScreen;
  

  Widget get screen {
    switch (this) {
      case RouteNames.home:
        return HomeMainScreen();
      case RouteNames.profile:
        return ProfileScreen();
      case RouteNames.loginScreen:
        return LoginScreen();
     
      case RouteNames.finance:
        return FinanceScreen();
      case RouteNames.settings:
        return SettingsScreen();
      case RouteNames.notifications:
        return NotificationsScreen();
      case RouteNames.accountDetails:
        return AccountDetailsScreen();
      
      case RouteNames.debtsOfClientScreen:
        return DebtsOfClientScreen();
      case RouteNames.merchantLedgerScreen:
        return MerchantLedgerScreen();
      case RouteNames.accountCeilingScreen:
        return AccountCeilingScreen();
      case RouteNames.beneficiariesScreen:
        return BeneficiariesScreen();
      case RouteNames.signUpScreen:
        return SignUpScreen();
      case RouteNames.supportScreen:
        return SupportScreen();
      case RouteNames.aboutUsScreen:
        return AboutUsScreen();
      case RouteNames.aboutAppScreen:
        return AboutAppScreen();
      case RouteNames.forgotPasswordScreen:
        return const ForgotPasswordScreen();
      default:
       return Scaffold(body: Center(child: Text('No screen found')));
    }
  }

  Widget screenWithArgs(Map<String, dynamic> args) {
    switch (this) {
      case RouteNames.otpVerificationScreen:
        return OtpVerificationScreen(phoneNumber: args['phoneNumber']);
      case RouteNames.resetPasswordScreen:
        return ResetPasswordScreen(phoneNumber: args['phoneNumber']);
      default:
        return screen; // Fallback to screen without args
    }
  }
  
}
// Usage
// Navigator.push(
//   context,
//   MaterialPageRoute(builder: (context) => RouteNames.customers.screen),
// );


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
