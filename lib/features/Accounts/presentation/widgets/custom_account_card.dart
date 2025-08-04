import 'package:flutter/material.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import '../../../../core/utils/responsive_values.dart';
import '../../domain/entities/account.dart';

class CustomAccountCard extends StatelessWidget {
  final Account account;
  final Function(Account) onTap;
  final ResponsiveValues responsive;
  final ThemeData theme;

  const CustomAccountCard({
    super.key,
    required this.account,
    required this.onTap,
    required this.responsive,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
              // Account Icon
              _buildAccountIcon(),
              
              const ResponsiveSpace(width: 16),
              
              // Account Details
              Expanded(
                child: _buildAccountDetails(),
              ),
              
              // Balance Information
              _buildBalanceInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountIcon() {
    return InkWell(
      
      child: Container(
        padding: responsive.paddingAll(8),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(responsive.w(8)),
        ),
        child: Icon(
          Icons.add,
          color: theme.colorScheme.primary,
          size: responsive.w(32),
        ),
      ),
    );
  }

  Widget _buildAccountDetails() {
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
          maxLines: 1,
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

  Widget _buildBalanceInfo() {
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