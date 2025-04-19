import '../entities/customer.dart';
import '../repositories/customer_repository.dart';

class UpdateCustomer {
  final CustomerRepository repository;

  UpdateCustomer(this.repository);

  Future<void> execute(Customer customer) async {
    await repository.updateCustomer(customer);
  }
}