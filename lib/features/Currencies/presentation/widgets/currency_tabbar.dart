import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/currency_provider.dart';
import '../../domain/entities/currency.dart';

class CurrencyTabBar extends ConsumerWidget {
  final void Function(Currency currency) onCurrencySelected;

  const CurrencyTabBar({super.key, required this.onCurrencySelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencies = ref.watch(currencyListProvider);

    return SizedBox(
      height: 50,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: currencies.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          if (index == currencies.length) {
            return OutlinedButton.icon(
              onPressed: () => _showAddCurrencyDialog(context, ref),
              icon: const Icon(Icons.add),
              label: const Text('إضافة عملة'),
            );
          }

          final currency = currencies[index];
          return ElevatedButton(
            onPressed: () => onCurrencySelected(currency),
            child: Text(currency.name),
          );
        },
      ),
    );
  }

  void _showAddCurrencyDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final codeController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('إضافة عملة جديدة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'اسم العملة'),
            ),
            TextField(
              controller: codeController,
              decoration: const InputDecoration(labelText: 'رمز العملة'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final currency = Currency(
                name: nameController.text,
                code: codeController.text.toUpperCase(),
              );
              ref.read(currencyListProvider.notifier).addCurrency(currency);
              Navigator.pop(context);
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }
}
