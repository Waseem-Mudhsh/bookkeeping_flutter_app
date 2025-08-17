// filepath: c:/Users/Waseem/Documents/Bookkeeping flutter app/bookkeeping_flutter_app/lib/features/Transactions/presentation/widgets/add_transaction_form.dart
import 'package:bookkeeping_flutter_app/core/base_layout/base_layout_screen.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
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
    TransactionType? transactionTypeSelected;
    bool _isSaving = false;

    @override
    void initState() {
        super.initState();

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
                type: transactionTypeSelected ?? TransactionType.debit,
                currency: currencySelected.code,
                referenceNumber: widget.existingTransaction?.referenceNumber ?? '',
            );

            if (widget.existingTransaction == null) {
                await ref.read(transactionViewModelProvider(widget.accountId).notifier).addTransaction(transaction);
            } else {
                await ref.read(transactionViewModelProvider(widget.accountId).notifier).updateTransaction(transaction);
            }

            if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: CustomAutoSizeText(
                            text: widget.existingTransaction == null
                                    ? 'تم إضافة العملية بنجاح!'
                                    : 'تم تعديل العملية بنجاح!',
                            colorText: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Cairo',
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
        );
        if (picked != null) {
            _dateController.text = DateFormat('dd-MM-yyyy').format(picked);
        }
    }

    String? _validateAmount(String? value) {
        if (value == null || value.isEmpty) return 'يرجى إدخال المبلغ';
        if (double.tryParse(value) == null) return 'يرجى إدخال رقم صحيح';
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
        } catch (e) {
            return 'تاريخ غير صالح';
        }
        return null;
    }

    @override
    Widget build(BuildContext context) {
        final responsive = ref.watch(responsiveProvider);
        final theme = ref.watch(themeDataProvider);

        return BaseLayoutScreen(
            
            body: BuildNonTabbarLayout(
               title: widget.existingTransaction == null ? 'إضافة عملية جديدة' : 'تعديل العملية',
                slivers:[ SliverToBoxAdapter(
                  child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: responsive.paddingSym(v: 16.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: theme.colorScheme.surface,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: theme.colorScheme.surfaceContainerHighest,
                                            width: responsive.w(0.8),
                                        ),
                                    ),
                                    padding: responsive.paddingAll(16),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            CustomAutoSizeText(
                                                text: 'بيانات العملية',
                                                style: theme.textTheme.bodyMedium,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                colorText: theme.colorScheme.primary,
                                            ),
                                            const ResponsiveSpace(height: 12),
                                            Row(
                                                children: [
                                                    Expanded(
                                                        child: CustomTextField(
                                                            controller: _amountController,
                                                            label: 'المبلغ',
                                                            hint: 'ادخل المبلغ',
                                                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                            validator: _validateAmount,
                                                            suffixIcon: IconButton(
                                                                icon: Icon(Icons.calculate, color: theme.colorScheme.primary),
                                                                onPressed: () {},
                                                                tooltip: 'فتح الحاسبة',
                                                            ),
                                                        ),
                                                    ),
                                                    const ResponsiveSpace(width: 16),
                                                    Expanded(child: _buildCurrencyDropdown(theme, responsive)),
                                                ],
                                            ),
                                            const ResponsiveSpace(height: 16),
                                            CustomTextField(
                                                controller: _detailsController,
                                                label: 'التفاصيل',
                                                hint: 'أكتب تفاصيل العملية',
                                                keyboardType: TextInputType.text,
                                                validator: _validateDetails,
                                                suffixIcon: IconButton(
                                                    icon: Icon(Icons.camera_alt, color: theme.colorScheme.primary),
                                                    onPressed: () {},
                                                ),
                                            ),
                                            const ResponsiveSpace(height: 16),
                                            Row(
                                                children: [
                                                    Expanded(
                                                        child: CustomTextField(
                                                            controller: _dateController,
                                                            validator: _validateDate,
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
                                                    Expanded(child: _buildTransactionTypeRadio(theme)),
                                                ],
                                            ),
                                        ],
                                    ),
                                ),
                                ResponsiveSpace(height: responsive.h(48)),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                        Expanded(
                                            child: CustomButton(
                                                text: "إلغاء",
                                                textColor: theme.colorScheme.primary,
                                                backgroundColor: theme.colorScheme.surfaceBright,
                                                onPressed: () => Navigator.pop(context),
                                            ),
                                        ),
                                        ResponsiveSpace(width: responsive.w(16)),
                                        Expanded(
                                            child: CustomButton(
                                                text: "حفظ",
                                                textColor: theme.colorScheme.onPrimary,
                                                backgroundColor: theme.colorScheme.primary,
                                                isLoading: _isSaving,
                                                onPressed: _saveTransaction,
                                            ),
                                        ),
                                    ],
                                ),
                                ResponsiveSpace(height: responsive.h(8)),
                            ],
                        ),
                      ),
                  ),
                ),
                ]
            ),
        );
    }

    Widget _buildCurrencyDropdown(ThemeData theme, ResponsiveValues responsive) {
        return CustomTextFieldDropdown<Currency>(
            items: currencies
                    .map(
                        (currency) => DropdownMenuItem(
                            value: currency,
                            child: CustomAutoSizeText(
                                text: '${currency.name} (${currency.code})',
                                fontSize: 14,
                                colorText: theme.colorScheme.onSurface,
                            ),
                        ),
                    )
                    .toList(),
            value: currencySelected,
            onChanged: (value) => setState(() => currencySelected = value!),
            hintText: 'اختر العملة',
            labelText: 'العملة',
            validator: (value) => value == null ? 'العملة مطلوبة' : null,
            prefixIcon: Icon(
                Icons.currency_exchange_outlined,
                color: theme.colorScheme.primary,
            ),
        );
    }

    Widget _buildTransactionTypeRadio(ThemeData theme) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                Expanded(
                    child: InkWell(
                        onTap: () => setState(() => transactionTypeSelected = TransactionType.debit),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Radio<TransactionType>(
                                    value: TransactionType.debit,
                                    groupValue: transactionTypeSelected,
                                    fillColor: WidgetStateProperty.all(Colors.green.shade600),
                                    activeColor: Colors.green.shade600,
                                    onChanged: (value) {
                                        setState(() {
                                            transactionTypeSelected = value;
                                        });
                                    },
                                ),
                                const SizedBox(width: 4),
                                CustomAutoSizeText(
                                    text: 'له',
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
                        onTap: () => setState(() => transactionTypeSelected = TransactionType.credit),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Radio<TransactionType>(
                                    value: TransactionType.credit,
                                    groupValue: transactionTypeSelected,
                                    fillColor: WidgetStateProperty.all(theme.colorScheme.error),
                                    activeColor: theme.colorScheme.error,
                                    onChanged: (value) {
                                        setState(() {
                                            transactionTypeSelected = value;
                                        });
                                    },
                                ),
                                const SizedBox(width: 4),
                                CustomAutoSizeText(
                                    text: 'عليه',
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