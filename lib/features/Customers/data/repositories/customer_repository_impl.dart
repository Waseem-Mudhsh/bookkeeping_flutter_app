import '../datasources/customer_local_datasource.dart';
import '../../domain/entities/customer.dart';
import '../../domain/repositories/customer_repository.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerLocalDataSource localDataSource;

  CustomerRepositoryImpl(this.localDataSource);

  @override
  Future<List<Customer>> getCustomers() async {
    return localDataSource.getAllCustomers();
  }

  @override
  Future<void> addCustomer(Customer customer) async {
    await localDataSource.addCustomer(customer);
  }

  @override
  Future<void> updateCustomer(Customer customer) async {
    await localDataSource.updateCustomer(customer);
  }

  @override
  Future<void> deleteCustomer(String id) async {
    await localDataSource.deleteCustomer(id);
  }

  @override
  Future<void> updateCustomerTimer(
    String id, {
    DateTime? startDate,
    int? totalDays,
  }) async {
    final customers = await localDataSource.getAllCustomers();
    final customer = customers.firstWhere((c) => c.id == id);
    await localDataSource.updateCustomer(
      customer.copyWith(
        taskStartDate: startDate,
        taskTotalDays: totalDays,
      ),
    );
  }
}