// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../domain/entities/customer.dart';
// import '../../domain/repositories/customer_service.dart';
// import '../view_models/customer_viewmodel.dart';

// final customerProvider = StateNotifierProvider<CustomerViewModel, List<Customer>>((ref) {
//   return CustomerViewModel(CustomerService());
// });

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../data/datasources/customer_local_datasource.dart';
import '../../data/repositories/customer_repository_impl.dart';
import '../../domain/entities/customer.dart';
import '../../domain/use_cases/add_customer.dart';
import '../../domain/use_cases/delete_customer.dart';
import '../../domain/use_cases/get_customers.dart';
import '../../domain/use_cases/update_customer.dart';
import '../view_models/customer_viewmodel.dart';

final customerDataSourceProvider = Provider<CustomerLocalDataSource>((ref) {
  return CustomerLocalDataSource(Hive.box<Customer>('customers'));
});

final customerRepositoryProvider = Provider<CustomerRepositoryImpl>((ref) {
  return CustomerRepositoryImpl(ref.read(customerDataSourceProvider));
});

final getCustomersProvider = Provider<GetCustomers>((ref) {
  return GetCustomers(ref.read(customerRepositoryProvider));
});

final addCustomerProvider = Provider<AddCustomer>((ref) {
  return AddCustomer(ref.read(customerRepositoryProvider));
});

final updateCustomerProvider = Provider<UpdateCustomer>((ref) {
  return UpdateCustomer(ref.read(customerRepositoryProvider));
});

final deleteCustomerProvider = Provider<DeleteCustomer>((ref) {
  return DeleteCustomer(ref.read(customerRepositoryProvider));
});

final customerViewModelProvider = StateNotifierProvider<CustomerViewModel, AsyncValue<List<Customer>>>((ref) {
  return CustomerViewModel(
    getCustomers: ref.read(getCustomersProvider),
    addCustomer: ref.read(addCustomerProvider),
    updateCustomer: ref.read(updateCustomerProvider),
    deleteCustomer: ref.read(deleteCustomerProvider),
  );
});