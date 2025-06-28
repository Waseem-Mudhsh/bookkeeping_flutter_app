import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/base_layout/base_layout_screen.dart';
import '../../../../core/base_layout/build_non_tabbar_layout.dart';
import '../../../../core/providers/responsive_notifier.dart';
import '../../../../core/providers/theme_data_provider.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_drop_down.dart';
import '../../../../core/widgets/custom_icon_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/responsive_space.dart';
import '../../../Currencies/domain/entities/currency.dart';
import '../../../Currencies/presentation/providers/currency_provider.dart';
import '../../domain/entities/customer.dart';
import '../providers/customer_provider.dart';


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
  late TextEditingController _dateController;
   late List<Currency> currencies = [];
  late  Currency currencySelected;
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
    currencies = ref.read(currencyListProvider);
    if (currencies.isNotEmpty) {
    currencySelected = currencies.first;
  }
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
    _currencyValue = widget.existingCustomer?.currency ?? currencies[0].toString();
   
    _taskStartDate = widget.existingCustomer?.taskStartDate;
    _taskTotalDays = widget.existingCustomer?.taskTotalDays;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    _phoneController.dispose();
    _dateController.dispose();
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

  String? _validateCurrency(Currency? value) {
    if (value == null ) {
      return 'يرجى اختيار العملة';
    }
    return null;
  }
  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال رقم الهاتف';
    }
    if (value.length < 9) {
      return 'رقم الهاتف يجب أن يكون 9 أرقام على الأقل';
    }
    return null;
  }
  

  @override
  Widget build(BuildContext context) {
    final responsive = ref.watch(responsiveProvider);
    final theme = ref.watch(themeDataProvider);

    return BaseLayoutScreen(
     
      body: BuildNonTabbarLayout(
        title: widget.existingCustomer == null ? 'إضافة عميل' : 'تعديل عميل',
        actions: [
          CustomIconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_outlined),
          ),
        ],
        slivers:[
          SliverToBoxAdapter(
            child: Form(
            key: _formKey,
            
            child: Padding(
              padding: responsive.paddingSym(h: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ResponsiveSpace(height: 16),
                   CustomAutoSizeText(
                                text: 'البيانات الأساسية',
                                style: theme.textTheme.bodyMedium,
                                fontSize: 14,
                                colorText: theme.colorScheme.primary,
                              ),
                              const ResponsiveSpace(height: 8),
                  ResponsiveSpace(
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: theme.colorScheme.primary,
                          width: responsive.w(0.5),
                        ),
                        
                      ),
                      child: Padding(
                          padding: responsive.paddingAll(16),
                          child: Column(
                            children: [
                             
                              CustomTextField(
                                
                                controller: _nameController,
                                label: 'اسم العميل',
                                hint: 'ادخل اسم العميل',
                                validator: _validateName,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () => _nameController.clear(),
                                ),
                              ),
                              const ResponsiveSpace(height: 16),
                              CustomTextField(
                                controller: _phoneController,
                                label: 'هاتف',
                                hint: 'أدخل رقم الهاتف',
                                keyboardType: TextInputType.phone,
                                validator: _validatePhone,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () => _phoneController.clear(),
                                ),
                              ),
                              
                              
                            ],
                          ),
                        )
                    ),
                  ),
                  const ResponsiveSpace(height: 16),
                  CustomTextField(
                    controller: _balanceController,
                    label: 'الرصيد',
                    hint: 'أدخل الرصيد',
                    keyboardType: TextInputType.number,
                    validator: _validateAmount,
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.calculate_outlined,
                        color: theme.colorScheme.primary,
                      ),
                      onPressed: () {
                        // Handle calculation logic here
                      },
                    ),
                  ),
                  
                  
                  const ResponsiveSpace(height: 16),
                  DropdownButtonFormField<Currency>(
                    
                    decoration:  InputDecoration(
                       fillColor:theme.colorScheme.surface,
                       constraints: BoxConstraints(
                        minHeight: responsive.h(50),
                        maxHeight: responsive.h(100),
                      ),
                      labelText: 'العملة',
                      hintText: 'اختر العملة',
                     border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        borderSide: BorderSide(
                          color: theme.colorScheme.primary,
                          width: responsive.w(1),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      
                      
                      ),
                    // value: currencySelected,
                    // hint: const Text('اختر العملة'),
                    items: currencies
                        .map(
                          (currency) => DropdownMenuItem(
                            value: currency,
                            child: Text(currency.name.toString()),
                          ),
                        ).toList(),
                    onChanged: (value) {
                      setState(() {
                       
                        currencySelected = value!;
                      });
                    },
                    validator: _validateCurrency,
                  ),
                  // Task Management Section
                  // if (_taskStartDate != null && _taskTotalDays != null)
                  //   TimerProgressCard(
                  //     startDate: _taskStartDate!,
                  //     totalDays: _taskTotalDays!,
                  //   ),
                  // CustomDropdown(),
                  ListTile(
                    title: const Text('تاريخ بداية المهمة'),
                    subtitle: Text(
                      _taskStartDate != null
                          ? DateFormat.yMd().format(_taskStartDate!)
                          : 'غير محدد',
                    ),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () => _selectDate(context),
                  ),
                  DropdownButtonFormField<int>(
                    value: _taskTotalDays,
                    hint: const Text('اختر مدة المهمة'),
                    items:
                        List.generate(30, (i) => i + 1)
                            .map(
                              (days) => DropdownMenuItem(
                                value: days,
                                child: Text('$days يوم'),
                              ),
                            )
                            .toList(),
                    onChanged:
                        (value) => setState(() => _taskTotalDays = value),
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
                        'حذف المهمة',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      CustomButton(
                        text: "إلغاء",
                        textColor: theme.colorScheme.surfaceDim,
                        backgroundColor: theme.colorScheme.surfaceBright,
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      CustomButton(
                        text: "حفظ",
                        textColor: theme.colorScheme.onPrimary,
                        backgroundColor: theme.colorScheme.primary,
                        // isLoading: _isSaving, // أضف هذه السطر
                        onPressed: _saveCustomer,
                      ),
                    ],
                  ),
                ],
              ),
            ),
                    ),
          )
        ] ,
      ),
    );
  }
}
