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
          text: 'تابع',
          style: theme.textTheme.bodyMedium,
          fontWeight: FontWeight.bold,
          fontSize: 12,
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
              child: DualBalanceCard(clientCreditBalance: 500, clientDebitBalance: 200000000,  theme: theme, responsive: responsive,hasFlag:true)),
            ResponsiveSpace(width: 16),
            SizedBox(
              width: responsive.w(300),
              child: DualBalanceCard(clientCreditBalance: 500, clientDebitBalance: 200000000, ceilingAmount: 250, theme: theme, responsive: responsive,hasFlag:true)),
           
          ],
          
        )),
    );
  }
}


