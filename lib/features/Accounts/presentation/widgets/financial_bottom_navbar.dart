
// نموذج البيانات الافتراضي (يجب استبداله ببياناتك الفعلية من Riverpod)
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



// ودجت لعرض قيمة مالية واحدة
class BalanceItem extends StatelessWidget {
  final String label;
  final double amount;
  final Color color;
  final Color labelColor;
  final bool isBalance;
  final ThemeData theme;

  const BalanceItem({
    super.key,
    required this.label,
    required this.amount,
    required this.color,
    required this.labelColor,
    this.isBalance = false,
    required this.theme,
  });

  @override
   Widget build(BuildContext context) {
    final isNegative = amount < 0;
    final displayAmount = amount.toStringAsFixed(0);
    final textColor = isNegative ? Colors.red.shade700 : color;
    

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Label - use FittedBox so it won't force increased height when textScaleFactor large
        CustomAutoSizeText(
          text: label,
          fontSize: 10 ,
          fontWeight: FontWeight.w500,
          colorText: labelColor,
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 2),
        // Amount - larger, but constrained and fitted
        CustomAutoSizeText(
          text: displayAmount,
          presetFontSizes: isBalance ? [18, 16, 14] : [16, 14, 12],
          fontWeight: isBalance ? FontWeight.w900 : FontWeight.w700,
          colorText: isBalance ? Colors.white : textColor,
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------
// B. THE FINANCIAL BOTTOM NAV BAR
// -----------------------------------------------------------------------

class FinancialBottomNavBar extends ConsumerWidget {
  final double debitBalance;
  final double creditBalance;

  const FinancialBottomNavBar({super.key, required this.debitBalance, required this.creditBalance});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final theme = ref.theme;
    final responsive = ref.responsive;
    final double netBalance = creditBalance - debitBalance;
    debugPrint('netBalance: $netBalance');
    final bottomSafe = MediaQuery.of(context).padding.bottom;
    // choose an explicit logical height (responsive) then add bottom safe area
    final double contentHeight = responsive.h(60); // main bar height
    
    
    // تحديد ألوان الأرصدة
    final creditColor = Colors.green.shade600;
    final debitColor = theme.colorScheme.error;
    final netColor = netBalance >= 0 ? creditColor :theme.colorScheme.error;
    

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container( // Using BottomAppBar for semantic correctness
          height: contentHeight,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerLowest,
            border: Border(
              top: BorderSide(
                color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
                width: 0.5,
              ),
            ),
          ),
          padding: responsive.paddingSym(h: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. الرصيد الصافي (الأهم - تمييزه بخلفية)
              Expanded(
                
                child: _buildNetBalanceView(netBalance, theme, netColor),
              ),
              _buildVerticalDivider(theme),
              // 2. الرصيد الدائن (له)
              Expanded(
                
                child: BalanceItem(
                  label: 'الدائن (سداد)',
                  amount: creditBalance,
                  color: creditColor,
                  theme: theme,
                  labelColor: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              _buildVerticalDivider(theme),
              // 2. الرصيد المدين (عليه)
              Expanded(
                child: BalanceItem(
                  label: 'المدين (دين)',
                  amount: debitBalance,
                  color: debitColor,
                  theme: theme,
                  labelColor: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              
            ],
          ),
        ),
        Container(
            height: bottomSafe,
            width: double.infinity,
            color: Colors.transparent,
          ),
      ],
    );
  }
  Widget _buildNetBalanceView(double netBalanceAbsolute, ThemeData theme, Color netColor) {
    
    return  Container(
              width: double.infinity,
             padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              decoration: BoxDecoration(
                color: netColor, // لون التمييز
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.3),
                    blurRadius: 4,
                  ),
                ]
              ),
              child: BalanceItem(
                label: 'الرصيد',
                amount: netBalanceAbsolute,
                color: netColor, // يتم تجاهل هذا اللون لأن الخلفية هي الأساس
                isBalance: true,
                theme: theme,
                labelColor: Colors.white.withValues(alpha: 0.7),
              ),
            );
  }

  Widget _buildVerticalDivider(ThemeData theme) {
    return Container(
      height: 40,
      width: 1,
      color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
      margin: const EdgeInsets.symmetric(horizontal: 4),
    );
  }
}
