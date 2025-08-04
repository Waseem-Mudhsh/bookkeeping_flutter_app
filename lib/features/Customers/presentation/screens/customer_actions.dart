import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/theme_data_provider.dart';
import '../../../../core/widgets/custom_overlay.dart';
import '../../domain/entities/customer.dart';
import '../providers/customer_provider.dart';
import 'add_new_customer_sheet.dart';

class CustomerActions {
  final WidgetRef ref;
  final BuildContext context;

  CustomerActions({required this.ref, required this.context});

  Future<void> showAddCustomerSheet() async {
    await _showCustomerSheet(const AddNewCustomerSheet());
  }

  Future<void> showEditCustomerSheet(Customer customer) async {
    await _showCustomerSheet(AddNewCustomerSheet(existingCustomer: customer));
  }

  Future<void> _showCustomerSheet(Widget sheet) async {
    await showModalBottomSheet(
     
      context: context,
      isScrollControlled: false,
      builder: (context) => sheet,
    );
  }

  Future<void> deleteCustomer(String id) async {
    
    final theme = ref.watch(themeDataProvider);
  showConfirmationDialog(
      context: context,
      title: 'هل أنت متأكد أنك تريد حذف هذا الحساب',
      textColor: theme.colorScheme.error,
      content: CustomAutoSizeText(
        text: 'سيؤدي هذا إلى حذف جميع البيانات المتعلقة بهذا الحساب.',
        fontSize: 10,
        colorText: theme.colorScheme.onSurface.withAlpha(150),
        maxLines: 2,
      ),
      confirmButtonText: 'حذف',
      confirmButtonColor: theme.colorScheme.error,
      cancelButtonText: 'إلغاء',
      onConfirm: () async {
         await ref.read(customerViewModelProvider.notifier).deleteCustomer(id);
      _showSuccessMessage('تم حذف العميل بنجاح.');
      },
    );
  }


  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: CustomAutoSizeText(text: message,
      colorText:Colors.white ,
      fontFamily: 'Cairo',
      
      )),
    );
  }
}