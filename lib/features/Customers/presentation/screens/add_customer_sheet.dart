import 'package:bookkeeping_flutter_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/providers/responsive_notifier.dart';
import '../../../../core/providers/theme_data_provider.dart';
import '../../domain/entities/customer.dart';

import '../providers/customer_provider.dart';
import '../widgets/timer_progress_card.dart';

class AddCustomerSheet extends ConsumerStatefulWidget {
  final Customer? existingCustomer;

  const AddCustomerSheet({super.key, this.existingCustomer});

  @override
  ConsumerState<AddCustomerSheet> createState() => _AddCustomerSheetState();
}

class _AddCustomerSheetState extends ConsumerState<AddCustomerSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _balanceController;
  late TextEditingController _phoneController;
  DateTime? _taskStartDate;
  int? _taskTotalDays;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.existingCustomer?.name ?? '',
    );
    _balanceController = TextEditingController(
      text: widget.existingCustomer?.balance.toString() ?? '',
    );
    _phoneController = TextEditingController(
      text: widget.existingCustomer?.phone ?? '',
    );
    _taskStartDate = widget.existingCustomer?.taskStartDate;
    _taskTotalDays = widget.existingCustomer?.taskTotalDays;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _taskStartDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _taskStartDate = picked);
    }
  }

  Future<void> _saveCustomer() async {
    if (_formKey.currentState?.validate() ?? false) {
      final customer = Customer(
        id: widget.existingCustomer?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        balance: double.parse(_balanceController.text),
        phone: _phoneController.text.isNotEmpty ? _phoneController.text : null,
        taskStartDate: _taskStartDate,
        taskTotalDays: _taskTotalDays,
      );

      if (widget.existingCustomer == null) {
        await ref.read(customerViewModelProvider.notifier).addCustomer(customer);
      } else {
        await ref.read(customerViewModelProvider.notifier).updateCustomer(customer);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ref.watch(responsiveProvider);
    
    final theme = ref.watch(themeDataProvider);
    
    return Dialog(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: responsive.paddingAll(16),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                title: Text(widget.existingCustomer == null ? 'Add Customer' : 'Edit Customer'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.save),
                    onPressed: _saveCustomer,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name*'),
                      validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                    ),
                    TextFormField(
                      controller: _balanceController,
                      decoration: const InputDecoration(labelText: 'Balance*'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value?.isEmpty ?? true) return 'Required';
                        if (double.tryParse(value!) == null) return 'Invalid number';
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(labelText: 'Phone'),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    // Task Management Section
                    if (_taskStartDate != null && _taskTotalDays != null)
                      TimerProgressCard(
                        startDate: _taskStartDate!,
                        totalDays: _taskTotalDays!,
                      ),
                    ListTile(
                      title: const Text('Task Start Date'),
                      subtitle: Text(_taskStartDate != null
                          ? DateFormat.yMd().format(_taskStartDate!)
                          : 'Not set'),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () => _selectDate(context),
                    ),
                    DropdownButtonFormField<int>(
                      value: _taskTotalDays,
                      hint: const Text('Select task duration'),
                      items: List.generate(30, (i) => i + 1)
                          .map((days) => DropdownMenuItem(
                                value: days,
                                child: Text('$days days'),
                              ))
                          .toList(),
                      onChanged: (value) => setState(() => _taskTotalDays = value),
                    ),
                    if (widget.existingCustomer != null)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _taskStartDate = null;
                            _taskTotalDays = null;
                          });
                        },
                        child: const Text(
                          'Remove Task',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      Row(
                        children: [
                          CustomButton(text: "text",
                           textColor: theme.colorScheme.onPrimary,
                            backgroundColor: theme.colorScheme.primary,),
                          const Spacer(),
                          TextButton(onPressed: _saveCustomer, child: const Text('Save')),
                        ],
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}