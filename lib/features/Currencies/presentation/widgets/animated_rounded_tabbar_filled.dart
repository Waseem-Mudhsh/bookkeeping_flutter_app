import 'package:flutter/material.dart';

import '../../domain/entities/currency.dart';


class AnimatedRoundedTabbarFilled extends StatelessWidget {
  final double borderRadius;
  final List<Currency> currencies;
  final int selectedIndex;
  final void Function(int index) onTabSelected;
  final VoidCallback onAddCurrency;

  const AnimatedRoundedTabbarFilled({
    super.key,
    required this.currencies,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.onAddCurrency,
    this.borderRadius = 30,
  });

  @override
  Widget build(BuildContext context) {
    final allTabs = [...currencies.map((c) => c.name), '➕ إضافة'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        allTabs.length,
        (index) {
          final isSelected = selectedIndex == index;
          return InkWell(
            onTap: () {
              if (index == allTabs.length - 1) {
                onAddCurrency();
              } else {
                onTabSelected(index);
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF00BAAB) : Colors.transparent,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Text(
                allTabs[index],
                style: TextStyle(
                  fontSize: 16,
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
