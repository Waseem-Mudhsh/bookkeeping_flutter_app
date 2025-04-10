import 'package:bookkeeping_flutter_app/core/app_scaffold/page_builder.dart';
import 'package:bookkeeping_flutter_app/core/app_scaffold/sliver_extensions.dart';
import 'package:bookkeeping_flutter_app/core/providers/responsive_notifier.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_drawer.dart';
import 'package:bookkeeping_flutter_app/core/widgets/theme_switcher.dart';
import 'package:bookkeeping_flutter_app/features/Customers/presentation/providers/customer_provider.dart';
import 'package:bookkeeping_flutter_app/features/Customers/presentation/widgets/custom_customer_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/theme_data_provider.dart';
import '../../domain/entities/customer.dart';

class CustomersScreen extends ConsumerStatefulWidget {
  const CustomersScreen({super.key});

  @override
  CustomersScreenState createState() => CustomersScreenState();
}

class CustomersScreenState extends ConsumerState<CustomersScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.watch(customerProvider);
    final customerViewModel = ref.read(customerProvider.notifier);
    final responsive = ref.watch(responsiveProvider);
    final theme = ref.watch(themeDataProvider);

    return PageBuilder.build(
      drawer: CustomDrawer(),
      slivers: [
        ref.responsiveSliverAppBar(
          "العملاء",
          pinned: true,
          floating: true,
          snap: false,
          
          actions: [
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
        ref.responsiveSliverPersistentHeader(
          minHeightFactor: 60, // Minimum height as a factor of screen height
          maxHeightFactor: 100, // Maximum height as a factor of screen height
          pinned: true,
          floating: false,
          builder: (context, progress) {
            return Container(
              
              color: Colors.blue, // Fade effect
              alignment: Alignment.center,
              child:ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (int i = 0; i < 10; i++)
                    Container(
                      width: responsive.w(100),
                      height: responsive.h(50),
                      color: Colors.blueAccent,
                      child: Center(
                        child: Text(
                          'Item $i',
                          style: TextStyle(color: Colors.white, fontSize: responsive.sp(12)),
                        ),
                      ),
                    ),
                ],
              )
            );
          },
        ),

        ref.responsiveSliverPadding(
          all: 16,
          sliver: ref.responsiveSliverBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ThemeSwitcher(),
                SizedBox(height: 20),
                // Add New Customer
                Text(
                  "Add New Customer",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(labelText: "Customer Name"),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (nameController.text.isNotEmpty) {
                          final customer = Customer(
                            id: DateTime.now().toString(),
                            name: nameController.text,
                            balance: 0,
                          );
                          customerViewModel.addCustomer(customer);
                          nameController.clear();
                        }
                      },
                      child: Text("Add"),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Search Bar
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: "Search Customer",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged:
                      (query) => customerViewModel.filterCustomers(query),
                ),
                SizedBox(height: 20),

                // Table Header
                Text(
                  "Customer List",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),

                // Data Table
                SizedBox(height: responsive.w(20)),

                // Pagination Controls
              ],
            ),
          ),
        ),
        ref.responsiveSliverBox(child: CustomCustomerList()),
      ],
    );
  }
}
