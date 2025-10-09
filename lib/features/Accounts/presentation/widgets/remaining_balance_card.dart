
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/widgets/custom_icon_button.dart';

final obscureTextProvider = StateProvider<bool>((ref) => true);

class RemainingBalanceCard extends ConsumerWidget {
  final double remainingBalance;
  final double ceilingAmount;

  const RemainingBalanceCard({
    super.key,
    required this.remainingBalance,
    required this.ceilingAmount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceText = remainingBalance.toStringAsFixed(0);
    final theme = ref.theme;
    final responsive = ref.responsive;

    

    // Determine the progress and color based on the ceiling

    // Determine the progress and color based on the ceiling
    final isOverCeiling = remainingBalance > ceilingAmount;
    final progressColor =
        isOverCeiling
            ? theme.colorScheme.error
            : theme.colorScheme.secondary; // Red for Exceeded, Green for Within

    // Calculate the normalized progress value (0.0 to 1.0)
    // If over ceiling, we clamp it at 1.0 for the indicator to show full
    // but visually, the 'Exceeded' status will handle the alert.
    final progressValue = (remainingBalance / ceilingAmount).clamp(0.0, 1.0);

    return Card(
      elevation: 2,
      
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.primary,
                theme.colorScheme.primary.withValues(alpha: 0.8),
              ],
            
            ),
           
          ),
        child: Padding(
          padding: responsive.paddingSym(h: 16, v: 16),
          child: Column(
             mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              _buildShowBalance(ref, balanceText, progressColor),
              ResponsiveSpace(height: 12),
              _buildBalanceDisplay(ref),
              ResponsiveSpace(height: 16),
              // ✅ LINEAR PROGRESS INDICATOR IMPLEMENTATION
              _buildLinearProgressIndicator(ref, progressValue, isOverCeiling, progressColor),
             
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLinearProgressIndicator(
    WidgetRef ref,
    double progressValue,
    bool isOverCeiling,
    Color progressColor,
  ) {
    final theme = ref.theme;
    
    return  Column(
      children: [
        ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progressValue, // Value between 0.0 and 1.0
                    minHeight: 8, // Thicker bar for better visibility
                    backgroundColor: theme.colorScheme.surfaceContainerHigh,
                    valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                  ),
                ),
      

            ResponsiveSpace(height: 8),

            // Ceiling amount display (e.g., 1000 YER, as seen in the image)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomAutoSizeText(
                  text:
                      'سقف الحساب: ${ceilingAmount.toStringAsFixed(0)} ريال', // Assuming YER is the currency
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  colorText: theme.colorScheme.onSurface,
                ),
                CustomAutoSizeText(
                  text:
                      !isOverCeiling
                          ? 'ضمن السقف'
                          : progressValue >= 0.8 && !isOverCeiling
                          ? 'وصول إلى السقف'
                          : 'تجاوز السقف', // Assuming YER is the currency
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  colorText: progressColor,
                ),
              ],
            )
            ],
    );
            
  }

  Widget _buildShowBalance(
    WidgetRef ref,
    String balanceText,
    Color progressColor,
  ) {
    final theme = ref.theme;
   

    return Consumer(
      builder: (context, ref, child) {
        
        final obscureText = ref.watch(obscureTextProvider);
      

     return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
              
          //     CircleAvatar(
          //       radius: 12,
          //       backgroundColor: theme.colorScheme.primary,
          //       child: CustomHugeIcon(
          //         icon: HugeIcons.strokeRoundedDollar01,
          //         size: 12,
          //         color: theme.colorScheme.onPrimary,
          //       ),
          //     ),
          //     const ResponsiveSpace(width: 8),
          //     CustomAutoSizeText(
          //       text: ' الرصيد الحالي',
          //       style: theme.textTheme.bodyMedium,
          //       fontSize: 10,
          //       fontWeight: FontWeight.w600,
          //       colorText: theme.colorScheme.onSurfaceVariant,
          //     ),
          //   ],
          // ),
          // ResponsiveSpace(height: 4),
          // Modern Typography: Large, prominent balance
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomAutoSizeText(
                text: obscureText ? '••••••' : balanceText ,
                fontSize: 18,
                fontWeight: FontWeight.w900,
                colorText: progressColor, // Color reflects status
              ),
              ResponsiveSpace(width: 4),
              CustomAutoSizeText(
                text:  obscureText ? '' : ' ريال',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                colorText: theme.colorScheme.onSurfaceVariant,
              ),
              ResponsiveSpace(width: 8),
              CustomIconButton(
                        hugeIcon: HugeIcon(
                          icon: obscureText
                              ? HugeIcons.strokeRoundedViewOffSlash
                              : HugeIcons.strokeRoundedEye,
                          size: 20,
                          color: theme.colorScheme.primary,
                        ),
                        onPressed: () => ref.read(obscureTextProvider.notifier).state = !obscureText,
                      ),
            ],
          ),
        ],
      );
      }
    );
  }
  Widget _buildBalanceDisplay(WidgetRef ref) {
    final theme = ref.theme;
    return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: _buildBalanceBox(ref, 2500, true)),
                VerticalDivider(
            thickness: 1.0, // سمك أكبر للفاصل
            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.2), // لون الفاصل
                      ),
                Expanded(child: _buildBalanceBox(ref, 500000000000, false)),
              ],
            ),
          );
    
  }

  Widget _buildBalanceBox(WidgetRef ref, double value, bool isDebtor) {
    final theme = ref.theme;
    final colorValue =
        isDebtor ? theme.colorScheme.error : Colors.green.shade600;
    final label = isDebtor ? 'دين' : 'سداد';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: [
        CustomAutoSizeText(
          text: '$label: ',
          fontSize: 10,
          fontWeight: FontWeight.w400,
          colorText: theme.colorScheme.onSurfaceVariant,
        ),
        const ResponsiveSpace(width: 4),
        CustomAutoSizeText(
          text: '${value.toStringAsFixed(2)} ريال',
          fontSize: 12,
          style: theme.textTheme.bodyMedium,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w600,
          colorText: colorValue,
        ),
      ],
    );
  }

  // Helper widget remains the same
  
}
