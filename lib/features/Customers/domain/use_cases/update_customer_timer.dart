import '../repositories/customer_repository.dart';

class UpdateCustomerTimer {
  final CustomerRepository repository;

  UpdateCustomerTimer(this.repository);

  Future<void> execute(
    String id, {
    DateTime? startDate,
    int? totalDays,
  }) async {
    await repository.updateCustomerTimer(id, startDate: startDate, totalDays: totalDays);
  }
}