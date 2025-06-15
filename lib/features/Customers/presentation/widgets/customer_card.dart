import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:bookkeeping_flutter_app/features/Customers/presentation/widgets/timer_progress_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/responsive_notifier.dart';
import '../../../../core/providers/theme_data_provider.dart';
import '../../domain/entities/customer.dart';
import '../providers/customer_provider.dart';
import '../screens/add_customer_sheet.dart';

class CustomerCard extends ConsumerWidget {
  final Customer customer;
  final VoidCallback onDelete;

  const CustomerCard({
    super.key,
    required this.customer,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ref.watch(responsiveProvider);
    final theme = ref.watch(themeDataProvider);
    return Card(
      color: theme.colorScheme.surface,
      // margin: responsive.paddingSym(h: 16, v: 8),
      elevation: 3,
      child: Padding(
        padding: responsive.paddingOnly(top: 8, bottom: 8, left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: responsive.paddingOnly(bottom: 8),
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primary,
                child: Text(
                  customer.name[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: responsive.sp(14),
                    color: theme.colorScheme.onPrimary,
                    fontFamily: "Cairo",
                  ),
                ),
              ),
              title: Text(
                customer.name,
                style: theme.textTheme.bodyLarge,
                softWrap: true,
              ),
              subtitle: Text(
                "له: ${customer.balance} \$",
                style: theme.textTheme.bodyMedium,
              ),
              trailing: IconButton(
                onPressed: () {
                  ref.read(customerViewModelProvider.notifier).deleteCustomer(customer.id);
                },
                icon: Icon(Icons.delete),
                color: theme.colorScheme.error,
              ),
            ),
            ResponsiveSpace(height: 8),
            TimerProgressCard(
              startDate: DateTime(2025, 04, 11), // When task started
              totalDays: 5, // Must complete within 5 days
            ),
            const Divider(),

            SizedBox(
              
            ),
            Padding(
              padding: responsive.paddingSym(h: 8, v: 8),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: responsive.w(24),
                    tooltip: 'Add',
                    icon: Icon(Icons.add, color: theme.colorScheme.primary),
                    onPressed:
                        () => showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => const AddCustomerSheet(),
                        ),
                  ),
                  IconButton(
                    tooltip: 'Edit',
                    icon: Icon(Icons.edit, color: theme.colorScheme.primary),
                    onPressed: () {
                      // Handle edit action here
                    },
                  ),

                  IconButton(
                    tooltip: 'Timer',
                    icon: Icon(Icons.timer, color: theme.colorScheme.primary),
                    onPressed: () {
                      // Handle edit action here
                    },
                  ),
                  IconButton(
                    tooltip: 'Delete',
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: onDelete,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
