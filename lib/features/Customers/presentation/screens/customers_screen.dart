import 'package:bookkeeping_flutter_app/core/base_layout/base_layout_screen.dart';
import 'package:bookkeeping_flutter_app/core/base_layout/build_tab_bar_layout.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/utils/route_names.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_icon_button.dart';
import 'package:bookkeeping_flutter_app/features/Customers/presentation/screens/top_side.dart';
import 'package:bookkeeping_flutter_app/features/Customers/presentation/screens/customer_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



import '../../../../core/providers/responsive_notifier.dart';

import '../../../../core/providers/theme_data_provider.dart';
import '../../../../core/widgets/custom_drawer.dart';

import '../providers/customer_provider.dart';
import '../widgets/customer_card.dart';
import '../../../../core/widgets/custom_empty_state.dart';

class CustomersScreen extends ConsumerWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customersAsync = ref.watch(customerViewModelProvider);
    final responsive = ref.watch(responsiveProvider);
    
    

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(customerViewModelProvider);
      },
      edgeOffset: responsive.h(100),
      child: BaseLayoutScreen(
        
       drawer: CustomDrawer(),
      
      
      body: BuildTabBarLayout(
        tabs: const [
            Tab(text: 'العملاء'),
            Tab(text: 'الجانب العلوي'),
            
          ],
        
          title: 'قائمة العملاء',
          toolbarHeight: responsive.h(120),
          hasLeading: true,
          actions: [
            CustomIconButton(onPressed: ()
           {
            Navigator.pop(context);
            },
             icon: const Icon(Icons.arrow_circle_left_outlined)),
          
          ],
         

        tabViews: [
         
          builderCustomerLists(context, ref, customersAsync),
          SingleChildScrollView(
            child: TopSide(),
          ),
           
        ],
        initialTabIndex: 0,

      ),
        
         
       
        
        
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CustomerSubRoutes.create.screen));
            // actions.showCustomerSheet();
          },
          child: const Icon(Icons.add),
        ),
        
       
        )
    );
      
    
  }
  Widget builderCustomerLists (BuildContext context, WidgetRef ref, AsyncValue<List<dynamic>> customersAsync) {
    var actions = CustomerActions(ref: ref, context: context);
    final responsive = ref.responsive;
    
    return  SingleChildScrollView(
      child: Padding(
        padding: responsive.paddingAll(16),
        child: customersAsync.when(
                data: (customers) => Column(
                  spacing: responsive.h(8),
                  children: [
                    if (customers.isEmpty)
                       Center(
                        child: CustomEmptyState(
                           message: 'لا يوجد عملاء',
                          subMessage: 'يمكنك إضافة عملاء جدد من خلال زر الإضافة في الزاوية السفلى اليمنى',
                          
                        ),
                      ),
                    ...customers.map(
                      (customer) => CustomerCard(
                        customer: customer,
                        
                       onEdit: () => actions.showEditCustomerSheet(customer),
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




