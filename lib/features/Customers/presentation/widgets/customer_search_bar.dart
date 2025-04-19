import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/search_filter_provider.dart';
import '../providers/customer_search_provider.dart';


class CustomerSearchBar extends ConsumerWidget {
  const CustomerSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(customerSearchNotifierProvider);
final notifier = ref.read(customerSearchNotifierProvider.notifier);
final sortOrder = searchState.sortOrder;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: notifier.setQuery,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'ابحث عن عميل...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'الترتيب حسب الرصيد',
            icon: Icon(
              sortOrder == SortOrder.ascending
                  ? Icons.arrow_upward
                  : Icons.arrow_downward,
            ),
            onPressed: notifier.toggleSortOrder,
          ),
        ],
      ),
    );
  }
}
