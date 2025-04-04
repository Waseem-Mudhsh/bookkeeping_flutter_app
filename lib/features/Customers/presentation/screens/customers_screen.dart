import 'package:bookkeeping_flutter_app/core/app_scaffold/page_builder.dart';
import 'package:bookkeeping_flutter_app/core/app_scaffold/sliver_extensions.dart';
import 'package:bookkeeping_flutter_app/core/providers/responsive_notifier.dart';
import 'package:bookkeeping_flutter_app/features/Customers/presentation/providers/customer_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  Widget build(BuildContext context, ) {
    final customers = ref.watch(customerProvider);
    final customerViewModel = ref.read(customerProvider.notifier);
    final responsive = ref.watch(responsiveProvider);
    

    return PageBuilder.build(
      slivers: [
        const SliverAppBar(
          title: Text('Customers'),
          pinned: true,
          floating: true,
        ),
        ref.responsiveSliverPadding(
          
          sliver:
          ref.responsiveSliverBox(
            
            child:Padding(
        padding:  EdgeInsets.all(responsive.w(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add New Customer
            Text("Add New Customer", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
              onChanged: (query) => customerViewModel.filterCustomers(query),
            ),
            SizedBox(height: 20),

            // Table Header
            Text("Customer List", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),

            // Data Table
            Expanded(
              child: SizedBox(
                width: responsive.w(300),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      border: TableBorder.all(color: Colors.grey),
                      columns: [
                        DataColumn(label: Text("ID"), onSort: (_, __) => customerViewModel.sortBy("id")),
                        DataColumn(label: Text("Name"), onSort: (_, __) => customerViewModel.sortBy("name")),
                        DataColumn(label: Text("Balance"), onSort: (_, __) => customerViewModel.sortBy("balance")),
                        DataColumn(label: Text("Delete")),
                        DataColumn(label: Text("Update")),
                      ],
                      rows: customers.map((customer) {
                        return DataRow(cells: [
                          DataCell(Text(customer.id.substring(0, 5))),
                          DataCell(Text(customer.name)),
                          DataCell(Text("\$${customer.balance.toStringAsFixed(2)}")),
                          DataCell(
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => customerViewModel.deleteCustomer(customer.id),
                            ),
                          ),
                          DataCell( IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () => customerViewModel.updateCustomer(customer),
                                ),)
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),

            // Pagination Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: customerViewModel.previousPage,
                  child: Text("Previous"),
                ),
                ElevatedButton(
                  onPressed: customerViewModel.nextPage,
                  child: Text("Next"),
                ),
              ],
            ),
          ],
        ),
      ),
          
          )
        
        
        )
      ],
      
      
      
    );
      
           
       
}
}