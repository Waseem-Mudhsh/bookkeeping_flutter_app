import '../entities/currency.dart';

abstract class CurrencyRepository {
  List<Currency> getAllCurrencies();
  void addCurrency(Currency currency);
}
