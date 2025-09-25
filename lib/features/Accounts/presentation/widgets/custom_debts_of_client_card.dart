import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/widgets/custom_huge_icon.dart';

// نموذج بيانات الديون بعدة عملات
class MultiCurrencyDebtModel {
  final String clientName;
  final List<CurrencyDebt> debts;

  const MultiCurrencyDebtModel({
    required this.clientName,
    required this.debts,
  });
}

class CurrencyDebt {
  final String currencyName;
  final double previousBalance;
  final double currentBalance;
  final bool isDebtor;

  const CurrencyDebt({
    required this.currencyName,
    required this.previousBalance,
    required this.currentBalance,
    required this.isDebtor,
  });
}

// Provider وهمي للبيانات
final multiCurrencyDebtProvider = FutureProvider<MultiCurrencyDebtModel>((ref) async {
  await Future.delayed(const Duration(milliseconds: 800));
  return const MultiCurrencyDebtModel(
    clientName: 'أحمد محمود',
    debts: [
      CurrencyDebt(
        currencyName: 'يمني',
        previousBalance: 2400,
        currentBalance: 2500,
        isDebtor: true,
      ),
      CurrencyDebt(
        currencyName: 'دولار',
        previousBalance: 2300,
        currentBalance: 2360,
        isDebtor: true,
      ),
      CurrencyDebt(
        currencyName: 'سعودي',
        previousBalance: 3900,
        currentBalance: 4000,
        isDebtor: true,
      ),
    ],
  );
});

class CustomDebtsOfClientCard extends ConsumerWidget {
  const CustomDebtsOfClientCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    final responsive = ref.responsive;
    final debtDataAsync = ref.watch(multiCurrencyDebtProvider);

    return debtDataAsync.when(
      loading: () => const SizedBox(
        height: 150,
        child: Center(child: CircularProgressIndicator(color: Colors.white)),
      ),
      error: (err, stack) => SizedBox(
        height: 150,
        child: Center(
          child: Text(
            'فشل تحميل البيانات',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
      ),
      data: (data) {
        return Card(
          
         
          elevation: 6,
          child: Container(
            decoration: BoxDecoration(
            gradient: LinearGradient(
              tileMode: TileMode.decal,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.primary,
                theme.colorScheme.primary.withValues(alpha: 0.8),
              ],
            
            ),
           
          ),
            child: Padding(
              padding: responsive.paddingAll(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                 
                  
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildDebtStatusIcon(true, theme),
                      const ResponsiveSpace(width: 8),
                      CustomAutoSizeText(
                        text: 'إجمالي ديوني المستحقة',
                        style: theme.textTheme.titleMedium,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        colorText: theme.colorScheme.onPrimary.withValues(alpha: 0.9),
                      ),
                    ],
                  ),
                  const ResponsiveSpace(height: 16),
                  _buildBalanceInfoCurrencies(theme, data.debts),
                  const ResponsiveSpace(height: 16),
                  _buildCallToActionButton(context, theme),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBalanceInfoCurrencies(ThemeData theme, List<CurrencyDebt> debts) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < debts.length; i++) ...[
            if (i != 0)
              ...[
                ResponsiveSpace(width: 4),
                VerticalDivider(
                  color: theme.colorScheme.onPrimary.withValues(alpha: 0.2),
                  thickness: 1,
                  width: 16,
                ),
                ResponsiveSpace(width: 4),
              ],
            Expanded(child: _buildCurrencyInfo(theme, debts[i])),
          ],
        ],
      ),
    );
  }

  Widget _buildCurrencyInfo(ThemeData theme, CurrencyDebt debt) {
    Color balanceColor = debt.isDebtor ?theme.colorScheme.error : Colors.green.shade600;
    IconData icon = debt.isDebtor
        ? HugeIcons.strokeRoundedArrowUpRight01
        : HugeIcons.strokeRoundedArrowDownRight01;

    return Column(

      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomHugeIcon(
              icon: icon,
              color: balanceColor,
              size: 16,
            ),
            ResponsiveSpace(width: 4),
            CustomAutoSizeText(
              text: debt.currencyName,
              fontWeight: FontWeight.w700,
              colorText: theme.colorScheme.onPrimary.withValues(alpha: 0.9),
              style: theme.textTheme.bodySmall,
              fontSize: 12,
            ),
          ],
        ),
        ResponsiveSpace(height: 4),
        TweenAnimationBuilder<double>(
          tween: Tween<double>(
            begin: debt.previousBalance,
            end: debt.currentBalance,
          ),
          duration: const Duration(milliseconds: 1200),
          builder: (context, value, child) => CustomAutoSizeText(
            text: value.toStringAsFixed(0),
            fontWeight: FontWeight.bold,
            colorText: theme.colorScheme.onPrimary,
            style: theme.textTheme.bodyMedium,
            fontSize: 12,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  

  Widget _buildDebtStatusIcon(bool isInDebt, ThemeData theme) {
    return CircleAvatar(
      backgroundColor: isInDebt ? Colors.red.shade700 : Colors.green.shade700,
      radius: 12,
      child: Icon(
        isInDebt
            ? HugeIcons.strokeRoundedArrowUpRight01
            : HugeIcons.strokeRoundedArrowDownRight01,
        size: 14,
        color: Colors.white,
      ),
    );
  }

  Widget _buildCallToActionButton(BuildContext context, ThemeData theme) {
    return ResponsiveSpace(
      width: double.infinity,
      child: CustomButton(
        
        onPressed: () {
          // Add navigation or action here.
        },
        text: 'عرض تفاصيل الدين',
        backgroundColor:theme.colorScheme.onPrimary,
        textColor: theme.colorScheme.primary,
      ),
    );
  }
}