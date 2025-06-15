import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../features/Customers/domain/entities/customer.dart';
import '../../features/Customers/presentation/providers/customer_provider.dart';

class InputForm extends ConsumerStatefulWidget {
  final Customer? existingCustomer;
  const InputForm({super.key, this.existingCustomer});

  @override
  ConsumerState<InputForm> createState() => _InputFormState();
}

class _InputFormState extends ConsumerState<InputForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _balanceController;
  late TextEditingController _phoneController;
  late TextEditingController _dateController;
  DateTime? _taskStartDate;
  int? _taskTotalDays;
  bool _isSaving = false;
  String? _currencyValue;

  final List<String> _currencies = [
    'ريال سعودي',
    'درهم',
  ];
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
    _dateController = TextEditingController(
      text: widget.existingCustomer?.taskStartDate != null
          ? DateFormat('dd-MM-yyyy').format(widget.existingCustomer!.taskStartDate!)
          : '',
    );
    _currencyValue = widget.existingCustomer?.currency ?? _currencies[0];
   
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

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2100),
  //   );
    
  //   if (picked != null) {
  //     setState(() {
  //       _dateController.text = DateFormat('dd-MM-yyyy').format(picked);
  //     });
  //   }
  // }

  // void _submitForm() {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() => _isSubmitting = true);
      
  //     // Simulate API call
  //     Future.delayed(const Duration(seconds: 2), () {
  //       setState(() => _isSubmitting = false);
  //       Navigator.of(context).pop();
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('تم حفظ البيانات بنجاح')),
  //       );
  //     });
  //   }
  // }

   Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _taskStartDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _taskStartDate = picked);
      _dateController.text = DateFormat('dd-MM-yyyy').format(picked);
    }
    
  }

  Future<void> _saveCustomer() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() => _isSaving = true);

    try {
      final customer = Customer(
        id:
            widget.existingCustomer?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        balance: double.parse(_balanceController.text),
        phone: _phoneController.text.isNotEmpty ? _phoneController.text : null,
        taskStartDate: _taskStartDate,
        taskTotalDays: _taskTotalDays,
      );

      if (widget.existingCustomer == null) {
        await ref
            .read(customerViewModelProvider.notifier)
            .addCustomer(customer);
      } else {
        await ref
            .read(customerViewModelProvider.notifier)
            .updateCustomer(customer);
      }

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطأ أثناء الحفظ: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }


  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'هذا الحقل مطلوب';
    }
    return null;
  }

  String? _validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال المبلغ';
    }
    if (double.tryParse(value) == null) {
      return 'يرجى إدخال رقم صحيح';
    }
    return null;
  }

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال التاريخ';
    }
    try {

      DateFormat('dd-MM-yyyy').parseStrict(value);
      
    } catch (e) {
      return 'تاريخ غير صالح';
    }
    return null;
  }

  String? _validateCurrency(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى اختيار العملة';
    }
    return null;
  }
  

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             AppBar(
                title: Text(
                  widget.existingCustomer == null ? 'إضافة عميل' : 'تعديل عميل',
                ),
                centerTitle: true,
              ),
            _buildTextField(
              controller: _nameController,
              label: 'اسم العميل',
              validator: _validateName,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _balanceController,
              label: 'المبلغ',
              keyboardType: TextInputType.number,
              validator: _validateAmount,
            ),
            const SizedBox(height: 16),
            // _buildTextField(
            //   controller: _phoneController,
            //   label: 'رقم الهاتف',
            //   keyboardType: TextInputType.phone,
            //   validator: (value) {
            //     if (value != null && value.isNotEmpty && value.length < 10) {
            //       return 'رقم الهاتف غير صالح';
            //     }
            //     return null;
            //   },
            // ),
            // const SizedBox(height: 16),
            _buildDateField(context),
            const SizedBox(height: 16),
            _buildCurrencyDropdown(),
            const SizedBox(height: 24),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        errorMaxLines: 2,
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  Widget _buildDateField(BuildContext context) {
    return TextFormField(
      controller: _dateController,
      decoration: InputDecoration(
        labelText: 'التاريخ',
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () => _selectDate(context),
        ),
        errorMaxLines: 2,
      ),
      readOnly: true,
      validator: _validateDate,
    );
  }

  Widget _buildCurrencyDropdown() {
    return DropdownButtonFormField<String>(
      value: _currencyValue,
      decoration: const InputDecoration(
        labelText: 'العملة',
        border: OutlineInputBorder(),
        errorMaxLines: 2,
      ),
      items: _currencies.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _currencyValue = newValue;
        });
      },
      validator: _validateCurrency,
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _isSaving ? null : _saveCustomer,
      child: _isSaving
          ? const CircularProgressIndicator()
          : const Text('حفظ'),
    );
  }
  
}

