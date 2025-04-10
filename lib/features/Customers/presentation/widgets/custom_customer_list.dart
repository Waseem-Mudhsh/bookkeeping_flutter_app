// import 'package:flutter/material.dart';
import 'package:bookkeeping_flutter_app/features/Customers/presentation/widgets/customer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/customer_provider.dart';

class CustomCustomerList extends ConsumerWidget {
  const CustomCustomerList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   final customers = ref.watch(customerProvider);
    final customerVM = ref.read(customerProvider.notifier);

    if (customers.isEmpty) {
      return const Center(
        child: Text(
          "No customers available.",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    }

    return Column(
      children: [
        ...customers
            .map(
              (customer) => CustomerCard(
                customer: customer,
                onDelete: () {
                  customerVM.deleteCustomer(customer.id);
                },
              ),
            )
            ,
      ]);
  }
}
