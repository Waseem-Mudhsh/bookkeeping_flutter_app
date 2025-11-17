import 'package:bookkeeping_flutter_app/core/app_scaffold/adaptive_scaffold.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/presentation/screens/clientsScreen/debts_of_client_screen.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/presentation/screens/finance_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

class FinanceServiceScreen  extends ConsumerStatefulWidget {
  const FinanceServiceScreen({super.key});

  @override
  ConsumerState<FinanceServiceScreen> createState() => _FinanceServiceScreenState();
}

class _FinanceServiceScreenState extends ConsumerState<FinanceServiceScreen> {


 int _selectedIndex = 0;
 static const List<Widget> _pages = <Widget>[ 
  FinanceScreen(),
  DebtsOfClientScreen(),
  ];
  static const List<NavigationDestination> _destinations = [ 
    NavigationDestination(
      selectedIcon: CustomHugeIcon(icon: HugeIcons.strokeRoundedWallet01),
      icon: CustomHugeIcon(icon: HugeIcons.strokeRoundedAccountSetting01),
      label: 'Finance',
    ),
    NavigationDestination(
      selectedIcon: CustomHugeIcon(icon: HugeIcons.strokeRoundedWallet01),
      icon: CustomHugeIcon(icon: HugeIcons.strokeRoundedAccountSetting01),
      label: 'Debt',
    ),
   ];
  
  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      destinations: _destinations,
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      
      body: _pages[_selectedIndex],);
  }
}
