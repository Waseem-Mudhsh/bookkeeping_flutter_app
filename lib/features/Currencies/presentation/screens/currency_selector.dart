import 'package:bookkeeping_flutter_app/core/providers/theme_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/currency_tabbar.dart';
import '../../domain/entities/currency.dart';

class CurrencySelectorScreen extends ConsumerWidget {
  const CurrencySelectorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   final theme = ref.watch(themeDataProvider);
    return 
      
      CurrencyTabBar(
        onCurrencySelected: (Currency currency) {
          ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('تم اختيار ${currency.name}',
                style:theme.textTheme.bodySmall, ),
                backgroundColor:theme.colorScheme.tertiary ,
                
                duration: const Duration(milliseconds: 500),
              ));
          //مثال على كيفية استخدام العملة المختارة
          // يمكنك هنا تنفيذ أي إجراء تريده عند اختيار عملة معينة
          // قم بتنفيذ الإجراء المطلوب عند اختيار عملة
          
          debugPrint("العملة المختارة: ${currency.name}");
        },
      );
    
  }
}
