import 'package:bookkeeping_flutter_app/core/base_layout/base_layout_screen.dart';
import 'package:bookkeeping_flutter_app/core/base_layout/build_non_tabbar_layout.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_drawer.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_icon_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/widgets/custom_auto_size_text.dart';
import '../../../Accounts/presentation/widgets/mester_card.dart';
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
          text: 'جاهز',
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
          
        

        // SliverToBoxAdapter(
        //   child: SingleChildScrollView(child: CustomListServices()),
        // ),
        SliverToBoxAdapter(child: 
        CustomListServices()),
        SliverToBoxAdapter(child: ResponsiveSpace(height: 24,))

        ]),

      
    );
  }
}
