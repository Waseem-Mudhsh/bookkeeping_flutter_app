//
// File: lib/presentation/account/widgets/account_actions_row.dart
//
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';


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
          icon: HugeIcons.strokeRoundedCall02, // اتصال
          label: 'اتصال',
          onPressed: () => debugPrint('Call'),
          isCompact: isCompact,
        ),
        _buildActionButton(
          context: context,
          responsive: responsive,
          theme: theme,
          icon: HugeIcons.strokeRoundedMessage01, // فاتورة
          label: 'رسالة',
          onPressed: () => debugPrint('message'),
          isCompact: isCompact,
        ),
        _buildActionButton(
          context: context,
          responsive: responsive,
          theme: theme,
          icon:HugeIcons.strokeRoundedPdf01, // تقرير
          label: 'تقرير',
          onPressed: () => debugPrint('Report'),
          isCompact: isCompact,
        ),
        _buildActionButton(
          context: context,
          responsive: responsive,
          theme: theme,
          icon: HugeIcons.strokeRoundedAlarmClock, // تنبيهات
          label: 'منبه',
          onPressed: () => debugPrint('Alarm'),
          isCompact: isCompact,
        ),
        _buildActionButton(
          context: context,
          responsive: responsive,
          theme: theme,
          icon:HugeIcons.strokeRoundedRefresh, // تحديث
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
              color: theme.colorScheme.primary.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(responsive.w(12)),
          
              border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.6),width: 0.5),
            ),
            child: CustomHugeIcon(icon: icon, size:20, color:theme.colorScheme.primary),),
        ),
        if (isCompact) ...{
          ResponsiveSpace(height: responsive.h(6)),
          CustomAutoSizeText(
           text:  label,
            style: theme.textTheme.bodyMedium,
            colorText: theme.colorScheme.primary,
            fontSize: 10,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w500,
          ),
        }
      ],
    );
  }
}