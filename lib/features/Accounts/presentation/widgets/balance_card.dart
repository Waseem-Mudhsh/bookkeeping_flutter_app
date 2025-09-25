import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_icon_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/domain/entities/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/utils/responsive_values.dart';

class BalanceCard extends ConsumerStatefulWidget {
  final Account account;
  const BalanceCard({super.key, required this.account});
  @override
  ConsumerState<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends ConsumerState<BalanceCard> {
  bool _obscureText = true; // Default to obscured for security

  @override
  Widget build(BuildContext context) {
    final theme = ref.theme;
    final responsive = ref.responsive;
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Card(
          elevation: 6,
          
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
           padding: responsive.paddingSym(h: 16, v: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomAutoSizeText(
                      text: "رصيدك",
                      style: theme.textTheme.bodyMedium,
                      fontSize: 12,
                      colorText: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    ResponsiveSpace(width: 16),
                    Expanded(child: _buildBalanceDisplay(theme, responsive)),
                    ResponsiveSpace(width: 12),
                    CustomIconButton(
                      hugeIcon: HugeIcon(
                        icon: _obscureText
                            ? HugeIcons.strokeRoundedViewOffSlash
                            : HugeIcons.strokeRoundedEye,
                        size: 20,
                        color: theme.colorScheme.onPrimary,
                      ),
                      // لون الأيقونة من primary,
                     
                      onPressed: _toggleBalanceVisibility,
                      tooltip: _obscureText ? 'إظهار الرصيد' : 'إخفاء الرصيد',
                    ),
                  ],
                ),
               
               ResponsiveSpace(height:12,),
               
               
                _buildBalanceOverviewSection(theme, responsive),
              
                
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
                  strokeWidth: 0.7,
                  value: 1,
                  color: theme.colorScheme.onPrimary.withValues(alpha: 0.2),
                ),
              ),
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
                  child: CustomAutoSizeText(
                    text: _obscureText ? '••••••' :  widget.account.totalAccountBalance.toStringAsFixed(2),
                    fontWeight: FontWeight.bold,
                    colorText: theme.colorScheme.onPrimary,
                    fontSize: responsive.w(20),
            
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
                const ResponsiveSpace(width: 8),
                CustomAutoSizeText(
                  text: widget.account.currencyCode!,
                  colorText: theme.colorScheme.onPrimary.withValues(alpha: 0.7,),
                  fontSize: 16,
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
          ResponsiveSpace(width: responsive.w(6)),
          VerticalDivider(
            thickness: 1.0, // سمك أكبر للفاصل
            color: theme.colorScheme.onPrimary.withValues(alpha: 0.3), // لون الفاصل
          ),
          
          ResponsiveSpace(width: responsive.w(6)),
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
              size:18,
            ),
            ResponsiveSpace(width: responsive.w(8)),
            CustomAutoSizeText(
              text: label,
              style: theme.textTheme.bodyMedium,
                colorText: theme.colorScheme.onPrimary.withValues(alpha: 0.9),
                fontWeight: FontWeight.bold,
                fontSize: 12  ,
              
            ),
          ],
        ),
        ResponsiveSpace(height: responsive.h(4)),
        CustomAutoSizeText(
          text: _obscureText ? '••••••' : value.toStringAsFixed(2),
          fontWeight: FontWeight.bold,
          colorText: _obscureText ?theme.colorScheme.onPrimary.withValues(alpha: 0.9) : theme.colorScheme.onPrimary,
          style: theme.textTheme.bodyMedium
        ),
      ],
    );
  }
  void _toggleBalanceVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
