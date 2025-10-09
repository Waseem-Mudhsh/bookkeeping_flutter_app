import 'package:bookkeeping_flutter_app/core/base_layout/base_layout_screen.dart';
import 'package:bookkeeping_flutter_app/core/base_layout/build_non_tabbar_layout.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_drawer.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_icon_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/presentation/widgets/dual_balance_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/widgets/custom_auto_size_text.dart';
import '../widgets/custom_list_services.dart';

class HomeMainScreen extends ConsumerWidget {
  const HomeMainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   final theme = ref.theme;
    
    return BaseLayoutScreen(
      
      drawer: CustomDrawer(),
      body: BuildNonTabbarLayout(
        titleWidget:CustomAutoSizeText(
          text: 'فكة',
          style: theme.textTheme.bodyMedium,
          fontWeight: FontWeight.bold,
          fontSize: 14,
          colorText: theme.colorScheme.primary,
        ),
        actions: [
          CustomIconButton(onPressed: () {},
           hugeIcon: HugeIcon(icon: HugeIcons.strokeRoundedSearch01,
            color: theme.colorScheme.primary),),
        ],
        slivers: [
           SliverToBoxAdapter(child: ResponsiveSpace(height: 24)),
          SliverToBoxAdapter(
            child: _buildAcouuntInfo(context, ref),
          ),
          SliverToBoxAdapter(child: ResponsiveSpace(height: 16)),
          SliverToBoxAdapter(
            child: _buildListBalanceCard(ref),
        
          ),

        
          SliverToBoxAdapter(child: ResponsiveSpace(height: 24)),

       
        CustomListServices(),
        SliverToBoxAdapter(child: ResponsiveSpace(height: 24,))

        ]),

      
    );
  }
   Widget _buildAcouuntInfo(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        CircleAvatar(
          backgroundColor: theme.colorScheme.primary,
          child: CustomHugeIcon(
            icon: HugeIcons.strokeRoundedWallet01,
            size: 20,
            color: theme.colorScheme.onPrimary,
          ),
        ),
        ResponsiveSpace(width: 12),

        CustomAutoSizeText(
          text: 'مرحبا',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.center,
          colorText: theme.colorScheme.onSurface,
        ),
        CustomAutoSizeText(
          text: 'احمد',
          fontSize: 12,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
          colorText: theme.colorScheme.primary,
        ),
      ],
    );
  }
  Widget _buildListBalanceCard( WidgetRef ref) {
    final responsive = ref.responsive;
    final theme = ref.theme;
    return ResponsiveSpace(
      height: 130,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(
              width: responsive.w(300),
              child: DualBalanceCard(clientCreditBalance: 500, clientDebitBalance: 200000000,  theme: theme, responsive: responsive,hasFlag:true)),
            ResponsiveSpace(width: 16),
            SizedBox(
              width: responsive.w(300),
              child: DualBalanceCard(clientCreditBalance: 500, clientDebitBalance: 200000000, ceilingAmount: 250, theme: theme, responsive: responsive,hasFlag:true)),
            ResponsiveSpace(width: 16),
            SizedBox(
              width: responsive.w(300),
              child: DualBalanceCard(clientCreditBalance: 500, clientDebitBalance: 200000000, ceilingAmount: 250, theme: theme, responsive: responsive,hasFlag:true)),
           
          ],
          
        )),
    );
  }
}

// ... (Your existing imports)

// --- 4. Remaining Balance Card (UPDATED: Reduced Height and Improved Layout) ---
class RemainingBalanceCard extends ConsumerWidget {
  final double remainingBalance;
  final double ceilingAmount;
  // Assuming dynamic type from your project

  const RemainingBalanceCard({super.key, 
    required this.remainingBalance,
    required this.ceilingAmount,
   
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceText = remainingBalance.toStringAsFixed(0);
    final theme = ref.theme;
    final responsive = ref.responsive;
    
    // Determine the progress and color based on the ceiling
    final isOverCeiling = remainingBalance > ceilingAmount;
    // Red for Exceeded, Primary/Tertiary (Blue/Green) for Within
    final statusColor = isOverCeiling ? theme.colorScheme.error : theme.colorScheme.primary;
    
    // Calculate the normalized progress value (0.0 to 1.0)
    final progressValue = (remainingBalance / ceilingAmount).clamp(0.0, 1.0); 

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: responsive.paddingAll(16), // تقليل المساحة المتروكة (Padding)
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // مهم جداً لأخذ الارتفاع الأدنى
          children: [
            // السطر 1: الرصيد المتبقي والحد الأقصى (مدموجان في سطر واحد)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // الرصيد المتبقي (أكبر وأكثر بروزاً)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAutoSizeText(
                      text: 'متبقي عليك',
                      fontSize: 12, // تصغير الحجم
                      fontWeight: FontWeight.w600,
                      colorText: theme.colorScheme.onSurfaceVariant,
                    ),
                    CustomAutoSizeText(
                      text: balanceText,
                      fontSize: 26, // تقليل حجم النص لكن لا يزال بارزاً
                      fontWeight: FontWeight.w900,
                      colorText: statusColor,
                    ),
                  ],
                ),
                
                // الحد الأقصى (للتفاصيل)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomAutoSizeText(
                      text: 'الحد الأقصى',
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      colorText: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                    ),
                    CustomAutoSizeText(
                      text: ceilingAmount.toStringAsFixed(0),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      colorText: theme.colorScheme.onSurface,
                    ),
                  ],
                ),
              ],
            ),

            ResponsiveSpace(height: 12),
            
            // السطر 2: مؤشر التقدم (Progress Bar)
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progressValue,
                minHeight: 6, // تقليل الارتفاع قليلاً
                backgroundColor: theme.colorScheme.surfaceContainerHigh,
                valueColor: AlwaysStoppedAnimation<Color>(statusColor),
              ),
            ),
            
            ResponsiveSpace(height: 8),

            // السطر 3: مؤشرات الحالة وتاريخ الاستحقاق (مدموجان في سطر واحد)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // مؤشرات الحالة (تبسيطها)
                Row(
                  children: [
                    // ضمن الحد
                    _buildStatusIndicator(
                      label: 'ضمن الحد',
                      color: theme.colorScheme.primary, // الأزرق أو الأخضر
                      isActive: !isOverCeiling,
                      theme: theme
                    ),
                    ResponsiveSpace(width: 12),
                    // تجاوز الحد
                    _buildStatusIndicator(
                      label: 'تجاوز الحد',
                      color: theme.colorScheme.error, // الأحمر
                      isActive: isOverCeiling,
                      theme: theme
                    ),
                  ],
                ),

                // تاريخ الاستحقاق
                CustomAutoSizeText(
                  text: 'متبقي 4 أيام', // يجب استبدالها بقيمة ديناميكية
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  colorText: theme.colorScheme.onSurface,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget remains the same
  Widget _buildStatusIndicator({
    required String label,
    required Color color,
    required bool isActive,
    required ThemeData theme,
  }) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? color : color.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
        ),
        ResponsiveSpace(width: 4),
        CustomAutoSizeText(
          text: label,
          fontSize: 10,
          fontWeight: FontWeight.w500,
          colorText: theme.colorScheme.onSurfaceVariant,
        ),
      ],
    );
  }
}

// ... (Your existing imports)

// --- 4. Dual Balance Card (UPDATED: Showing Both Credit "له" and Debit "عليه") ---

