
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/currency.dart';
import '../providers/currency_provider.dart';
import '../widgets/animated_rounded_tabbar_filled.dart';

class CurrencyTabbarfilled extends ConsumerStatefulWidget {
  const CurrencyTabbarfilled({super.key});

  @override
  ConsumerState<CurrencyTabbarfilled> createState() => _CurrencyTabbarfilledState();

}

class _CurrencyTabbarfilledState extends ConsumerState<CurrencyTabbarfilled> {
   int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final currencies = ref.watch(currencyListProvider);
    return ResponsiveSpace(
      height: 40,
      child: ListView.builder(  
        itemCount: currencies.length + 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
           if (index < currencies.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('تم اختيار ${currencies[index].name}')),
                  );
                },
                child: Text(currencies[index].name),
              ),
            );
        }
        else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: OutlinedButton.icon(
                onPressed: () => _showAddCurrencyDialog(context),
                icon: const Icon(Icons.add),
                label: const Text('إضافة عملة'),
              ),
            );
          }
        },
      ),

    );
  }
  void _showAddCurrencyDialog(BuildContext context) {
    final List<Currency> availableCurrencies = [
      Currency(code: 'USD', name: 'دولار أمريكي'),
      Currency(code: 'EUR', name: 'يورو'),
      Currency(code: 'EGP', name: 'جنيه مصري'),
    ];

    Currency? selected;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('إضافة عملة جديدة'),
        content: DropdownButtonFormField<Currency>(
          items: availableCurrencies.map((c) {
            return DropdownMenuItem(
              value: c,
              child: Text(c.name),
            );
          }).toList(),
          onChanged: (val) => selected = val,
          hint: const Text('اختر عملة'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (selected != null) {
                ref.read(currencyListProvider.notifier).addCurrency(selected!);
              }
              Navigator.pop(context);
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }
}
