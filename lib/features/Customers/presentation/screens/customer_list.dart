import 'package:bookkeeping_flutter_app/core/app_scaffold/sliver_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/responsive_notifier.dart';
import '../../domain/entities/customer.dart';
import 'customer_actions.dart';
import 'customer_list_item.dart';

class CustomerList extends ConsumerWidget {
  final List<Customer> customers;
  final CustomerActions actions;

  const CustomerList({super.key, 
    
    required this.customers,
    required this.actions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ref.watch(responsiveProvider);
    return ref.responsiveSliverList(
                      itemCount: customers.length,
                      spacing: responsive.h(8),
                      itemBuilder: (context, index) {
                        final customer = customers[index];
                        
                        return CustomerListItem(
                          customer: customer,
                          onEdit: () => actions.showEditCustomerSheet(customer),
                          onDelete: () => actions.deleteCustomer(customer.id),
                        );
                      },
    );
                    
  }
}