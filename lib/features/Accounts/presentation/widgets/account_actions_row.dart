//
// File: lib/presentation/account/widgets/account_actions_row.dart
//
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
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
    final responsive = ref.responsive;
    final theme = ref.theme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
         
        _buildActionButton(
          context: context,
          responsive: responsive,
          theme: theme,
          icon: Icons.call_outlined, // اتصال
          label: 'اتصال',
          onPressed: () => debugPrint('Call'),
          isCompact: isCompact,
        ),
        _buildActionButton(
          context: context,
          responsive: responsive,
          theme: theme,
          icon: Icons.message_outlined, // فاتورة
          label: 'رسالة',
          onPressed: () => debugPrint('message'),
          isCompact: isCompact,
        ),
        _buildActionButton(
          context: context,
          responsive: responsive,
          theme: theme,
          icon: Icons.picture_as_pdf_outlined, // تقرير
          label: 'تقرير',
          onPressed: () => debugPrint('Report'),
          isCompact: isCompact,
        ),
        _buildActionButton(
          context: context,
          responsive: responsive,
          theme: theme,
          icon: Icons.alarm, // تنبيهات
          label: 'منبه',
          onPressed: () => debugPrint('Alarm'),
          isCompact: isCompact,
        ),
        _buildActionButton(
          context: context,
          responsive: responsive,
          theme: theme,
          icon: Icons.refresh_outlined, // تحديث
          label: 'تحديث',
          onPressed: () => debugPrint('Settings'),
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(responsive.w(12)),
          onTap: onPressed,
          child: Container(
            padding: responsive.paddingAll(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.01),
              borderRadius: BorderRadius.circular(responsive.w(12)),
              border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.1),width: 0.5),
            ),
            child: Icon(icon, size: responsive.w(24), color:theme.colorScheme.primary),),
        ),
        if (isCompact) ...{
          ResponsiveSpace(height: responsive.h(6)),
          CustomAutoSizeText(
           text:  label,
            style: theme.textTheme.bodyMedium,
            colorText: theme.colorScheme.primary,
            fontSize: 10,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w700,
          ),
        }
      ],
    );
  }
}