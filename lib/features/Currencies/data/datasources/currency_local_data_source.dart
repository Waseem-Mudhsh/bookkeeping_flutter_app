
import '../../domain/entities/currency.dart';
import '../../domain/repositories/currency_repository.dart';


class CurrencyLocalDataSource implements CurrencyRepository {
  final List<Currency> _currencies = [
    Currency(name: "يمني", code: "ر.ي", flagUrl: 'assets/images/yemen.png', balanceDue: 200000.4),
    Currency(name: "سعودي", code: "ر.س", flagUrl: 'assets/images/sar.png', balanceDue: 2005000.4),
    Currency(name: "دولار", code: "USD", flagUrl: 'assets/images/usa.png', balanceDue: 20000550005512540.4),
    
    
    
    ];

  @override
  List<Currency> getAllCurrencies(){
    return List.unmodifiable(_currencies); // Return an unmodifiable copy of the list
  }

  @override
  void addCurrency(Currency currency) {
    _currencies.add(currency);
  }
  @override
  void updateCurrency(Currency currency){
    int index = _currencies.indexWhere((element) => element.code == currency.code);
    if(index != -1){
      _currencies[index] = currency;
    }
  }
}
