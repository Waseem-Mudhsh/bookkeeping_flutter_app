
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
  final bool isLarge;
  final ThemeData theme;

  const BalanceItem({
    super.key,
    required this.label,
    required this.amount,
    required this.color,
    required this.labelColor,
    this.isLarge = false,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final isNegative = amount < 0;
    final displayAmount = amount.toStringAsFixed(0);
    
    // تحديد لون النص الأساسي للتباين
    final textColor = isNegative ? Colors.red.shade700 : color;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomAutoSizeText(
           text:  label,
           fontSize: 10,
            fontWeight: FontWeight.w500,
            colorText: labelColor,

            style:theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 2),
          CustomAutoSizeText(
           text:  displayAmount,
           presetFontSizes:isLarge ? [16,14, 12] : [14, 12],
          //  fontSize: isLarge ? 14 : 12,
            fontWeight: isLarge ? FontWeight.w900 : FontWeight.w700,
            colorText: isLarge ? Colors.white : textColor,

            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
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
    
    // تحديد ألوان الأرصدة
    final creditColor = Colors.green.shade600;
    final debitColor = theme.colorScheme.error;
    final netColor = netBalance >= 0 ? creditColor :theme.colorScheme.error;
    

    return BottomAppBar(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      color: theme.colorScheme.surfaceContainerLowest, // خلفية فاتحة أو بيضاء
      // shape: const CircularNotchedRectangle(), // إذا كنت تستخدم FloatingActionButton
      child: Container(
        padding: responsive.paddingOnly( top: 8),
        height: 60, // ارتفاع مناسب
        decoration: BoxDecoration(
         
          border: Border(
            top: BorderSide(
              color: theme.colorScheme.outline.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             // 3. الرصيد الصافي (الأهم - تمييزه بخلفية)
           Expanded(child: _buildNetBalanceView(netBalance, theme, netColor)),
             // فاصل عمودي
            // VerticalDivider(indent: 10, endIndent: 10, color: Colors.grey.shade300),
            // 1. الرصيد الدائن (له)
            Expanded(
              child: BalanceItem(
                label: 'الدائن (له)',
                amount: creditBalance,
                color: creditColor,
                theme: theme,
                labelColor: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            
            // فاصل عمودي
            VerticalDivider(indent: 10, endIndent: 10, color: Colors.grey.shade300),

            // 2. الرصيد المدين (عليه)
            Expanded(
              child: BalanceItem(
                label: 'المدين (عليه)',
                amount: debitBalance,
                color: debitColor,
                theme: theme,
                labelColor: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),

          

           
          ],
        ),
      ),
    );
  }
  Widget _buildNetBalanceView(double netBalanceAbsolute, ThemeData theme, Color netColor) {
    debugPrint('_buildNetBalanceView: $netBalanceAbsolute');
    return  Container(
             padding: const EdgeInsets.symmetric(horizontal: 4,),
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
                label: 'الصافي',
                amount: netBalanceAbsolute,
                color: netColor, // يتم تجاهل هذا اللون لأن الخلفية هي الأساس
                isLarge: true,
                theme: theme,
                labelColor: Colors.white.withValues(alpha: 0.7),
              ),
            );
  }
}
