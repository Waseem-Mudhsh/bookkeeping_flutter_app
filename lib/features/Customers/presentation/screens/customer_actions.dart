import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/customer.dart';
import '../providers/customer_provider.dart';
import 'add_customer_sheet.dart';

class CustomerActions {
  final WidgetRef ref;
  final BuildContext context;

  CustomerActions({required this.ref, required this.context});

  Future<void> showAddCustomerSheet() async {
    await _showCustomerSheet(const AddCustomerSheet());
  }

  Future<void> showEditCustomerSheet(Customer customer) async {
    await _showCustomerSheet(AddCustomerSheet(existingCustomer: customer));
  }

  Future<void> _showCustomerSheet(Widget sheet) async {
    await showModalBottomSheet(
     
      context: context,
      isScrollControlled: false,
      builder: (context) => sheet,
    );
  }

  Future<void> deleteCustomer(String id) async {
    final confirmed = await _showDeleteConfirmationDialog();
    if (confirmed) {
      await ref.read(customerViewModelProvider.notifier).deleteCustomer(id);
      _showSuccessMessage('Customer deleted successfully');
    }
  }

  Future<bool> _showDeleteConfirmationDialog() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm Delete'),
            content: const Text('Are you sure you want to delete this customer?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Delete', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}