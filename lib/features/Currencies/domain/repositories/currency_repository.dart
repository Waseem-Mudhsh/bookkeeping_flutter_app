import '../entities/currency.dart';

abstract class CurrencyRepository {
  List<Currency> getAllCurrencies();
  void addCurrency(Currency currency);
  void updateCurrency(Currency currency);
  void deleteCurrency(Currency currency);
}
