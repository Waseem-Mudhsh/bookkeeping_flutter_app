import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/customer.dart';
import '../../domain/repositories/customer_service.dart';



class CustomerViewModel extends StateNotifier<List<Customer>> {
  final CustomerService _service;
  bool _isAscending = true;
  String _sortColumn = "name";
  int _currentPage = 0;
  int _pageSize = 5; // Pagination size

  CustomerViewModel(this._service) : super(_service.getAllCustomers());

  void addCustomer(Customer customer) {
    _service.addCustomer(customer);
    refresh();
  }

  void deleteCustomer(String id) {
    _service.deleteCustomer(id);
    refresh();
  }

  void updateCustomer(Customer customer) {
    _service.updateCustomer(customer);
    refresh();
  }

  void refresh() {
    state = _service.getAllCustomers();
    paginate(); // Apply pagination after refresh
  }

  void sortBy(String column) {
    _sortColumn = column;
    _isAscending = !_isAscending;

    state.sort((a, b) {
      if (column == "name") {
        return _isAscending ? a.name.compareTo(b.name) : b.name.compareTo(a.name);
      } else if (column == "balance") {
        return _isAscending ? a.balance.compareTo(b.balance) : b.balance.compareTo(a.balance);
      } else {
        return _isAscending ? a.id.compareTo(b.id) : b.id.compareTo(a.id);
      }
    });

    paginate();
  }

  void paginate() {
    final allCustomers = _service.getAllCustomers();
    final startIndex = _currentPage * _pageSize;
    final endIndex = startIndex + _pageSize;
    state = allCustomers.sublist(startIndex, endIndex > allCustomers.length ? allCustomers.length : endIndex);
  }

  void nextPage() {
    final totalPages = (_service.getAllCustomers().length / _pageSize).ceil();
    if (_currentPage < totalPages - 1) {
      _currentPage++;
      paginate();
    }
  }

  void previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      paginate();
    }
  }

  void filterCustomers(String query) {
    final allCustomers = _service.getAllCustomers();
    state = allCustomers
        .where((customer) => customer.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    paginate();
  }
}
