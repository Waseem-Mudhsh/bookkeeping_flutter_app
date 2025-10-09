import 'package:bookkeeping_flutter_app/core/base_layout/base_layout_screen.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_text_form_field.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_text_field_dropdown.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:bookkeeping_flutter_app/core/providers/responsive_notifier.dart';
import 'package:bookkeeping_flutter_app/core/providers/theme_data_provider.dart';
import 'package:bookkeeping_flutter_app/core/utils/id_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import '../../../../core/base_layout/build_non_tabbar_layout.dart';
import '../../../../core/utils/responsive_values.dart';
import '../../../Currencies/domain/entities/currency.dart';
import '../../../Currencies/presentation/providers/currency_provider.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/transaction_type.dart';
import '../Providers/transaction_provider.dart';

class AddTransactionForm extends ConsumerStatefulWidget {
  final Transaction? existingTransaction;
  final String accountId;

  const AddTransactionForm({
    super.key,
    required this.accountId,
    this.existingTransaction,
  });

  @override
  ConsumerState<AddTransactionForm> createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends ConsumerState<AddTransactionForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _amountController;
  late TextEditingController _detailsController;
  late TextEditingController _dateController;
  
  late List<Currency> currencies;
  late Currency currencySelected;
  late List<String> buyers;
  late String buyerSelected;
  TransactionType? transactionTypeSelected;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _initializeState();
  }

  void _initializeState() {
    // Currency Initialization (Original logic preserved)
    currencies = ref.read(currencyListProvider);
    if (currencies.isEmpty) {
      currencies = [
        Currency(code: 'USD', name: 'دولار أمريكي', flagUrl: 'assets/flags/us.png'),
        Currency(code: 'YER', name: 'ريال يمني', flagUrl: 'assets/flags/ye.png'),
        Currency(code: 'SAR', name: 'ريال سعودي', flagUrl: 'assets/flags/sa.png'),
      ];
    }
    currencySelected = currencies.firstWhere(
      (c) => c.code == (widget.existingTransaction?.currency ?? currencies.first.code),
      orElse: () => currencies.first,
    );
    
    buyers =[
      'محمد',
      'عمر',
      'حسن',
      'سامح',
    ];
    buyerSelected = widget.existingTransaction?.buyer ?? buyers.first;

    // Controller Initialization
    _amountController = TextEditingController(
      text: widget.existingTransaction?.amount.toStringAsFixed(2) ?? '',
    );
    
    _detailsController = TextEditingController(
      text: widget.existingTransaction?.description ?? '',
    );
    _dateController = TextEditingController(
      text: widget.existingTransaction != null
          ? DateFormat('dd-MM-yyyy').format(widget.existingTransaction!.date)
          : DateFormat('dd-MM-yyyy').format(DateTime.now()),
    );
    transactionTypeSelected = widget.existingTransaction?.type ?? TransactionType.debit;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _detailsController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  // --- BUSINESS LOGIC ---

  Future<void> _saveTransaction() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _isSaving = true);

    try {
      DateFormat dateFormat = DateFormat('dd-MM-yyyy');
      final transaction = Transaction(
        id: widget.existingTransaction?.id ?? IdGenerator.generateCompactId(prefix: 'txn_'),
        accountId: widget.accountId,
        amount: double.parse(_amountController.text),
        date: dateFormat.parse(_dateController.text),
        description: _detailsController.text,
        type: transactionTypeSelected!,
        currency: currencySelected.code,
        referenceNumber: widget.existingTransaction?.referenceNumber ?? '',
        buyer: buyerSelected
      );

      final transactionNotifier = ref.read(transactionViewModelProvider(widget.accountId).notifier);

      if (widget.existingTransaction == null) {
        await transactionNotifier.addTransaction(transaction);
      } else {
        await transactionNotifier.updateTransaction(transaction);
      }

      if (mounted) {
        // In a real app, use a proper overlay or toast for messages
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomAutoSizeText(
             text: widget.existingTransaction == null
                  ? 'تم إضافة العملية بنجاح!'
                  : 'تم تعديل العملية بنجاح!',
                fontSize: 10,
                colorText: Colors.white,
            ),
            backgroundColor: Colors.green,
          ),
        );
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
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      // Styling the DatePicker for a professional look
      builder: (context, child) {
        final theme = Theme.of(context);
        return Theme(
          data: theme.copyWith(
            colorScheme: ColorScheme.light(
              primary: theme.colorScheme.primary, // Header background color
              onPrimary: theme.colorScheme.onPrimary, // Text color for selected date
              onSurface: theme.colorScheme.onSurface, // Text color for dates
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.primary, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      _dateController.text = DateFormat('dd-MM-yyyy').format(picked);
      _formKey.currentState?.validate(); // Re-validate after selecting date
    }
  }

  // --- VALIDATORS ---

  String? _validateAmount(String? value) {
    if (value == null || value.isEmpty) return 'يرجى إدخال المبلغ';
    if (double.tryParse(value) == null || double.parse(value) <= 0) return 'يرجى إدخال رقم صحيح وموجب';
    return null;
  }

  String? _validateDetails(String? value) {
    if (value == null || value.isEmpty) return 'يرجى إدخال التفاصيل';
    return null;
  }

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) return 'يرجى إدخال التاريخ';
    try {
      DateFormat('dd-MM-yyyy').parseStrict(value);
    } catch (_) {
      return 'تاريخ غير صالح';
    }
    return null;
  }

  // --- UI BUILDING ---

  @override
  Widget build(BuildContext context) {
    final responsive = ref.watch(responsiveProvider);
    final theme = ref.watch(themeDataProvider);

    return BaseLayoutScreen(
      body: BuildNonTabbarLayout(
        // Modern Typography: Use a larger, bolder title
        titleWidget: _TransactionHeader(
          isEditing: widget.existingTransaction != null,
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: responsive.paddingSym( v: 24.0), // Increased vertical padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Modular Input Section
                    _TransactionInputSection(
                      amountController: _amountController,
                      detailsController: _detailsController,
                      dateController: _dateController,
                      currencies: currencies,
                      selectedCurrency: currencySelected,
                      onCurrencyChanged: (value) => setState(() => currencySelected = value!),
                      transactionTypeSelected: transactionTypeSelected,
                      onTransactionTypeChanged: (value) => setState(() => transactionTypeSelected = value),
                      selectDate: () => _selectDate(context),
                      validateAmount: _validateAmount,
                      validateDetails: _validateDetails,
                      validateDate: _validateDate,
                      buyers: buyers,
                      selectedBuyer: buyerSelected,
                      onBuyerChanged: (value) => setState(() => buyerSelected = value.toString()),
                    ),

                    ResponsiveSpace(height: responsive.h(48)),

                    // Modular Action Buttons
                    _ActionButtons(
                      theme: theme,
                      responsive: responsive,
                      isSaving: _isSaving,
                      onCancel: () => Navigator.pop(context),
                      onSave: _saveTransaction,
                    ),

                    ResponsiveSpace(height: responsive.h(8)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ====================================================================
// --- MODULAR WIDGETS ---
// ====================================================================

// 1. Transaction Header
class _TransactionHeader extends StatelessWidget {
  final bool isEditing;
  const _TransactionHeader({required this.isEditing});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomAutoSizeText(
      text: isEditing ? 'تعديل العملية' : 'إضافة عملية جديدة',
      style: theme.textTheme.bodyMedium,
      fontWeight: FontWeight.w800, // Extra bold for modern typography
      fontSize: 14, // Larger font size
      colorText: theme.colorScheme.primary,
    );
  }
}

// ---
// 2. Transaction Input Section
class _TransactionInputSection extends ConsumerWidget {
  final TextEditingController amountController;
  final TextEditingController detailsController;
  final TextEditingController dateController;
  final List<Currency> currencies;
  final Currency selectedCurrency;
  final ValueChanged<Currency?> onCurrencyChanged;
  final TransactionType? transactionTypeSelected;
  final List<String> buyers;
  final String selectedBuyer;
  final ValueChanged<String?> onBuyerChanged;
  final ValueChanged<TransactionType?> onTransactionTypeChanged;
  final VoidCallback selectDate;
  final FormFieldValidator<String> validateAmount;
  final FormFieldValidator<String> validateDetails;
  final FormFieldValidator<String> validateDate;


  const _TransactionInputSection({
    required this.amountController,
    required this.detailsController,
    required this.dateController,
    required this.currencies,
    required this.selectedCurrency,
    required this.onCurrencyChanged,
    required this.transactionTypeSelected,
    required this.onTransactionTypeChanged,
    required this.onBuyerChanged,
    required this.buyers,
    required this.selectedBuyer,
    required this.selectDate,
    required this.validateAmount,
    required this.validateDetails,
    required this.validateDate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    final responsive = ref.responsive;

    return Card(
      elevation: 6, // Increased elevation for a modern, floating effect
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // Rounded corners
      margin: EdgeInsets.zero,
      child: Padding(
        padding: responsive.paddingAll(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAutoSizeText(
              text: 'بيانات العملية',
              style: theme.textTheme.titleMedium,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              colorText: theme.colorScheme.onSurface,
            ),
            const ResponsiveSpace(height: 16),
            // Dropdown for Buyer
            _buildBuyerDropdown(theme),
            const ResponsiveSpace(height: 16),


            // Amount and Currency Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: CustomTextField(
                    controller: amountController,
                    label: 'المبلغ',
                    hint: 'أدخل المبلغ',
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                    ],
                    validator: validateAmount,
                    suffixIcon: IconButton(
                      icon: CustomHugeIcon(
                        icon: HugeIcons.strokeRoundedCalculator, // Updated icon for a modern look
                        color: theme.colorScheme.primary,
                      ),
                      onPressed: () {
                        // Action for opening the calculator
                      },
                      tooltip: 'فتح الحاسبة',
                    ),
                  ),
                ),
                ResponsiveSpace(width: 8),
                Expanded(
                  flex: 2,
                  child: _buildCurrencyDropdown(theme),
                ),
              ],
            ),
            const ResponsiveSpace(height: 16),

            // Details Field
            CustomTextField(
              controller: detailsController,
              label: 'التفاصيل',
              hint: 'أكتب تفاصيل العملية',
              keyboardType: TextInputType.text,
              validator: validateDetails,
              
              maxLines: 1,
              suffixIcon: IconButton(
                icon: CustomHugeIcon(
                  icon: HugeIcons.strokeRoundedGooglePhotos, // Changed to a more relevant receipt icon
                  color: theme.colorScheme.primary,
                ),
                onPressed: () {
                  // Action for attaching a receipt/photo
                },
              ),
            ),
            const ResponsiveSpace(height: 16),

            // Date and Type Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: CustomTextField(
                    controller: dateController,
                    validator: validateDate,
                    label: 'تاريخ العملية',
                    hint: 'DD-MM-YYYY',
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                    readOnly: true,
                    onTap: selectDate,
                  ),
                ),
                ResponsiveSpace(width: 8),
                Expanded(
                  flex: 1,
                  child: _TransactionTypeSelector(
                    transactionTypeSelected: transactionTypeSelected,
                    onChanged: onTransactionTypeChanged,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyDropdown(ThemeData theme) {
    return CustomTextFieldDropdown<Currency>(
      items: currencies
          .map(
            (currency) => DropdownMenuItem<Currency>(
              value: currency,
              child: CustomAutoSizeText(
                text: currency.code,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                colorText: theme.colorScheme.onSurface,
              ),
            ),
          )
          .toList(),
      value: selectedCurrency,
      onChanged: onCurrencyChanged,
      hintText: 'اختر العملة',
      labelText: 'العملة',
      validator: (value) => value == null ? 'العملة مطلوبة' : null,
    );
  }
  Widget _buildBuyerDropdown(ThemeData theme) {
  return CustomTextFieldDropdown<String>(
    items: buyers
        .map(
          (buyer) => DropdownMenuItem<String>(
            value: buyer,
            child: CustomAutoSizeText(
              text: buyer,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              colorText: theme.colorScheme.onSurface,
            ),
          ),
        )
        .toList(),
    value: selectedBuyer,
    onChanged: onBuyerChanged,
    hintText: 'اختر المستفيد',
    labelText: 'المستفيد',
    validator: (value) => value == null ? 'المستفيد مطلوب' : null,
    
  );
}
}


// ---
// 3. Transaction Type Selector (Enhanced with better design)
class _TransactionTypeSelector extends StatelessWidget {
  final TransactionType? transactionTypeSelected;
  final ValueChanged<TransactionType?> onChanged;

  const _TransactionTypeSelector({
    required this.transactionTypeSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
   
    
    return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _TransactionTypeOption(
          label: 'عليه', // دائن
          value: TransactionType.debit,
          groupValue: transactionTypeSelected,
          onChanged: onChanged,
          
        ),
        const ResponsiveSpace(width: 4),
        _TransactionTypeOption(
          label: 'له', // مدين
          value: TransactionType.credit,
          groupValue: transactionTypeSelected,
          onChanged: onChanged,
         
        ),
      ],
    );
  }
}

// ---
// 4. Reusable Animated Transaction Type Option
class _TransactionTypeOption extends StatelessWidget {
  final String label;
  final TransactionType value;
  final TransactionType? groupValue;
  final ValueChanged<TransactionType?> onChanged;

  const _TransactionTypeOption({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Radio<TransactionType>(
            value: value,
            groupValue: groupValue,
            activeColor: theme.colorScheme.secondary,
            onChanged: onChanged,
          ),
          CustomAutoSizeText(
            text: label,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            colorText: theme.colorScheme.onSurface,
          ),
        ],
      ),
    );
  }
}

// ---
// 5. Action Buttons Section
class _ActionButtons extends StatelessWidget {
  final ThemeData theme;
  final ResponsiveValues responsive;
  final bool isSaving;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const _ActionButtons({
    required this.theme,
    required this.responsive,
    required this.isSaving,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: CustomButton(
            text: "إلغاء",
            textColor: theme.colorScheme.onSurface,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            onPressed: onCancel,
            // Subtle Animation: The InkWell ripple effect is provided by CustomButton/Material widget
          ),
        ),
        ResponsiveSpace(width: responsive.w(16)),
        Expanded(
          child: CustomButton(
            text: "حفظ",
            textColor: theme.colorScheme.onPrimary,
            backgroundColor: theme.colorScheme.primary,
            isLoading: isSaving,
            onPressed: onSave,
            // Subtle Animation: Loading state provided by CustomButton
          ),
        ),
      ],
    );
  }
}