import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/customer.dart';
import '../../domain/repositories/customer_service.dart';
import 'customer_viewmodel.dart';

final customerProvider = StateNotifierProvider<CustomerViewModel, List<Customer>>((ref) {
  return CustomerViewModel(CustomerService());
});