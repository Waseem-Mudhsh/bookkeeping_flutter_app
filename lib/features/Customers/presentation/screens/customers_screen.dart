import 'package:bookkeeping_flutter_app/core/app_scaffold/sliver_extensions.dart';
import 'package:bookkeeping_flutter_app/features/Currencies/presentation/screens/currency_selector.dart';
import 'package:bookkeeping_flutter_app/features/Customers/presentation/screens/customer_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/app_scaffold/page_builder.dart';
import '../../../../core/providers/responsive_notifier.dart';
import '../../../../core/providers/theme_data_provider.dart';
import '../providers/customer_provider.dart';
import '../providers/customer_search_provider.dart';
import '../widgets/customer_empty_state.dart';
import '../widgets/customer_search_bar.dart';
import 'customer_list.dart';

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
      child: PageBuilder.build(
        slivers: [
          ref.responsiveSliverAppBar(
            "العملاء",
            pinned: true,
            floating: true,
            snap: false,

            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed:
                    () =>
                        ref
                            .read(customerViewModelProvider.notifier)
                            .loadCustomers(),
              ),
              PopupMenuButton(
                icon: Icon(Icons.more_vert), // الأيقونة هنا
                itemBuilder:
                    (context) => [
                      PopupMenuItem(
                        value: 'edit',
                        child: Text('تعديل', style: theme.textTheme.bodySmall),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Text('حذف', style: theme.textTheme.bodySmall),
                      ),
                    ],
                onSelected: (value) {
                  // التعامل مع الاختيار هنا
                },
              ),
            ],
          ),
          ref.responsiveSliverPadding(
            all: 16,
            sliver: ref.responsiveSliverBox(child: CurrencySelectorScreen()),
          ),
          ref.responsiveSliverBox(
            child: CustomerSearchBar(), // حقل البحث + زر الترتيب
          ),

          customersAsync.when(
            loading:
                () => ref.responsiveSliverBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: responsive.h(32)),
                    child: const CircularProgressIndicator(),
                  ),
                ),
            error:
                (error, _) => ref.responsiveSliverBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: responsive.h(32)),
                    child: Text('حدث خطأ: $error'),
                  ),
                ),
            data: (customers) {
              // تمرير البيانات إلى فلتر البحث عند أول تحميل أو تغيير


              // الآن نستخدم النتائج المفلترة بدلًا من البيانات الأصلية
              

              if (customers.isEmpty) {
                return ref.responsiveSliverBox(
                  child: const CustomerEmptyState(),
                );
              }

              return ref.responsiveSliverPadding(
                all: 16,
                sliver: CustomerList(customers: customers, actions: actions),
              );
            },
          ),
        ],
        floatingActionButton: FloatingActionButton(
          onPressed: actions.showAddCustomerSheet,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
