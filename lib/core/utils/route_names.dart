import 'package:bookkeeping_flutter_app/features/Customers/presentation/screens/customers_screen.dart';
import 'package:bookkeeping_flutter_app/features/Home/presentation/screens/home_main_screen.dart';
import 'package:flutter/material.dart';

import '../../features/Customers/presentation/screens/add_customer_sheet.dart';
import '../../features/Home/presentation/screens/finance_screen.dart';

enum RouteNames {
  home,
  customers,
  finance,
  settings;

  Widget get screen {
    switch (this) {
      case RouteNames.home:
        return HomeMainScreen();
      case RouteNames.customers:
        return CustomersScreen();
      case RouteNames.finance:
        return FinanceScreen();
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
        return AddCustomerSheet();
      default:
        return Scaffold(body: Center(child: Text('No customer screen found'))); // or some other default widget
    }
  }
}

