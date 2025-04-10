import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/customer_provider.dart';

class StyledCustomerTable extends ConsumerWidget {
  

  const StyledCustomerTable({ super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customers=ref.watch(customerProvider);
    if (customers.isEmpty) {
      return Center(
        child: Text(
          "No customers available.",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    }
    return DataTable(
      headingRowColor: WidgetStatePropertyAll(Colors.grey.shade300),
      columns: const [
        DataColumn(label: Text("ID", style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(label: Text("Name", style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(label: Text("Balance", style: TextStyle(fontWeight: FontWeight.bold))),
      ],
      rows: customers
          .map(
            (customer) => DataRow(cells: [
              DataCell( Text(customer.id.substring(0, 5))),
              DataCell(Text(customer.name)),
              DataCell(Text("\$${customer.balance.toStringAsFixed(2)}")),
            ]),
          )
          .toList(),
    );
  }
}