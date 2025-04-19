import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/currency_local_data_source.dart';
import '../../domain/entities/currency.dart';
import '../use_cases/currency_service.dart';

final _repositoryProvider = Provider((ref) => CurrencyLocalDataSource());

final currencyServiceProvider = Provider((ref) {
  final repo = ref.watch(_repositoryProvider);
  return CurrencyService(repo);
});

final currencyListProvider = StateNotifierProvider<CurrencyNotifier, List<Currency>>((ref) {
  final service = ref.watch(currencyServiceProvider);
  return CurrencyNotifier(service);
});

class CurrencyNotifier extends StateNotifier<List<Currency>> {
  final CurrencyService _service;

  CurrencyNotifier(this._service) : super(_service.fetchCurrencies());

  void addCurrency(Currency currency) {
    _service.addCurrency(currency);
    state = _service.fetchCurrencies();
  }
}
