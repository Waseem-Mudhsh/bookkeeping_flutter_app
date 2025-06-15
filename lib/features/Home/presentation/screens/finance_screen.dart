import 'package:bookkeeping_flutter_app/core/base_layout/base_layout_screen.dart';
import 'package:bookkeeping_flutter_app/core/base_layout/tabbed_layout_config.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_tab_bar.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:bookkeeping_flutter_app/features/Currencies/presentation/widgets/currency_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/responsive_notifier.dart';
import '../../../../core/providers/theme_data_provider.dart';
import '../../../../core/widgets/custom_auto_size_text.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_drawer.dart';
import '../../../../core/widgets/custom_icon_button.dart';
import '../../../Accounts/domain/entities/main_account.dart';
import '../../../Accounts/domain/entities/sub_account.dart';
// Add this import for mainAccountsProvider



class FinanceScreen extends ConsumerWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    final responsive = ref.watch(responsiveProvider);
   
    return BaseLayoutScreen(
      // backgroundColor: theme.colorScheme.secondary,
      scrollPhysics: const ClampingScrollPhysics(),
      drawer: CustomDrawer(),

     
      tabbedConfig: TabbedLayoutConfig(
        toolbarHeight: responsive.h(120),
        
        initialTabIndex: 0,
        tabs: mainAccounts.map((account) => Tab(text: account.name)).toList(),
        title: 'الحسابات',
        hasLeading: true,
        actions: [
          CustomIconbutton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_circle_left_outlined),
            
          ),
        ],
        tabBar: CustomTabBar(
          
          tabs:mainAccounts.map((account) => Tab(text: account.name)).toList(),
        ),

        tabViews: 
          mainAccounts.map((mainAccount) {
            final subList = subAccounts
                .where((sub) => sub.mainAccountId == mainAccount.id)
                .toList();

            return SizedBox(
              height: responsive.deviceSize.height,
              
              child: Padding(
                padding: responsive.paddingSym(h: 16, v: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  
                    
                    ResponsiveSpace(
                      height: 180,
                      child: CurrencyListTile()),
                    const ResponsiveSpace(height: 16),
              
                    // زر إضافة حساب فرعي جديد
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomButton(
                        
                        text: 'اضافة حساب فرعي جديد',
                        backgroundColor: theme.colorScheme.primary,
                        textColor: theme.colorScheme.onPrimary,
                        onPressed: () {
                          // انشاء حساب فرعي جديد
                        },
                      )
                    ),
              
                    const ResponsiveSpace(height: 16),
              
                    // قائمة الحسابات الفرعية
                    Expanded(
                      child: subList.isEmpty
                          ?  Align(
                            alignment: Alignment.center,
                            child: CustomAutoSizeText(text: 'لا توجد حسابات فرعية',
                            style: theme.textTheme.bodyLarge,
                            presetFontSizes: [16 ,14, 12,],
                            textAlign: TextAlign.center,),
                          )
                          : ListView.builder(
                              itemCount: subList.length,
                              itemBuilder: (context, index) {
                                final sub = subList[index];
                                return Card(
                                  child: ListTile(
                                    title: CustomAutoSizeText(
                                      text:sub.name,
                                      style: theme.textTheme.bodyLarge,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      ),
                                    subtitle: CustomAutoSizeText(
                                      text: 'النوع: ${sub.type}',
                                    style: theme.textTheme.bodySmall,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    ),
                                    trailing: CustomAutoSizeText(
                                      text: '${sub.totalBalance.toStringAsFixed(2)} ر.س',
                                      style: theme.textTheme.bodyMedium,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      ),
                                    onTap: () {
                                      // عرض تفاصيل أو سجل الحركات
                                    },
                                  ),
                                );
                              },
                            ),
                    ),
                    
                  ],
                ),
              ),
            );
          }).toList(),
         
          
        
       
         ),
         

      
    );
  }
  
}
