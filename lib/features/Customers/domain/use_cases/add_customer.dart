import '../repositories/customer_repository.dart';
import '../entities/customer.dart';

class AddCustomer {
  final CustomerRepository repository;

  AddCustomer(this.repository);

  Future<void> execute(Customer customer) async {
    await repository.addCustomer(customer);
  }
}



