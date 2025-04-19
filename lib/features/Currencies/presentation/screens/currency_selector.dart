import 'package:flutter/material.dart';
import '../widgets/currency_tabbar.dart';
import '../../domain/entities/currency.dart';

class CurrencySelectorScreen extends StatelessWidget {
  const CurrencySelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return 
      
      CurrencyTabBar(
        onCurrencySelected: (Currency currency) {
          // قم بتنفيذ الإجراء المطلوب عند اختيار عملة
          
          debugPrint("العملة المختارة: ${currency.name}");
        },
      );
    
  }
}
