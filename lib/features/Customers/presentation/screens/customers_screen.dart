import 'package:bookkeeping_flutter_app/core/base_layout/base_layout_screen.dart';
import 'package:bookkeeping_flutter_app/core/custom_slivers/custom_sliver_app_bar.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_icon_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_tab_bar.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:bookkeeping_flutter_app/features/Currencies/presentation/widgets/currency_list_tile.dart';
import 'package:bookkeeping_flutter_app/features/Customers/presentation/screens/top_side.dart';
import 'package:bookkeeping_flutter_app/features/Customers/presentation/screens/customer_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../../core/base_layout/tabbed_layout_config.dart';
import '../../../../core/providers/responsive_notifier.dart';
import '../../../../core/providers/theme_data_provider.dart';
import '../../../../core/widgets/custom_auto_size_text.dart';
import '../../../../core/widgets/custom_drawer.dart';

import '../providers/customer_provider.dart';
import '../widgets/customer_card.dart';
import '../widgets/customer_empty_state.dart';

class CustomersScreen extends ConsumerWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customersAsync = ref.watch(customerViewModelProvider);
    final actions = CustomerActions(ref: ref, context: context);
    final responsive = ref.watch(responsiveProvider);
    final theme = ref.watch(themeDataProvider);
    

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(customerViewModelProvider);
      },
      edgeOffset: responsive.h(100),
      child: BaseLayoutScreen(
        backgroundColor: theme.colorScheme.secondary,
       drawer: CustomDrawer(),
      header: CustomSliverAppBar(
        hasLeading: true,
        pinned: true,
        title: CustomAutoSizeText(
          text: '  العملاء',
          style: theme.textTheme.bodyLarge,
          colorText: theme.colorScheme.primary,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          CustomIconbutton(onPressed: () {}, icon: const Icon(Icons.search)),
          
        ],
      ),
      scrollPhysics: const ClampingScrollPhysics(),
        sliversHeader: [
          SliverToBoxAdapter(
            child: ResponsiveSpace(height: 16),
          ),
          
         SliverToBoxAdapter(
          child: ResponsiveSpace(
            height: 180,
            child: CurrencyListTile()),
         )
        ],
         tabbedConfig: TabbedLayoutConfig(
       tabs: const [
            Tab(text: 'قائمة العملاء'),
            Tab(text: 'التقارير'),
          ],
          title: 'قائمة العملاء',
          toolbarHeight: responsive.h(120),
          hasLeading: true,
          actions: [
            CustomIconbutton(onPressed: () {}, icon: const Icon(Icons.search)),
          ],
          tabBar: CustomTabBar(
            tabs: const [
              Tab(text: 'قائمة العملاء'),
              Tab(text: 'التقارير'),
            ],
          ),

        tabViews: [
         
          builderCustomerLists(context, ref, customersAsync),
          SingleChildScrollView(
            child: TopSide(),
          )
        ],
        initialTabIndex: 0,
         ),
       
        
        
        floatingActionButton: FloatingActionButton(
          onPressed: actions.showAddCustomerSheet,
          child: const Icon(Icons.add),
        ),
        
       
        )
    );
      
    
  }
  Widget builderCustomerLists (BuildContext context, WidgetRef ref, AsyncValue<List<dynamic>> customersAsync) {
    var actions = CustomerActions(ref: ref, context: context);
    final responsive = ref.watch(responsiveProvider);
    return  SingleChildScrollView(
      child: Padding(
        padding: responsive.paddingAll(16),
        child: customersAsync.when(
                data: (customers) => Column(
                  spacing: responsive.h(8),
                  children: [
                    if (customers.isEmpty)
                      const Center(
                        child: CustomerEmptyState(),
                      ),
                    ...customers.map(
                      (customer) => CustomerCard(
                        customer: customer,
                        onDelete: () => actions.deleteCustomer(customer.id),
                      ),
              
              ),
                  ],
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(child: Text(error.toString()))),
      ),
    );
  }
  
}

// class BuilderBottomNavigationBar extends ConsumerWidget {
//   const BuilderBottomNavigationBar({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final theme = ref.watch(themeDataProvider);
//     final responsive = ref.watch(responsiveProvider);
    
//     return Container(
//       height: responsive.h(80), // Fixed height
//       decoration: BoxDecoration(
//         color: theme.colorScheme.onSecondary,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 4,
//             spreadRadius: 1,
//           ),
//         ],
//       ),
//       padding: responsive.paddingSym(h: 16, v: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Expanded(
//             child: CustomShowbalince(
//               titleBalince: ' عليك :',
//               valueBalince: '100000000000',
//               iscreditor: true,
//               isleft: false,
//             ),
//           ),
//           ResponsiveSpace(width: responsive.w(8)),
//           Expanded(
//             child: CustomShowbalince(

//               titleBalince: ' مدين :',
//               valueBalince: '100055500000',
//               iscreditor: false,
//               isleft: true,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



