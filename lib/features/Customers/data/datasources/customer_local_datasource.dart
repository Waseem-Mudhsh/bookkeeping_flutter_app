import 'package:hive/hive.dart';
import '../../domain/entities/customer.dart';

class CustomerLocalDataSource {
  final Box<Customer> _customerBox;

  CustomerLocalDataSource(this._customerBox);

  Future<List<Customer>> getAllCustomers() async {
    
    return _customerBox.values.toList();
  }

  Future<void> addCustomer(Customer customer) async {
    await _customerBox.put(customer.id, customer);
  }

  Future<void> updateCustomer(Customer customer) async {
    await _customerBox.put(customer.id, customer);
  }

  Future<void> deleteCustomer(String id) async {
    await _customerBox.delete(id);
  }
}