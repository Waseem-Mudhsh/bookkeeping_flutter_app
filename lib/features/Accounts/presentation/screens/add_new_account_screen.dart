import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_expansion_tile.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/domain/entities/main_account.dart';
import 'package:bookkeeping_flutter_app/features/Transactions/domain/entities/transaction_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../core/base_layout/base_layout_screen.dart';
import '../../../../core/base_layout/build_non_tabbar_layout.dart';
import '../../../../core/utils/id_generator.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field_dropdown.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/responsive_space.dart';
import '../../../Accounts/domain/entities/account.dart'; // تأكد من وجود Account entity
import '../../../Currencies/domain/entities/currency.dart';
import '../../../Currencies/presentation/providers/currency_provider.dart';
import '../providers/account_provider.dart';

// ----------------------------------------------------------------------
// Mock Data (Moved to a standard Dart file in a real app)
// ----------------------------------------------------------------------
List<Currency> mockCurrencies = [
  Currency(code: 'USD', name: 'دولار أمريكي', flagUrl: 'assets/flags/us.png'),
  Currency(code: 'YER', name: 'ريال يمني', flagUrl: 'assets/flags/ye.png'),
  Currency(code: 'SAR', name: 'ريال سعودي', flagUrl: 'assets/flags/sa.png'),
];

// ----------------------------------------------------------------------
// Main Screen Widget
// ----------------------------------------------------------------------

class AddNewAccountScreen extends ConsumerStatefulWidget {
  final Account? existingAccount;

  const AddNewAccountScreen({super.key, this.existingAccount});

  @override
  ConsumerState<AddNewAccountScreen> createState() => _AddNewAccountScreenState();
}

