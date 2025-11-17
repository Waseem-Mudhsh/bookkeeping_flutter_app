import 'package:bookkeeping_flutter_app/core/utils/responsive_values.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';

class DualBalanceCard extends StatelessWidget {
  // تم تغيير المدخلات لعرض الرصيدين بشكل منفصل
  final double clientCreditBalance; // الرصيد له (المفروض أن يدفعه العميل)
  final double clientDebitBalance;  // الرصيد عليه (المفروض أن يدفعه التاجر/الشركة)
  final double? ceilingAmount;
  final ThemeData theme;
  final ResponsiveValues responsive;
  final String? currencySymbol;
  final String? currencyFlagAsset;

  const DualBalanceCard({super.key, 
    required this.clientCreditBalance,
    required this.clientDebitBalance,
     this.ceilingAmount,
    required this.theme,
    required this.responsive,
    this.currencySymbol,
    this.currencyFlagAsset,
  });
  

  // تحديد الرصيد النهائي واللون
  double get netBalance => clientCreditBalance - clientDebitBalance;
  bool get isClientInDebt => netBalance < 0;

  @override
  Widget build(BuildContext context) {
    final netBalanceAbsolute = netBalance.abs().toStringAsFixed(0);
    
    // الألوان بناءً على الحالة (الأخضر للربح/له، الأحمر للدين/عليه)
    final debitColor = theme.colorScheme.error; // أحمر للديون/عليه
    final creditColor = theme.colorScheme.primary; // أخضر للأرباح/له
    
    // مؤشر التقدم سيكون بناءً على الحد الأقصى للدين (الرصيد عليه)
    final debtPercentage = ceilingAmount != null ? (clientDebitBalance / ceilingAmount!).clamp(0.0, 1.0):0.0;
    final progressBarColor = clientDebitBalance > (ceilingAmount ?? 0) ? debitColor : creditColor;

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: responsive.paddingAll(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            // السطر 1: عرض رصيد "له" ورصيد "عليه" بشكل متساوٍ
            _buildBalanceValueView(creditColor, debitColor),
            
            const ResponsiveSpace(height: 12.0),
            
             // إضافة شرط لعرض مؤشر التقدم فقط إذا كان ceilingAmount موجوداً
            if (ceilingAmount != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: debtPercentage, // Value between 0.0 and 1.0
                  minHeight: 6.0, // Thicker bar for better visibility
                  backgroundColor: theme.colorScheme.surfaceContainerHigh,
                  valueColor: AlwaysStoppedAnimation<Color>(progressBarColor),
                ),
              ),
              ResponsiveSpace(height: 8),
            ],

            _buildNetBalanceView(netBalanceAbsolute, isClientInDebt, creditColor, debitColor),
          ],
        ),
      ),
    );
  }

  Widget _buildNetBalanceView(String netBalanceAbsolute, bool isClientInDebt, Color creditColor, Color debitColor) {
    return  Row(
              mainAxisSize: MainAxisSize.min,

              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // الرصيد الصافي النهائي
                Flexible(
                  fit: FlexFit.loose,
                  child: Row(
                    
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                  
                      CustomAutoSizeText(
                        text: 'الرصيد:',
                        fontSize: 10.0,
                        fontWeight: FontWeight.w600,
                        colorText: theme.colorScheme.onSurfaceVariant,
                      ),
                      const ResponsiveSpace(width: 6.0),
                      CustomAutoSizeText(
                                        text: '$netBalanceAbsolute ${currencySymbol ?? ''} ${isClientInDebt ? ' (عليه)' : ' (له)'}',
                                        
                                        presetFontSizes: [12, 14, 16],
                                        fontWeight: FontWeight.w900,
                                        colorText: isClientInDebt ? debitColor : creditColor,
                                      ),
                    ],
                  ),
                ),
                
                

                 // إضافة شرط لعرض الحد الأقصى فقط إذا كان موجوداً
                if (ceilingAmount != null)
                CustomAutoSizeText(
                  text: 'الحد الأقصى: ${ceilingAmount!.toStringAsFixed(0)} ${currencySymbol ?? ''}',
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                  colorText: theme.colorScheme.onSurfaceVariant,
                ),
              ],
            );
  }
  Widget _buildBalanceValueView( Color creditColor, Color debitColor) {
    return Row(
     
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if(currencyFlagAsset != null)
               CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.transparent, // To prevent default background color
                  child: Image.asset(currencyFlagAsset!,
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover
                   ),),
                // رصيد "له" (المفروض أن يدفع للعميل)
                Expanded(
                  child: _buildSingleBalance(
                    label: 'له (مدين)',
                    amount: '${clientCreditBalance.toStringAsFixed(0)} ${currencySymbol ?? ''}',
                    color: creditColor,
                    theme: theme,
                  ),
                ),
                
                // فاصل عمودي أنيق
                Container(
                  width: 1.0,
                  height: 40.0,
                  color: theme.colorScheme.outlineVariant.withAlpha(50),
                  margin: responsive.paddingSym(h: 12.0),
                ),

                // رصيد "عليه" (المفروض أن يدفع العميل)
                Expanded(
                  child: _buildSingleBalance(
                    label: 'عليه (دائن)',
                    amount: '${clientDebitBalance.toStringAsFixed(0)} ${currencySymbol ?? ''}',
                    color: debitColor,
                    theme: theme,
                  ),
                ),
              ],
            );
  }

  // ودجت مساعدة لعرض رصيد واحد
  Widget _buildSingleBalance({
    required String label,
    required String amount,
    required Color color,
    required ThemeData theme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomAutoSizeText(
          text: label,
          fontSize: 10.0,
          fontWeight: FontWeight.w500,
          colorText: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
        ),
        const ResponsiveSpace(height: 4.0),
        CustomAutoSizeText(
          text: amount,
          presetFontSizes: const [16.0, 18.0],
          fontWeight: FontWeight.w800,
          colorText: color,
        ),
      ],
    );
  }
}