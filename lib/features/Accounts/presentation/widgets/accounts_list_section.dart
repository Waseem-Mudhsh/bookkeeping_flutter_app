import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../core/widgets/custom_auto_size_text.dart';
import '../../../../core/widgets/custom_empty_state.dart';
import '../../../../core/widgets/custom_icon_button.dart';
import '../../../../core/widgets/responsive_space.dart';
import '../../domain/entities/account.dart';
import '../providers/account_provider.dart';
import 'custom_account_card.dart';
class AccountsListSection extends ConsumerWidget {
  
  final ValueChanged<Account> onAccountTap;
  final VoidCallback onAddAccount; // For an "add account" button if needed inside the section

  const AccountsListSection({super.key, 
    
    required this.onAccountTap,
    required this.onAddAccount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAccounts = ref.watch(accountViewModelProvider);
  
    return asyncAccounts.when(
      loading: () => _buildLoading(),
      error: (error, _) => _buildError(error),
      data:
          (accounts) =>
              accounts.isEmpty
                  ? _buildEmptyState()
                  : _buildAccountsList(accounts, ref ),
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildError(Object error) => Center(child: Text('Error: $error'));

  Widget _buildEmptyState() {
    return Consumer(
      builder: (context, ref, _) {
        final responsive = ref.responsive;
        
        return Padding(
          padding: responsive.paddingOnly(top:16),
          child: Center(
            child: CustomEmptyState(
              message: 'لا يوجد حسابات',
              subMessage: 'يمكنك إضافة حسابات جديدة من خلال زر الإضافة',
              icon: HugeIcons.strokeRoundedUserAdd02,
              
            ),
          ),
        );
      },
    );
  }

  Widget _buildAccountsList(List<dynamic> accounts, WidgetRef ref) {
    final theme= ref.theme;
    final responsive = ref.responsive;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: responsive.h(8),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomAutoSizeText(
              text: 'عدد الحسابات: ${accounts.length}',
              style: theme.textTheme.bodyMedium,
              fontWeight: FontWeight.w600,
              colorText: theme.colorScheme.primary,
              fontSize: 12,
            ),
            Spacer(),
            CustomIconButton(
              hugeIcon:  HugeIcon(icon:HugeIcons.strokeRoundedSearch01,
               color: theme.colorScheme.primary,
               size: responsive.h(20),),
             
              // iconColor: theme.colorScheme.tertiary,
              onPressed: onAddAccount,
              // backgroundColor: theme.colorScheme.tertiary.withValues(alpha: 0.05),
            ),
            ResponsiveSpace(width: 8),
            CustomIconButton(
              hugeIcon: HugeIcon(icon: HugeIcons.strokeRoundedSorting01,
               color: theme.colorScheme.primary,
               size: responsive.h(20),),
            
              onPressed: onAddAccount,
              // backgroundColor: theme.colorScheme.tertiary.withValues(alpha: 0.05),
            ),
     
          ],
        ),
        
    
        ...accounts.map(
          (account) => CustomAccountCard(
            account: account,
            onTap: onAccountTap,
            
            // theme: theme,
          ),
        ),
      ],
    );
  }
 
}
