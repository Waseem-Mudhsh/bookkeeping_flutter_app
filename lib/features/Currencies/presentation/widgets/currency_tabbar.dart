import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/responsive_notifier.dart';
import '../../../../core/providers/theme_data_provider.dart';
import '../providers/currency_provider.dart';
import '../../domain/entities/currency.dart';

class CurrencyTabBar extends ConsumerStatefulWidget {
  final Function(Currency) onCurrencySelected;

  const CurrencyTabBar({super.key, required this.onCurrencySelected});

  @override
  ConsumerState<CurrencyTabBar> createState() => _CurrencyTabBarState();
}

class _CurrencyTabBarState extends ConsumerState<CurrencyTabBar> {
  Currency? _selectedCurrency;

  @override
  void initState() {
    super.initState();
    // Initialize the selected currency to the first one in the list if available
    final currencies = ref.read(currencyListProvider);
    if (currencies.isNotEmpty) {
      _selectedCurrency = currencies.firstWhere(
        (currency) => currency.code == "YER",
        orElse: () => currencies[0],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currencies = ref.watch(currencyListProvider);
    final theme = ref.watch(themeDataProvider);
    final responsive = ref.watch(responsiveProvider);

    return SizedBox(
      height: responsive.h(40),
      child: ListView.separated(
        
        scrollDirection: Axis.horizontal,
        // itemCount: currencies.length + 1,
        itemCount: currencies.length,

        separatorBuilder: (_, __) =>  SizedBox(width: responsive.w(8)),
        itemBuilder: (context, index) {
       

          final currency = currencies[index];
          final isSelected = _selectedCurrency == currency;

        
        return InkWell(
          
            onTap: () {
              setState(() {
                _selectedCurrency = currency;
              });
              widget.onCurrencySelected(currency);
            },
            child: AnimatedContainer(
              
              curve: Curves.easeIn,
              alignment: Alignment.center,
              duration: const Duration(milliseconds: 300),
              padding: responsive.paddingSym(h: 8, v: 4),
              decoration: BoxDecoration(
                color:isSelected ? theme.colorScheme.primary: null,
                shape: BoxShape.rectangle,
                
                borderRadius: BorderRadius.circular(7),
                // border: isSelected ? Border.all(color: theme.colorScheme.secondary, width: 2) : null,
              ),
              foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
              ),
              child: Text(
                currency.name,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.primary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  
}
  

