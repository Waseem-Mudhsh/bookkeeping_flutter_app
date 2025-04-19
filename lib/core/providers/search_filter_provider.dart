import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SortOrder { ascending, descending }

class SearchFilterState<T> {
  final String query;
  final SortOrder sortOrder;
  final List<T> filteredList;

  const SearchFilterState({
    required this.query,
    required this.sortOrder,
    required this.filteredList,
  });

  SearchFilterState<T> copyWith({
    String? query,
    SortOrder? sortOrder,
    List<T>? filteredList,
  }) {
    return SearchFilterState<T>(
      query: query ?? this.query,
      sortOrder: sortOrder ?? this.sortOrder,
      filteredList: filteredList ?? this.filteredList,
    );
  }
}

class SearchFilterNotifier<T> extends StateNotifier<SearchFilterState<T>> {
  final List<T> fullList;
  final bool Function(T item, String query) filterFn;
  final int Function(T a, T b, SortOrder order) sortFn;

  SearchFilterNotifier({
    required this.fullList,
    required this.filterFn,
    required this.sortFn,
  }) : super(SearchFilterState(
          query: '',
          sortOrder: SortOrder.descending,
          filteredList: fullList,
        ));

  void setQuery(String newQuery) {
    final filtered = fullList
        .where((item) => filterFn(item, newQuery))
        .toList()
      ..sort((a, b) => sortFn(a, b, state.sortOrder));

    state = state.copyWith(query: newQuery, filteredList: filtered);
  }

  void toggleSortOrder() {
    final newOrder = state.sortOrder == SortOrder.ascending
        ? SortOrder.descending
        : SortOrder.ascending;

    final sorted = [...state.filteredList]
      ..sort((a, b) => sortFn(a, b, newOrder));

    state = state.copyWith(sortOrder: newOrder, filteredList: sorted);
  }
}
