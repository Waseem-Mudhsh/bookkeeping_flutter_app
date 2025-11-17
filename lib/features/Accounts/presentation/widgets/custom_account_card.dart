import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_alert_dialog_enhanced.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../core/utils/route_names.dart';
import '../../domain/entities/account.dart';
import '../providers/account_provider.dart';

class CustomAccountCard extends ConsumerWidget {
  final Account? account;
  final Function(Account) onTap;
  
  

  const CustomAccountCard({
    super.key,
    required this.account,
    required this.onTap,
    
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    final responsive =ref.responsive;
    return Card(
      // color: theme.colorScheme.surface,
      
      margin: responsive.paddingOnly(bottom: responsive.h(4)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(responsive.w(12)),
        side: BorderSide(color: theme.colorScheme.outline.withValues(alpha: 0.5),
        width: 0.5,
        )
      ),
      
      child: InkWell(
       
        onTap: () => onTap(account!),
        child: Padding(
          padding: responsive.paddingSym(h: 12, v: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAccountInfo(context,theme, ref),
              ResponsiveSpace(height: 16),
              
              _buildBalanceInfo2(theme),
            ],
          ),
        ),
      ),
    );
  }

 
  Widget _buildAccountInfo( BuildContext context, ThemeData theme , WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      
      children: [
        Expanded(
          child: Row(
            
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: CustomAutoSizeText(
                  text: account!.name,
                  fontWeight: FontWeight.bold,
                  // colorText: theme.colorScheme.onSurface,
                  style: theme.textTheme.bodyMedium,
                 
                  overflow: TextOverflow.ellipsis,
                  fontSize: 12,
                ),
              ),
              Spacer(),
              CustomIconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AccountSubRoutes.edit.screenEdit(account!)));
                },
                  hugeIcon: HugeIcons.strokeRoundedEdit02,
                    
                    colorIcon: theme.colorScheme.onSurface,
                    iconSize: 16
                  
                 
                
                 )
            ],
          ),
        ),
        ResponsiveSpace(width: 8),
         CustomIconButton(
          
              onPressed: () {
                _buildDeleteAccountDialog(context,ref);
              },
              hugeIcon: HugeIcons.strokeRoundedDelete01,
               colorIcon: theme.colorScheme.error,
               iconSize: 16
               ),
               
        
      ],
    );
  }
  void _buildDeleteAccountDialog(BuildContext context,WidgetRef ref) {
    final theme = ref.theme;
    showCustomDialog(
                  
                  context: context,
                  title: 'حذف الحساب',
                  hugeIconTitle: HugeIcons.strokeRoundedDelete01,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAutoSizeText(
                        text: 'هل أنت متأكد أنك تريد حذف هذا الحساب؟',
                        style: theme.textTheme.bodyMedium,
                        fontSize: 12,
                        colorText: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                      ResponsiveSpace(height: 8),
                      CustomAutoSizeText(
                        text: 'سيتم حذف جميع المعاملات المرتبطة بهذا الحساب.',
                        style: theme.textTheme.bodyMedium,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        colorText: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed:()=> Navigator.pop(context),
                       child: CustomAutoSizeText(
                        text: 'إلغاء',
                        style: theme.textTheme.bodyMedium,
                        fontSize: 12,
                        colorText: theme.colorScheme.onSurface,
                       ),
                       ),

                       CustomButton(
                        text: 'حذف',
                        width: 100,
                        height: 30,
                        onPressed: () {
                    Navigator.pop(context);
                          
                         
                    // Handle account deletion logic here
                    // For example, call a function to delete the account

                    // After deletion, you might want to pop the dialog or navigate back
                    ref.read(accountViewModelProvider.notifier).deleteAccount(account!.id);
                     
                     ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: CustomAutoSizeText(
                      fontFamily: 'Cairo',
                      text: 'تم حذف الحساب بنجاح!',
                      colorText: theme.colorScheme.onPrimary,
                      fontSize: 12,
                    ),
                    backgroundColor:theme.colorScheme.primary,
                  ),
                );     },)
                  ]
                );
  }
  Widget _buildBalanceInfo2(ThemeData theme) {
    return IntrinsicHeight(
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildCurrencyInfo(theme,'يمني',account!.totalAccountBalance.toStringAsFixed(2),true)),
          ResponsiveSpace(width: 4),
          VerticalDivider(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
            thickness: 1,
            width: 16,
          ),
          ResponsiveSpace(width: 4),
          Expanded(child: _buildCurrencyInfo(theme,' دولار',account!.totalAccountBalance.toStringAsFixed(2), false)),
          ResponsiveSpace(width: 4),
          VerticalDivider(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
            thickness: 1,
            width: 16,
          ),
          Expanded(child: _buildCurrencyInfo(theme,' سعودي',account!.totalAccountBalance.toStringAsFixed(2), false)),
          
        ],
      ),
    );
  }
  Widget _buildCurrencyInfo(ThemeData theme,String currencyName,String balance,bool isDebtor ) {
     Color balanceColor = isDebtor ? Colors.red.shade600 : Colors.green.shade600; // ألوان مميزة
     IconData icon = isDebtor ? HugeIcons.strokeRoundedSquareArrowDownRight : HugeIcons.strokeRoundedSquareArrowUpRight; // أيقونات توضيحية
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
              icon:icon,
              color: balanceColor,
              size: 16,
            ),
            ResponsiveSpace(width: 4),
            CustomAutoSizeText(
              text: currencyName,
              fontWeight: FontWeight.w700,
              colorText: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              style: theme.textTheme.bodySmall,
              fontSize: 12,
            ),]),
            ResponsiveSpace(height: 4),
            CustomAutoSizeText(
              text: balance,
              fontWeight: FontWeight.bold,
              colorText: account!.debtor != 0
              ? Colors.green.shade700
              : Colors.red.shade700,
              style: theme.textTheme.bodyMedium,
              fontSize: 12,
              maxLines: 1,
            ),
          ],
        );
       
  }
}