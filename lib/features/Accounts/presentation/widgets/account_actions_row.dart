//
// File: lib/presentation/account/widgets/account_actions_row.dart
//
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/responsive_notifier.dart';
import '../../../../core/providers/theme_data_provider.dart';
import '../../../../core/utils/responsive_values.dart';
import '../../../../core/widgets/responsive_space.dart';
import '../../domain/entities/account.dart';

// This widget is responsible for the horizontal row of action icons (تصميم مضغوط).
class AccountActionsRow extends ConsumerWidget {
  final Account account;
  final bool isCompact; // علامة لتحديد ما إذا كان التصميم مضغوطًا

  const AccountActionsRow({super.key, required this.account, this.isCompact = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ref.watch(responsiveProvider);
    final theme = ref.watch(themeDataProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionButton(
          context: context,
          responsive: responsive,
          theme: theme,
          icon: Icons.swap_horiz, // تحويل
          label: 'تحويل',
          onPressed: () => debugPrint('Transfer'),
          isCompact: isCompact,
        ),
        _buildActionButton(
          context: context,
          responsive: responsive,
          theme: theme,
          icon: Icons.receipt_outlined, // فاتورة
          label: 'فاتورة',
          onPressed: () => debugPrint('Bill'),
          isCompact: isCompact,
        ),
        _buildActionButton(
          context: context,
          responsive: responsive,
          theme: theme,
          icon: Icons.arrow_downward, // طلب (سحب)
          label: 'طلب',
          onPressed: () => debugPrint('Request'),
          isCompact: isCompact,
        ),
        _buildActionButton(
          context: context,
          responsive: responsive,
          theme: theme,
          icon: Icons.history, // تاريخ
          label: 'تاريخ',
          onPressed: () => debugPrint('History'),
          isCompact: isCompact,
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required ResponsiveValues responsive,
    required ThemeData theme,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool isCompact = false,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(responsive.w(12)),
      child: Padding(
        padding: responsive.paddingSym(h: 12, v: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: responsive.w(28), color: theme.colorScheme.onPrimary),
            if (isCompact) ...{
              ResponsiveSpace(height: responsive.h(4)),
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onPrimary.withValues(alpha: 0.8),
                ),
              ),
            }
          ],
        ),
      ),
    );
  }
}