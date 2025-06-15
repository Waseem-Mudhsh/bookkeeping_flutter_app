import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/responsive_notifier.dart';
import '../../../../core/providers/theme_data_provider.dart';
import '../../domain/entities/customer.dart';
import '../widgets/timer_progress_card.dart';

class CustomerListItem extends ConsumerWidget {
  final Customer customer;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CustomerListItem({
    super.key,
    required this.customer,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    final responsive = ref.watch(responsiveProvider);
    return Card(
      color: theme.colorScheme.surface,
      elevation: 3,
      // margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: responsive.paddingOnly(top: 8, bottom: 8, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderRow(responsive,theme),
            if (customer.phone != null) _buildPhoneInfo(ref),
            
            if (customer.taskStartDate != null && customer.taskTotalDays != null)
              TimerProgressCard(
                startDate: customer.taskStartDate!,
                totalDays: customer.taskTotalDays!,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderRow(dynamic responsive,dynamic theme) {
    
    return Row(
      children: [
        Expanded(
          child: ListTile(
              
              contentPadding: responsive.paddingOnly(bottom: 10),
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
             
            ),
        ),
        _buildActionButtons(),
        
      ],
    );
  }

  Widget _buildPhoneInfo( WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    final responsive = ref.watch(responsiveProvider);
    return Padding(
      padding:responsive.paddingOnly(top: 2,),
      child: Text(
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
        'رقم الهاتف : ${customer.phone} ',
        style: theme.textTheme.bodySmall,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.edit, size: 20),
          onPressed: onEdit,
        ),
        IconButton(
          icon: const Icon(Icons.delete, size: 20, color: Colors.red),
          onPressed: onDelete,
        ),
      ],
    );
  }
}