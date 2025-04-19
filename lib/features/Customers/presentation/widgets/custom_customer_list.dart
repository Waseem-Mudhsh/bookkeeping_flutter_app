// import 'package:flutter/material.dart';
import 'package:bookkeeping_flutter_app/features/Customers/presentation/widgets/customer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/responsive_notifier.dart';
import '../../../../core/providers/theme_data_provider.dart';
import '../../domain/entities/customer.dart';
import '../providers/customer_provider.dart';

class CustomCustomerList extends ConsumerWidget {
  const CustomCustomerList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final getCustomers = ref.read(getCustomersProvider);
  
  final responsive = ref.watch(responsiveProvider);
  final theme = ref.watch(themeDataProvider);

  return FutureBuilder<List<Customer>>(
    future: getCustomers.execute(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      if (snapshot.hasError) {
        return Center(
          child: Text(
            "Error loading customers.",
            style: theme.textTheme.bodyLarge,
          ),
        );
      }

      final customers = snapshot.data ?? [];

      if (customers.isEmpty) {
        return Center(
          child: Text(
            "لا يوجد عملاء",
            style: theme.textTheme.bodyLarge,
          ),
        );
      }

      return Column(
        spacing: responsive.h(8),
        children: [
          ...customers.map(
            (customer) => CustomerCard(
              customer: customer,
              onDelete: () {
                // Handle delete
              },
            ),
          ),
        ],
      );
    },
  );
}
}
