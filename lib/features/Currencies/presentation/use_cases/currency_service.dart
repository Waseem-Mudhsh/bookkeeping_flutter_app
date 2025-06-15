

import '../../domain/entities/currency.dart';
import '../../domain/repositories/currency_repository.dart';

class CurrencyService {
  final CurrencyRepository repository;

  CurrencyService(this.repository);

  List<Currency> fetchCurrencies() => repository.getAllCurrencies();

  void addCurrency(Currency currency) {
    if (!_currencyExists(currency.code)) {
      repository.addCurrency(currency);
    }
  }

  bool _currencyExists(String code) {
    return repository.getAllCurrencies().any((c) => c.code == code);
  }
  void updateCurrency(Currency currency){
    repository.updateCurrency(currency);
  }
}
