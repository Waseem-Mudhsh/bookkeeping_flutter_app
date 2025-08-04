import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/base_layout/base_layout_screen.dart';
import '../../../../core/base_layout/build_non_tabbar_layout.dart';
import '../../../../core/providers/responsive_notifier.dart';
import '../../../../core/providers/theme_data_provider.dart';
import '../../../../core/utils/responsive_values.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_dropdown_widget.dart';
import '../../../../core/widgets/custom_overlay.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/responsive_space.dart';
import '../../../Accounts/domain/entities/account.dart';
import '../../../Currencies/domain/entities/currency.dart';
import '../../../Currencies/presentation/providers/currency_provider.dart';
import '../../domain/entities/customer.dart';
import '../providers/customer_provider.dart';

class AddNewCustomerSheet extends ConsumerStatefulWidget {
  final Customer? existingCustomer;

  const AddNewCustomerSheet({super.key, this.existingCustomer});

  @override
  ConsumerState<AddNewCustomerSheet> createState() =>
      _AddNewCustomerSheetState();
}

class _AddNewCustomerSheetState extends ConsumerState<AddNewCustomerSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _balanceController;
  late TextEditingController _phoneController;
  late TextEditingController _dateController;
  late List<Currency> currencies = [];
  late Currency currencySelected;
  DateTime? _taskStartDate;
  int? _taskTotalDays;
  bool _isSaving = false;
  late List<Account> listMockAccounts = []; //SubAccountModel
  String? subAccountSelected;
  String? currentOption;
  String? debtorOption;
  bool? _isNotificationEnabled = false;
  int selectedIndex = 0;
  final List<String> buttons = [
    'العملاء',
    'الموردين',
    'الرواتب',
    'الضرائب',
    'المصروفات',
  ];

  @override
  void initState() {
    super.initState();

    currencies = ref.read(currencyListProvider);
    if (currencies.isNotEmpty) {
      currencySelected = currencies.first;
    }
    listMockAccounts = mockAccounts;
    if (listMockAccounts.isNotEmpty) {
      subAccountSelected = listMockAccounts.first.category;
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
      text:
          widget.existingCustomer?.taskStartDate != null
              ? DateFormat(
                'dd-MM-yyyy',
              ).format(widget.existingCustomer!.taskStartDate!)
              : '',
    );

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
      showTemporaryMessage(context, 'جاري الحفظ...');

      final customer = Customer(
        id:
            widget.existingCustomer?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        balance: double.parse(_balanceController.text),
        phone: _phoneController.text.isNotEmpty ? _phoneController.text : null,
        taskStartDate: _taskStartDate,
        taskTotalDays: _taskTotalDays,
        currency: currencySelected.name,
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
        showConfirmationDialog(
          context: context,
          title: 'إضافة عملية جديدة',
          // هنا يمكنك تخصيص المحتوى كما تريد
          // يمكنك استخدام CustomAutoSizeText أو أي Widget آخر
          // لعرض محتوى مخصص في نافذة التأكيد
          // على سبيل المثال:
          // content: CustomAutoSizeText(
          //   text: 'هل تريد إضافة عملية جديدة لهذا العميل؟',
          //   style: TextStyle(fontSize: 14),
          // ),
          content: CustomAutoSizeText(
            text: 'هل تريد إضافة عملية جديدة لهذا العميل؟',
            fontSize: 12,
            maxLines: 2,
            fontWeight: FontWeight.w500,
          ),

          onConfirm: () {},
        );
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
    if (value == null) {
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
        title:
            widget.existingCustomer == null ? 'إضافة حساب جديد' : 'تعديل حساب',

        slivers: [
          SliverToBoxAdapter(
            child: Form(
              key: _formKey,

              child: Padding(
                padding: responsive.paddingSym(h: 16, v: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildBasicInfo(theme, responsive),
                    const ResponsiveSpace(height: 16),
                    _buildFirstProcess(theme, responsive),
                    const ResponsiveSpace(height: 16),
                    _buildAdditionalInfo(theme, responsive),

                    const ResponsiveSpace(height: 48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: "إلغاء",
                            textColor: theme.colorScheme.primary,
                            backgroundColor: theme.colorScheme.surfaceBright,
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const ResponsiveSpace(width: 16),
                        Expanded(
                          child: CustomButton(
                            text: "حفظ",
                            textColor: theme.colorScheme.onPrimary,
                            backgroundColor: theme.colorScheme.primary,
                            isLoading: _isSaving, // أضف هذه السطر
                            onPressed: () {
                              _saveCustomer();
                            },
                          ),
                        ),
                      ],
                    ),
                    const ResponsiveSpace(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfo(ThemeData theme, ResponsiveValues responsive) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: theme.colorScheme.surfaceContainerHighest,
          width: responsive.w(0.8),
        ),
      ),
      child: Padding(
        padding: responsive.paddingAll(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAutoSizeText(
              text: 'البيانات الأساسية',
              style: theme.textTheme.bodyMedium,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              colorText: theme.colorScheme.primary,
            ),
            const ResponsiveSpace(height: 12),
            CustomTextField(
              controller: _nameController,
              label: 'إسم الحساب',
              hint: 'ادخل إسم الحساب',
              validator: _validateName,
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.account_balance,
                  color: theme.colorScheme.primary,
                ),
                onPressed: () {
                  debugPrint('Open accounts');
                },
                tooltip: 'اختيار من الحسابات',
              ),
            ),
            const ResponsiveSpace(height: 12),
            CustomTextField(
              controller: _phoneController,
              label: 'هاتف',
              hint: 'أدخل رقم الهاتف',
              keyboardType: TextInputType.phone,
              validator: _validatePhone,
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.contact_phone, // أيقونة تدل على جهات الاتصال
                  color: theme.colorScheme.primary,
                ),
                onPressed: () {
                  debugPrint('Open contacts');
                },
                tooltip: 'اختيار من جهات الاتصال',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFirstProcess(ThemeData theme, ResponsiveValues responsive) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: theme.colorScheme.surfaceContainerHighest,
          width: responsive.w(0.8),
        ),
      ),
      child: Padding(
        padding: responsive.paddingAll(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAutoSizeText(
              text: 'إضافة العملية الأولى',
              style: theme.textTheme.bodyMedium,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              colorText: theme.colorScheme.primary,
            ),
            const ResponsiveSpace(height: 12),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _balanceController,
                      label: 'المبلغ ',
                      hint: 'ادخل المبلغ',
                      validator: _validateAmount,
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.calculate,
                          color: theme.colorScheme.primary,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  const ResponsiveSpace(width: 8),
                  Expanded(child: _buildCurrencyDropdown()),
                ],
              ),
            ),
            const ResponsiveSpace(height: 12),
            CustomTextField(
              controller: _phoneController,
              label: 'التفاصيل',
              hint: ' أكتب تفاصيل العملية',
              keyboardType: TextInputType.text,
              validator: _validateName,
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  color: theme.colorScheme.primary,
                ),
                onPressed: () {},
              ),
            ),
            const ResponsiveSpace(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Expanded(
                  child: CustomTextField(
                    controller: _dateController,
                    label: 'تاريخ العملية',
                    hint: 'DD/MM/YYYY',
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: theme.colorScheme.primary,
                    ),
                    readOnly: true,
                    onTap: () => _selectDate(context),
                  ),
                ),
                const ResponsiveSpace(width: 2),
                Expanded(child: _buildCkickBox(theme, responsive)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalInfo(ThemeData theme, ResponsiveValues responsive) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: theme.colorScheme.surfaceContainerHighest,
          width: responsive.w(0.8),
        ),
      ),
      child: CustomExpansionTile(
        title: 'البيانات الإضافية',
        subtitle: 'اختياري',
        isExpanded: false,
        children: [
          const ResponsiveSpace(height: 16),
          CustomAutoSizeText(
            text: ' اختر نوع التصنيف',
            style: theme.textTheme.bodyMedium,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.right,
            colorText: theme.colorScheme.secondary,
          ),
          const ResponsiveSpace(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...List.generate(buttons.length, (index) {
                final isSelected = index == selectedIndex;
                return ChoiceChip(
                  showCheckmark: false,
                  label: Text(buttons[index]),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  selectedColor: theme.colorScheme.secondary,
                  backgroundColor: theme.colorScheme.surface,
                  labelStyle: theme.textTheme.bodyMedium!.copyWith(
                    color:
                        isSelected
                            ? theme.colorScheme.onSecondary
                            : theme.colorScheme.onSurface,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                );
              }),
            ],
          ),
          const ResponsiveSpace(height: 12),
          CustomTextField(
            controller: _balanceController,
            label: 'العنوان',
            hint: 'أدخل العنوان',
            keyboardType: TextInputType.text,

            suffixIcon: IconButton(
              icon: Icon(
                Icons.location_on,
                color: theme.colorScheme.primary,
              ),
              onPressed: () {
                // Handle calculation logic here
              },
            ),
          ),
          const ResponsiveSpace(height: 12),
          CustomTextField(
            controller: _balanceController,
            label: 'ملاحظة',
            hint: 'أكتب الملاحظة هنا...',
            keyboardType: TextInputType.text,

            suffixIcon: IconButton(
              icon: Icon(
                Icons.notes,
                color: theme.colorScheme.primary,
              ),
              onPressed: () {
                // Handle calculation logic here
              },
            ),
          ),
          const ResponsiveSpace(height: 12),
          ResponsiveSpace(
            // height: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,

              children: [
                ListTile(
                  title: CustomAutoSizeText(
                    text: 'تفعيل خدمة الاشعارات ',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    style: theme.textTheme.bodyMedium,
                    colorText: theme.colorScheme.secondary,
                  ),
                  trailing: Switch(
                    activeColor: theme.colorScheme.onSecondary,
                    activeTrackColor: theme.colorScheme.secondary,
                    value: _isNotificationEnabled!,
                    onChanged: (value) {
                      setState(() {
                        _isNotificationEnabled = value;
                      });
                    },
                  ),
                ),

                ResponsiveSpace(height: 4),

                if (_isNotificationEnabled!)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Expanded(
                        child: ListTile(
                          title: CustomAutoSizeText(
                            text: ' الواتساب',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            style: theme.textTheme.bodySmall,
                            colorText: theme.colorScheme.onSurface,
                          ),
                          leading: Radio(
                            value: ' الواتساب',
                            fillColor: WidgetStateProperty.all(
                              theme.colorScheme.secondary,
                            ),
                            activeColor: theme.colorScheme.onSecondary,
                            groupValue: currentOption,
                            onChanged: (value) {
                              setState(() {
                                currentOption = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: CustomAutoSizeText(
                            text: 'رسالة نصية',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            style: theme.textTheme.bodySmall,
                            colorText: theme.colorScheme.onSurface,
                          ),
                          leading: Radio(
                            value: 'رسالة نصية',
                            fillColor: WidgetStateProperty.all(
                              theme.colorScheme.secondary,
                            ),
                            activeColor: theme.colorScheme.onSecondary,
                            groupValue: currentOption,
                            onChanged: (value) {
                              setState(() {
                                currentOption = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyDropdown() {
    return TextFieldLikeDropdown<Currency>(
      items:
          currencies
              .map(
                (currency) => DropdownMenuItem(
                  value: currency,
                  child: Text(currency.name.toString()),
                ),
              )
              .toList(),
      // value: currencySelected,
      onChanged: (value) => setState(() => currencySelected = value!),
      hintText: 'اختر العملة', // Behaves like TextField hint
      labelText: 'العملة',
       prefixIcon: Icon(Icons.currency_exchange_outlined), // Floats up like TextField label
    );
  }

  Widget _buildCkickBox(ThemeData theme, ResponsiveValues responsive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: InkWell(
            onTap: () => setState(() => debtorOption = ' له'),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: ' له',
                  groupValue: debtorOption,
                  fillColor: WidgetStateProperty.all(Colors.green.shade600),
                  activeColor: Colors.green.shade600,
                  onChanged: (value) {
                    setState(() {
                      debtorOption = value;
                    });
                  },
                ),
                const SizedBox(width: 4),
                CustomAutoSizeText(
                  text: ' له',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  style: theme.textTheme.bodySmall,
                  colorText: theme.colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () => setState(() => debtorOption = ' عليه'),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: ' عليه',
                  groupValue: debtorOption,
                  fillColor: WidgetStateProperty.all(theme.colorScheme.error),
                  activeColor: theme.colorScheme.error,
                  onChanged: (value) {
                    setState(() {
                      debtorOption = value;
                    });
                  },
                ),
                const SizedBox(width: 4),
                CustomAutoSizeText(
                  text: ' عليه',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  style: theme.textTheme.bodySmall,
                  colorText: theme.colorScheme.onSurface,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
