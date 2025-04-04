import 'package:hive/hive.dart';
import '../entities/customer.dart';

class CustomerService {
  final Box<Customer> _customerBox = Hive.box<Customer>('customers');

  List<Customer> getAllCustomers() {
    return _customerBox.values.toList();
  }

  void addCustomer(Customer customer) {
    _customerBox.put(customer.id, customer);
  }

  void deleteCustomer(String id) {
    _customerBox.delete(id);
  }
  void updateCustomer(Customer customer) {
    _customerBox.put(customer.id, customer);
  }
}

