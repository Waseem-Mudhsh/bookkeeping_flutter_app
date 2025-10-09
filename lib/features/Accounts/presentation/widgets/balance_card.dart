import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_icon_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/utils/responsive_values.dart';

class BalanceCard extends ConsumerStatefulWidget {
  
  final Color? gradientColor1;
  final Color? gradientColor2;
  final  double remainingBalance;
  final double ceilingAmount;
   // 
  const BalanceCard({super.key, this.gradientColor1, this.gradientColor2,required this.ceilingAmount,required this.remainingBalance});
  @override
  ConsumerState<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends ConsumerState<BalanceCard> {
  bool _obscureText = true; // Default to obscured for security
  final String _currencyCode ='ريال';

  @override
  Widget build(BuildContext context) {
    final theme = ref.theme;
    final responsive = ref.responsive;

    
    // Calculate the normalized progress value (0.0 to 1.0)
    final progressValue = (widget.remainingBalance / widget.ceilingAmount).clamp(0.0, 1.0);
    final isOverCeiling = widget.remainingBalance > widget.ceilingAmount;
    final progressColor =
        isOverCeiling
            ? theme.colorScheme.error
            : theme.colorScheme.onPrimary.withValues(alpha: 0.8);
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Card(
          elevation: 2,
          
          child: Container(
            decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
               widget.gradientColor1 ?? theme.colorScheme.primary,
                widget.gradientColor2 ?? theme.colorScheme.primary.withValues(alpha: 0.8),
              ],
            
            ),
           
          ),
           padding: responsive.paddingSym(h: 12, v: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildBalanceValueView(theme, responsive),
               
               ResponsiveSpace(height:12,),
               
               
                _buildBalanceOverviewSection(theme, responsive),
                ResponsiveSpace(height: 12,),
                _buildLinearProgressIndicator(ref,
                 progressValue, isOverCeiling, widget.ceilingAmount, progressColor)
              
                
              ],
            ),
          ),
        ),
        
         Positioned(
              left: -30,
              child: ResponsiveSpace(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  strokeWidth: 0.7,
                  value:1,
                  color: theme.colorScheme.onPrimary.withValues(alpha: 0.2),
                  
                ),
              ),
            ),
            Positioned(
              right:-30,
              child: ResponsiveSpace(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  
                  strokeCap: StrokeCap.round,
                  strokeWidth: 0.7,
                  value: 1,
                  color: theme.colorScheme.onPrimary.withValues(alpha: 0.2),
                ),
              ),
            ),
        
      ],
    );
  }
  Widget _buildBalanceValueView(ThemeData theme, ResponsiveValues responsive) {
    return Row(
      mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomAutoSizeText(
                      text: 'الرصيد المتبقي',
                      style: theme.textTheme.bodyMedium,
                      fontSize: 10,
                      colorText: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    ResponsiveSpace(width: 16),
                    Flexible(
                      fit: FlexFit.loose,
                      child: _buildBalanceDisplay(theme, responsive)),
                    ResponsiveSpace(width: 12),
                    CustomIconButton(
                      hugeIcon: HugeIcon(
                        icon: _obscureText
                            ? HugeIcons.strokeRoundedEye
                            : HugeIcons.strokeRoundedViewOffSlash,
                        size: 20,
                        color: theme.colorScheme.onPrimary,
                      ),
                      // لون الأيقونة من primary,
                     
                      onPressed: _toggleBalanceVisibility,
                      tooltip: _obscureText ? 'إظهار الرصيد' : 'إخفاء الرصيد',
                    ),
                  ],
                );
  }

  Widget _buildBalanceDisplay(ThemeData theme, ResponsiveValues responsive) {
    return Container(
      padding: responsive.paddingSym(h: 8, v: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary.withValues(alpha: 0.06), // خلفية شبه شفافة
        borderRadius: BorderRadius.circular(responsive.w(12)),
      ),
      child: Center(
        child: Row(
             mainAxisSize: MainAxisSize.min,
           
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: CustomAutoSizeText(
                    text: _obscureText ? '••••••' :  widget.remainingBalance.toStringAsFixed(2),
                    fontWeight: FontWeight.bold,
                    colorText: theme.colorScheme.onPrimary,
                    fontSize: 14,
            
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
                const ResponsiveSpace(width: 8),
                CustomAutoSizeText(
                  text:_currencyCode,
                  colorText: theme.colorScheme.onPrimary.withValues(alpha: 0.7,),
                  fontSize: 12,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
      ),
    );
  }
  Widget _buildBalanceOverviewSection(ThemeData theme, ResponsiveValues responsive) {
    // استخدم بياناتك الفعلية هنا
    final double debtorBalance = 1500.00; // مثال: الرصيد المدين
    final double creditorBalance = 500000000000.00; // مثال: الرصيد الدائن

    return IntrinsicHeight(
      child: Row(
        children: [
          
          Expanded(
            child: _buildBalanceBox(
              label: 'لك',
              value: debtorBalance,
              theme: theme,
              responsive: responsive,
              isDebtor: false,
            ),
          ),
          ResponsiveSpace(width:2),
          VerticalDivider(
            thickness: 1.0, // سمك أكبر للفاصل
            color: theme.colorScheme.onPrimary.withValues(alpha: 0.3), // لون الفاصل
          ),
          
          ResponsiveSpace(width:2),
          Expanded(
            child: _buildBalanceBox(
              label: 'عليك',
              value: creditorBalance,
              theme: theme,
              responsive: responsive,
              isDebtor: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceBox({
    required String label,
    required double value,
    required ThemeData theme,
    required ResponsiveValues responsive,
    required bool isDebtor,
  }) {
    Color balanceColor = isDebtor ? Colors.redAccent.shade200 : Colors.greenAccent.shade200; // ألوان مميزة
    IconData icon = isDebtor ? HugeIcons.strokeRoundedSquareArrowDownRight : HugeIcons.strokeRoundedSquareArrowUpRight; // أيقونات توضيحية

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomHugeIcon(
              icon: icon,
              color: balanceColor,
              size:16,
            ),
            ResponsiveSpace(width:8),
            CustomAutoSizeText(
              text: label,
              style: theme.textTheme.bodyMedium,
                colorText: theme.colorScheme.onPrimary.withValues(alpha: 0.9),
                fontWeight: FontWeight.w600,
                fontSize: 10  ,
              
            ),
          ],
        ),
       
        CustomAutoSizeText(
          text: _obscureText ? '••••••' : value.toString(),
          fontWeight: FontWeight.bold,
          colorText: _obscureText ?theme.colorScheme.onPrimary.withValues(alpha: 0.9) : theme.colorScheme.onPrimary,
          style: theme.textTheme.bodyMedium,
          fontSize: 12,
        ),
      ],
    );
  }
  void _toggleBalanceVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget _buildLinearProgressIndicator(
    WidgetRef ref,
    double progressValue,
    bool isOverCeiling,
    double ceilingAmount,
    Color progressColor,
  ) {
    final theme = ref.theme;
    
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(

                    value: progressValue, // Value between 0.0 and 1.0
                    borderRadius: BorderRadius.circular(12),
                    minHeight: 8, // Thicker bar for better visibility
                    backgroundColor: theme.colorScheme.onPrimary.withValues(alpha: 0.1),
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
                  colorText: theme.colorScheme.onPrimary,
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

}
