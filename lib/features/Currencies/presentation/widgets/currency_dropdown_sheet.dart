import 'package:bookkeeping_flutter_app/core/providers/theme_data_provider.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_dropdown_sheet.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:bookkeeping_flutter_app/features/Currencies/domain/entities/currency.dart';
import 'package:bookkeeping_flutter_app/features/Currencies/presentation/providers/currency_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrencyDropdownSheet extends ConsumerStatefulWidget {
  const CurrencyDropdownSheet({super.key});

  @override
  ConsumerState<CurrencyDropdownSheet> createState() =>
      _CurrencyDropdownSheetState();
}

@override
class _CurrencyDropdownSheetState extends ConsumerState<CurrencyDropdownSheet> {
  late List<Currency> currencies = [];
  late Currency currencySelected;
  @override
  void initState() {
    super.initState();
    currencies = ref.read(currencyListProvider);
    currencySelected = currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeDataProvider);
    return CustomDropdownSheet(
      items: currencies,
      selectedItem: currencySelected,

      /// what appears in the main button
      selectedItemBuilder:
          (c) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              CustomAutoSizeText(
                text: c.code,
                style: theme.textTheme.bodySmall,
              ),
              ResponsiveSpace(width: 6),
              CustomAutoSizeText(
                text: c.name,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
          
          

      /// what appears in the bottom sheet list
      itemBuilder:
          (c) => ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  c.flagUrl != null
                      ? Image.asset(c.flagUrl!, fit: BoxFit.none).image
                      : null,

              backgroundColor: Colors.grey.shade200,
            ),
            title: Text(c.name, style: theme.textTheme.bodyLarge),
            subtitle: Text(c.code, style: theme.textTheme.bodyMedium),
            trailing: Text(
              c.balanceDue!.toStringAsFixed(2),
              style: theme.textTheme.bodyMedium,
            ),
          ),
      onSelected: (c) => setState(() => currencySelected = c),
    );
  }
}
