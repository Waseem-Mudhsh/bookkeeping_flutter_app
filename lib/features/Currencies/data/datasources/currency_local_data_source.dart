
import '../../domain/entities/currency.dart';
import '../../domain/repositories/currency_repository.dart';


class CurrencyLocalDataSource implements CurrencyRepository {
  final List<Currency> _currencies = [Currency(name: "ريال سعودي", code: "SAR")];

  @override
  List<Currency> getAllCurrencies() => _currencies;

  @override
  void addCurrency(Currency currency) {
    _currencies.add(currency);
  }
}
