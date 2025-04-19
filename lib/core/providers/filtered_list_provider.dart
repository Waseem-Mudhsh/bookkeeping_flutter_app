// // 📁 lib/presentation/providers/search_sort_controller.dart

// import 'package:bookkeeping_flutter_app/core/providers/search_filter_provider.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final filteredListProvider = <T>(
//   List<T> items,
//   String Function(T) getName,
//   int Function(T) getBalance,
// ) {
//   return Provider<List<T>>((ref) {
//     final searchState = ref.watch(searchSortControllerProvider);
//     var filtered = items;

//     if (searchState.query.isNotEmpty) {
//       filtered = filtered.where((item) => getName(item).toLowerCase().contains(searchState.query.toLowerCase())).toList();
//     }

//     filtered.sort((a, b) => searchState.sortAscending
//         ? getBalance(a).compareTo(getBalance(b))
//         : getBalance(b).compareTo(getBalance(a)));

//     return filtered;
//   });
// };