class _AddNewAccountScreenState extends ConsumerState<AddNewAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _balanceController;
  late TextEditingController _notesController;

  late List<MainAccountModel> listMockAccountTypes = [];
  late List<Currency> currencies = [];

  // State Variables
  late Currency currencySelected;
  MainAccountModel? accountTypeSelected;
  String? categorySelected;
  TransactionType? debtorOption;
  String? currentOption;
  bool _isNotificationEnabled = false;
  bool _isSaving = false;

  final List<String> categories = [
    'العملاء',
    'الموردين',
    'الرواتب',
    'الضرائب',
    'المصروفات',
  ];

  @override
  void initState() {
    super.initState();
    _initializeState();
  }

  void _initializeState() {
    listMockAccountTypes = mainAccounts;
    categorySelected = categories.first;

    // Currency setup
    currencies = ref.read(currencyListProvider);
    if (currencies.isEmpty) {
      currencies = mockCurrencies;
    }
    currencySelected = currencies.first;

    // Text Controller initialization
    _nameController = TextEditingController(
      text: widget.existingAccount?.name ?? '',
    );
    _balanceController = TextEditingController(
      text: (widget.existingAccount?.totalAccountBalance ?? 0.0).toStringAsFixed(0),
    );
    _notesController = TextEditingController(
      text: widget.existingAccount?.note ?? '',
    );
    _phoneController = TextEditingController(
      text: widget.existingAccount?.phoneNumber ?? '',
    );

    // Default or existing account setup
    accountTypeSelected = listMockAccountTypes.first;
    debtorOption = widget.existingAccount?.debtor != 0
        ? TransactionType.debit
        : TransactionType.credit;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    _notesController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _saveAccount() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() => _isSaving = true);

    try {
      // In a real app, use a proper overlay or toast for messages
      // showTemporaryMessage(context, 'جاري الحفظ...');

      final account = Account(
        id: widget.existingAccount?.id ?? IdGenerator.generateCompactId(prefix: 'acc_'),
        name: _nameController.text,
        totalAccountBalance: 1200.0,
        currencyCode: currencySelected.code,
        category: categorySelected!,
        note: _notesController.text.isNotEmpty ? _notesController.text : null,
        image: '',
        debtor: debtorOption == TransactionType.debit ? double.tryParse(_balanceController.text) ?? 0 : 0,
        creditor: debtorOption == TransactionType.credit ? double.tryParse(_balanceController.text) ?? 0 : 0,
        createdAt: DateTime.now(),
        mainAccountId: accountTypeSelected!.id,
        phoneNumber: _phoneController.text,
      );

      if (widget.existingAccount == null) {
        await ref.read(accountViewModelProvider.notifier).addAccount(account);
      } else {
        await ref.read(accountViewModelProvider.notifier).updateAccount(account);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomAutoSizeText(
            text:   widget.existingAccount == null ? 'تم إضافة الحساب بنجاح!' : 'تم تعديل الحساب بنجاح!',
             fontSize: 10,
             style: ref.theme.textTheme.bodySmall,
             colorText: Colors.white,
            ),
            backgroundColor:ref.theme.colorScheme.primary,
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
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'اسم الحساب مطلوب';
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
    final theme = ref.theme;
    final responsive = ref.responsive;

    return BaseLayoutScreen(
      body: BuildNonTabbarLayout(
        titleWidget: CustomAutoSizeText(
          text: widget.existingAccount == null ? 'إضافة حساب جديد' : 'تعديل حساب',
          style: theme.textTheme.bodyMedium,
          fontWeight: FontWeight.bold,
          fontSize: 12,
          colorText: theme.colorScheme.primary,
        ),
        slivers: [
          SliverToBoxAdapter(child: ResponsiveSpace(height: 16,),),
          SliverToBoxAdapter(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Basic Info Section (Modularized)
                  _AccountBasicInfoSection(
                    nameController: _nameController,
                    phoneController: _phoneController,
                    categories: categories,
                    selectedCategory: categorySelected,
                    onCategoryChanged: (value) => setState(() => categorySelected = value),
                    validateName: _validateName,
                    validatePhone: _validatePhone,
                  ),
              
                  ResponsiveSpace(height: responsive.h(20)),
              
                  
              
                  // 3. Additional Info Section (Refactored for style)
                  _buildAdditionalInfo(),
              
                  ResponsiveSpace(height: responsive.h(48)),
              
                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: "إلغاء",
                          textColor: theme.colorScheme.primary,
                          backgroundColor: theme.colorScheme.surface,
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
                          onPressed: _saveAccount,
                        ),
                      ),
                    ],
                  ),
                  ResponsiveSpace(height: responsive.h(8)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Building the additional info section using a clean Card layout
  Widget _buildAdditionalInfo() {
    final responsive = ref.responsive;
    final theme = ref.theme;
    return Container(
     decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.5), width: 0.5),
        color: theme.colorScheme.surface,
      ),
      
      margin: EdgeInsets.zero,
      child: Padding(
        padding: responsive.paddingAll(4),
        child: CustomExpansionTile(
          title: 'البيانات الإضافية',
          subtitle: 'اختياري',
          leading: HugeIcons.strokeRoundedInformationSquare,
          isExpanded: false,
          children: [
            const ResponsiveSpace(height: 12),
            CustomTextField(
              controller: _notesController,
              label: 'العنوان',
              hint: 'أضف العنوان...',
              keyboardType: TextInputType.text,
              suffixIcon: CustomHugeIcon(icon: HugeIcons.strokeRoundedLocation01, color: theme.colorScheme.primary),
            ),
            const ResponsiveSpace(height: 16),
        
            // Notification Switch & Options (using AnimatedSwitcher)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Switch Tile
                Padding(
                  padding:  responsive.paddingSym(h: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomAutoSizeText(
                        text: 'تفعيل خدمة الإشعارات',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        colorText: theme.colorScheme.onSurface,
                      ),
                      Switch(
                        value: _isNotificationEnabled,
                        onChanged: (value) => setState(() => _isNotificationEnabled = value),
                        
                      ),
                    ],
                  ),
                ),
            
                // Animated Notification Options
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) => SizeTransition(sizeFactor: animation, child: FadeTransition(opacity: animation, child: child)),
                  child: _isNotificationEnabled
                      ? Column(
                          key: const ValueKey('notification_options'),
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomAutoSizeText(
                              text: 'إرسال الإشعارات عبر:',
                              style: theme.textTheme.bodySmall,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              colorText: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                            ),
                            ResponsiveSpace(height: 8),
                            Row(
                              children: [
                                _NotificationOption(
                                  label: 'الواتساب',
                                  value: 'الواتساب',
                                  groupValue: currentOption,
                                  onChanged: (value) => setState(() => currentOption = value),
                                ),
                                _NotificationOption(
                                  label: 'رسائل SMS',
                                  value: 'رسائل SMS',
                                  groupValue: currentOption,
                                  onChanged: (value) => setState(() => currentOption = value),
                                ),
                              ],
                            ),
                          ],
                        )
                      : const SizedBox.shrink(key: ValueKey('empty')),
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------
// Modular Widgets for Reusability and Clean Code
// ----------------------------------------------------------------------

// 1. Basic Information Section (Name, Phone, Category)
class _AccountBasicInfoSection extends ConsumerWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final List<String> categories;
  final String? selectedCategory;
  final ValueChanged<String?> onCategoryChanged;
  final FormFieldValidator<String> validateName;
  final FormFieldValidator<String> validatePhone;

  const _AccountBasicInfoSection({
    required this.nameController,
    required this.phoneController,
    required this.categories,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.validateName,
    required this.validatePhone,
  });

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    final theme = ref.theme;
    final responsive = ref.responsive;

    return Container(
       decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.5), width: 0.5),
        color: theme.colorScheme.surface,
      ),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: responsive.paddingAll(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAutoSizeText(
              text: 'البيانات الأساسية',
              style: theme.textTheme.titleMedium,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              colorText: theme.colorScheme.onSurface,
            ),
            const ResponsiveSpace(height: 12),
            CustomTextField(
              controller: nameController,
              label: 'إسم الحساب',
              hint: 'ادخل إسم الحساب',
              validator: validateName,
              suffixIcon: CustomHugeIcon(
               icon: HugeIcons.strokeRoundedUser02,
                color: theme.colorScheme.primary,
                
              ),
            ),
            const ResponsiveSpace(height: 12),
            CustomTextField(
              controller: phoneController,
              label: 'هاتف',
              hint: 'أدخل رقم الهاتف',
              keyboardType: TextInputType.phone,
              validator: validatePhone,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[+\d-]'))],
              suffixIcon: IconButton(
                icon: CustomHugeIcon(
               icon: HugeIcons.strokeRoundedContact01,
                color: theme.colorScheme.primary,
              ),
                onPressed: () {}, 
                tooltip: 'اختيار من جهات الاتصال',
              ),
            ),
            const ResponsiveSpace(height: 12),
            CustomTextFieldDropdown<String>(
              items: categories
                  .map(
                    (type) => DropdownMenuItem(
                      value: type,
                      child: CustomAutoSizeText(
                        text: type,
                        fontSize: 12,
                        colorText: theme.colorScheme.onSurface,
                      ),
                    ),
                  )
                  .toList(),
              value: selectedCategory,
              onChanged: onCategoryChanged,
              hintText: 'اختر نوع التصنيف',
              labelText: 'نوع التصنيف',
              validator: (value) => value == null ? 'يرجى اختيار تصنيف الحساب' : null,
              
            ),
          ],
        ),
      ),
    );
  }
}



// Reusable Radio Button Option for Notification Method
class _NotificationOption extends StatelessWidget {
  final String label;
  final String value;
  final String? groupValue;
  final ValueChanged<String?> onChanged;

  const _NotificationOption({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: InkWell(
        onTap: () => onChanged(value),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio<String>(
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
        ),
      ),
    );
  }
}