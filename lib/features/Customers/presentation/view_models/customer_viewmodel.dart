// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../domain/entities/customer.dart';
// import '../../domain/repositories/customer_service.dart';



// class CustomerViewModel extends StateNotifier<List<Customer>> {
//   final CustomerService _service;
//   bool _isAscending = true;
//   int _currentPage = 0;
//   final int _pageSize = 5; // Pagination size

//   CustomerViewModel(this._service) : super(_service.getAllCustomers());

//   void addCustomer(Customer customer) {
//     _service.addCustomer(customer);
//     refresh();
//   }

//   void deleteCustomer(String id) {
//     _service.deleteCustomer(id);
//     refresh();
//   }

//   void updateCustomer(Customer customer) {
//     _service.updateCustomer(customer);
//     refresh();
//   }

//   void refresh() {
//     state = _service.getAllCustomers();
//     // paginate(); // Apply pagination after refresh
//   }

//   void sortBy(String column) {
//     _isAscending = !_isAscending;

//     state.sort((a, b) {
//       if (column == "name") {
//         return _isAscending ? a.name.compareTo(b.name) : b.name.compareTo(a.name);
//       } else if (column == "balance") {
//         return _isAscending ? a.balance.compareTo(b.balance) : b.balance.compareTo(a.balance);
//       } else {
//         return _isAscending ? a.id.compareTo(b.id) : b.id.compareTo(a.id);
//       }
//     });

//     // paginate();
//   }

//   void paginate() {
//     final allCustomers = _service.getAllCustomers();
//     final startIndex = _currentPage * _pageSize;
//     final endIndex = startIndex + _pageSize;
//     state = allCustomers.sublist(startIndex, endIndex > allCustomers.length ? allCustomers.length : endIndex);
//   }

//   void nextPage() {
//     final totalPages = (_service.getAllCustomers().length / _pageSize).ceil();
//     if (_currentPage < totalPages - 1) {
//       _currentPage++;
//       // paginate();
//     }
//   }

//   void previousPage() {
//     if (_currentPage > 0) {
//       _currentPage--;
//       // paginate();
//     }
//   }

//   void filterCustomers(String query) {
//     final allCustomers = _service.getAllCustomers();
//     state = allCustomers
//         .where((customer) => customer.name.toLowerCase().contains(query.toLowerCase()))
//         .toList();
//     // paginate();
//   }
// }



import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/customer.dart';
import '../../domain/use_cases/get_customers.dart';
import '../../domain/use_cases/add_customer.dart';
import '../../domain/use_cases/update_customer.dart';
import '../../domain/use_cases/delete_customer.dart';

class CustomerViewModel extends StateNotifier<AsyncValue<List<Customer>>> {
  final GetCustomers _getCustomers;
  final AddCustomer _addCustomer;
  final UpdateCustomer _updateCustomer;
  final DeleteCustomer _deleteCustomer;

  CustomerViewModel({
    required GetCustomers getCustomers,
    required AddCustomer addCustomer,
    required UpdateCustomer updateCustomer,
    required DeleteCustomer deleteCustomer,
  })  : _getCustomers = getCustomers,
        _addCustomer = addCustomer,
        _updateCustomer = updateCustomer,
        _deleteCustomer = deleteCustomer,
        super(const AsyncValue.loading()) {
    loadCustomers();
  }

  Future<void> loadCustomers() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _getCustomers.execute();
    });
  }

  Future<void> addCustomer(Customer customer) async {
    await _addCustomer.execute(customer);
    await loadCustomers();
  }

  Future<void> updateCustomer(Customer customer) async {
    await _updateCustomer.execute(customer);
    await loadCustomers();
  }

  Future<void> deleteCustomer(String id) async {
    await _deleteCustomer.execute(id);
    await loadCustomers();
  }

  Future<void> updateCustomerTask(
    String id, {
    DateTime? startDate,
    int? totalDays,
  }) async {
    final customers = state.value;
    if (customers != null) {
      final customer = customers.firstWhere((c) => c.id == id);
      await _updateCustomer.execute(
        customer.copyWith(
          taskStartDate: startDate,
          taskTotalDays: totalDays,
        ),
      );
      await loadCustomers();
    }
  }
}