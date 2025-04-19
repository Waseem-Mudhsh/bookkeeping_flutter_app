import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/search_filter_provider.dart';
import '../../domain/entities/customer.dart';

final customerSearchNotifierProvider =
    StateNotifierProvider<SearchFilterNotifier<Customer>, SearchFilterState<Customer>>(
  (ref) => SearchFilterNotifier<Customer>(
    fullList: [], // سيتم التحديث لاحقًا بعد تحميل العملاء من مزود async
    filterFn: (customer, query) => customer.name.contains(query),
    sortFn: (a, b, order) =>
        order == SortOrder.ascending ? a.balance.compareTo(b.balance) : b.balance.compareTo(a.balance),
  ),
);
