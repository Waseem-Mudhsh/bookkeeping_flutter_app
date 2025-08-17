import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/responsive_values.dart';
import '../../domain/entities/account.dart';

class CustomAccountCard extends ConsumerWidget {
  final Account account;
  final Function(Account) onTap;
  final ResponsiveValues responsive;
  

  const CustomAccountCard({
    super.key,
    required this.account,
    required this.onTap,
    required this.responsive,
   
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    return Card(
      color: theme.colorScheme.surface,
      elevation: 2,
      margin: responsive.paddingOnly(bottom: responsive.h(12)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(responsive.w(10))),
      child: InkWell(
        borderRadius: BorderRadius.circular(responsive.w(10)),
        onTap: () => onTap(account),
        child: Padding(
          padding: responsive.paddingAll(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             
              
              const ResponsiveSpace(width: 8),
              
              // Account Details
              Expanded(
                child: _buildAccountDetails(theme),
              ),
              
              // Balance Information
              _buildBalanceInfo(theme),
            ],
          ),
        ),
      ),
    );
  }

 

  Widget _buildAccountDetails( ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomAutoSizeText(
          text: account.name,
          fontWeight: FontWeight.bold,
          colorText: theme.colorScheme.onSurface,
          style: theme.textTheme.bodyMedium,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          fontSize: 12,
        ),
        ResponsiveSpace(height: 4),
        CustomAutoSizeText(
          text: account.category.toString().split('.').last, // Convert enum to string
          colorText:theme.colorScheme.onSurface.withValues(alpha: 0.6) ,
          fontSize: 12,
        ),
      ],
    );
  }

  Widget _buildBalanceInfo( ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomAutoSizeText(
          text: account.totalAccountBalance.toStringAsFixed(2),
          fontWeight: FontWeight.bold,
          colorText: account.totalAccountBalance >= 0 
              ? Colors.green.shade600 
              : Colors.red.shade600,
          style: theme.textTheme.bodyMedium
        ),
        ResponsiveSpace(height: 4),
        if (account.currencyCode != null)
          CustomAutoSizeText(
            text: account.currencyCode!,
            colorText: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            fontSize: 12,
          ),
      ],
    );
  }
}