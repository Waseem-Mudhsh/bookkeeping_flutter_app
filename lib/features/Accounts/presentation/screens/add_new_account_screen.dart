

import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_expansion_tile.dart'; // إذا كنت ترغب في قسم قابل للتوسيع
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/domain/entities/main_account.dart';
import 'package:bookkeeping_flutter_app/features/Transactions/domain/entities/transaction_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/base_layout/base_layout_screen.dart';
import '../../../../core/base_layout/build_non_tabbar_layout.dart';
import '../../../../core/providers/responsive_notifier.dart';
import '../../../../core/providers/theme_data_provider.dart';
import '../../../../core/utils/id_generator.dart';
import '../../../../core/utils/responsive_values.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field_dropdown.dart';
import '../../../../core/widgets/custom_overlay.dart'; // لرسائل التأكيد/الخطأ
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/responsive_space.dart';
import '../../../Accounts/domain/entities/account.dart'; // تأكد من وجود Account entity
import '../../../Currencies/domain/entities/currency.dart';
import '../../../Currencies/presentation/providers/currency_provider.dart';
import '../providers/account_provider.dart';
// import '../../../Accounts/presentation/providers/account_provider.dart'; // تأكد من وجود provider خاص بالحسابات

// تعريف AccountType إذا لم تكن موجودة في Account entity
enum AccountType { bank, cash, creditCard, investment, eWallet, other }

// Mock data for demonstration if actual Account data is not yet set up
List<Currency> mockCurrencies = [
  Currency(code: 'USD', name: 'دولار أمريكي', flagUrl: 'assets/flags/us.png'),
  Currency(code: 'YER', name: 'ريال يمني', flagUrl: 'assets/flags/ye.png'),
  Currency(code: 'SAR', name: 'ريال سعودي', flagUrl: 'assets/flags/sa.png'),
];

class AddNewAccountScreen extends ConsumerStatefulWidget {
  final Account? existingAccount; // لتمرير الحساب الحالي للتعديل

  const AddNewAccountScreen({super.key, this.existingAccount});

  @override
  ConsumerState<AddNewAccountScreen> createState() =>
      _AddNewAccountScreenState();
}

class _AddNewAccountScreenState extends ConsumerState<AddNewAccountScreen> {
  final _formKey = GlobalKey<FormState>(); // مفتاح للتحقق من صحة النموذج
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _balanceController;
  late TextEditingController _notesController;
  
  
  late List<MainAccountModel> listMockAccountTypes = [];

  late List<Currency> currencies = [];
  late Currency currencySelected;
  MainAccountModel? accountTypeSelected; // نوع الحساب المختار
  String? categorySelected;
  String? currentOption;
  TransactionType? debtorOption;
  bool? _isNotificationEnabled = false;
  bool _isSaving = false;
  final List<String> categorices = [
    'العملاء',
    'الموردين',
    'الرواتب',
    'الضرائب',
    'المصروفات',
  ];

  @override
  void initState() {
    super.initState();

    // تهيئة قايمة نوع الحسابات
    listMockAccountTypes = mainAccounts;

    categorySelected = categorices.first;

    // تهيئة قائمة العملات
    currencies = ref.read(currencyListProvider);
    if (currencies.isEmpty) {
      currencies =
          mockCurrencies; // استخدام بيانات وهمية إذا كانت القائمة فارغة
    }
    // تعيين العملة الافتراضية أو العملة الحالية للحساب
    currencySelected = currencies.first;

    // تهيئة حقول التحكم بالنصوص
    _nameController = TextEditingController(
      text: widget.existingAccount?.name ?? '',
    );
    _balanceController = TextEditingController(
      text: (widget.existingAccount?.totalAccountBalance ?? 0.0)
          .toStringAsFixed(2),
    ); // تنسيق الرقم العشري
    _notesController = TextEditingController(
      text: widget.existingAccount?.note ?? '',
    );
    
    

    _phoneController = TextEditingController(
      text: widget.existingAccount?.phoneNumber ?? '',
    );

    // تعيين نوع الحساب الحالي أو افتراضي
    accountTypeSelected = listMockAccountTypes.first;
    debtorOption = widget.existingAccount?.debtor != 0
        ? TransactionType.debit
        : TransactionType.credit; // تعيين نوع المعاملة بناءً على الحساب الحالي
  }

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  // دالة لحفظ الحساب (إضافة أو تعديل)
  Future<void> _saveAccount() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return; // لا تفعل شيئًا إذا كان النموذج غير صالح
    }

    setState(() => _isSaving = true); // تفعيل مؤشر التحميل

    try {
      showTemporaryMessage(context, 'جاري الحفظ...'); // رسالة مؤقتة
      

      final account = Account(
        id:
            widget.existingAccount?.id ??
            IdGenerator.generateCompactId(prefix: 'acc_'),
        name: _nameController.text,
        totalAccountBalance: 0.0,
        currencyCode: currencySelected.code,
        category:
            accountTypeSelected!.name.toString(),
                // يجب أن يكون غير null بفضل الـ validator
        note: _notesController.text.isNotEmpty ? _notesController.text : null,
        image: '', // يمكن لاحقًا إضافة منطق لاختيار أيقونة مخصصة
        debtor: debtorOption == TransactionType.debit
            ? double.parse(_balanceController.text)
            : 0,
        creditor: debtorOption == TransactionType.credit
            ? double.parse(_balanceController.text)
            : 0,
        createdAt: DateTime.now(),
        mainAccountId: accountTypeSelected!.id,
        phoneNumber: _phoneController.text,
      );

      debugPrint('Saving account: ${account.name}');
    
      if (widget.existingAccount == null) {
       

        await ref.read(accountViewModelProvider.notifier).addAccount(account);
       
        debugPrint('Adding new account: ${account.name}');
      } else {
        await ref.read(accountViewModelProvider.notifier).updateAccount(account);
        debugPrint('Updating account: ${account.name}');
      }

      if (mounted) {
        // رسالة نجاح واضحة
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomAutoSizeText(
              fontFamily: 'Cairo',
             text:  widget.existingAccount == null
                  ? 'تم إضافة الحساب بنجاح!'
                  : 'تم تعديل الحساب بنجاح!',
              colorText: Colors.white,
              fontSize: 12,
            ),
            backgroundColor: Colors.green,
          ),
        );
        
        Navigator.pop(context); // إغلاق الشاشة بعد الحفظ الناجح
       
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطأ أثناء الحفظ: ${e.toString()}'),
           
            backgroundColor: Colors.red,
          ),
           
        );
        debugPrint('Error saving account: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false); // إيقاف مؤشر التحميل
      }
    }
  }

 

  // دوال التحقق من صحة المدخلات
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
    if (value.length < 9 && value.length > 9) {
      return 'رقم الهاتف يجب أن يكون 9 ارقام';
    }
    return null;
  }


 

  String? _validateCategory(String? value) {
    if (value == null) {
      return 'يرجى اختيار تصنيف الحساب';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ref.watch(responsiveProvider);
    final theme = ref.watch(themeDataProvider);

    return BaseLayoutScreen(
      // عنوان الشاشة يتغير بناءً على عملية الإضافة أو التعديل
      body: BuildNonTabbarLayout(
        titleWidget: CustomAutoSizeText(
          text: widget.existingAccount == null ? 'إضافة حساب جديد' : 'تعديل حساب',
          style: theme.textTheme.bodyMedium,
          fontWeight: FontWeight.bold,
          fontSize: 14,
          colorText: theme.colorScheme.primary,
        ),
           
        slivers: [
          SliverToBoxAdapter(
            child: Form(
              key: _formKey, // ربط الـ formKey بالنموذج
              child: Padding(
                padding: responsive.paddingSym( v: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // قسم البيانات الأساسية (اسم الحساب، نوع الحساب، العملة)
                    _buildAccountBasicInfo(theme, responsive),
                    ResponsiveSpace(height: responsive.h(16)),
    
    
                    // قسم المعلومات الإضافية (الملاحظات)
                    _buildAdditionalInfo(theme, responsive),
                    ResponsiveSpace(
                      height: responsive.h(48),
                    ), // مسافة قبل الأزرار
                    // أزرار الحفظ والإلغاء
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: "إلغاء",
                            textColor: theme.colorScheme.primary,
                            backgroundColor: theme.colorScheme.surfaceBright,
                            onPressed:
                                () => Navigator.pop(context), // إغلاق الشاشة
                          ),
                        ),
                        ResponsiveSpace(width: responsive.w(16)),
                        Expanded(
                          child: CustomButton(
                            text: "حفظ",
                            textColor: theme.colorScheme.onPrimary,
                            backgroundColor: theme.colorScheme.primary,
                            isLoading: _isSaving, // عرض مؤشر تحميل داخل الزر
                            onPressed: _saveAccount, // استدعاء دالة الحفظ
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
        ],
      ),
    );
  }

  // بناء قسم "البيانات الأساسية للحساب"
  Widget _buildAccountBasicInfo(ThemeData theme, ResponsiveValues responsive) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8), // زوايا مستديرة أكثر
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
            text: 'البيانات الأساسية',
            style: theme.textTheme.bodyMedium,
            fontSize: 12,
              fontWeight: FontWeight.bold,
              colorText: theme.colorScheme.primary,
          ),
          const ResponsiveSpace(height: 12),
          CustomTextField(
            controller: _nameController,
            label: 'إسم الحساب',
            hint: 'ادخل إسم الحساب',
            validator: _validateName,
            // أيقونة بادئة لتعريف الحقل
            suffixIcon: Icon(
              Icons.account_balance_wallet_outlined,
              color: theme.colorScheme.primary,
            ),
          ),
          const ResponsiveSpace(height: 12),
           CustomTextField(
              controller: _phoneController,
              label: 'هاتف',
              hint: 'أدخل رقم الهاتف',
              keyboardType: TextInputType.phone,
              validator: _validatePhone,
              inputFormatters: [
                 FilteringTextInputFormatter.allow(RegExp(r'[+\d-]')), // يسمح فقط بالأرقام و + و -
              ],
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
            const ResponsiveSpace(height: 12,),
          // Dropdown لاختيار نوع الحساب
          CustomTextFieldDropdown<String>(
            items:
                categorices
                    .map(
                      (type) => DropdownMenuItem(
                        value: type,
                        child: CustomAutoSizeText(
                          text: type, // دالة لتحويل Enum إلى نص عربي
                          fontSize: 14,
                          colorText: theme.colorScheme.onSurface,
                        ),
                      ),
                    )
                    .toList(),
            value: categorySelected,
            onChanged:
                (value) => setState(() => categorySelected = value),
            hintText: 'اختر نوع التصنيف',
            labelText: 'نوع التصنيف',
            validator: _validateCategory,
            prefixIcon: Icon(
              Icons.category_outlined,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  // بناء قسم "الرصيد الافتتاحي"
 

  // بناء قسم "المعلومات الإضافية" (باستخدام CustomExpansionTile للحقول الاختيارية)
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


          
          CustomTextField(
            controller: _notesController,
            label: 'العنوان',
            hint: '  اضف العنوان...',
            keyboardType: TextInputType.text,

            suffixIcon: CustomHugeIcon(icon: HugeIcons.strokeRoundedLocation01,
            color:theme.colorScheme.primary)
          ),
          const ResponsiveSpace(height: 16),
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

                ResponsiveSpace(height: 8),

                if (_isNotificationEnabled!)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap:
                              () => setState(() => currentOption = 'الواتساب'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio<String>(
                                value: 'الواتساب',
                                groupValue: currentOption,
                                fillColor: WidgetStateProperty.all(
                                  theme.colorScheme.secondary,
                                ),
                                activeColor: theme.colorScheme.secondary,
                                onChanged: (value) {
                                  setState(() {
                                    currentOption = value;
                                  });
                                },
                              ),
                              const SizedBox(width: 4),
                              CustomAutoSizeText(
                                text: 'الواتساب',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                style: theme.textTheme.bodySmall,
                                colorText: theme.colorScheme.secondary,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap:
                              () => setState(() => currentOption = 'رسائل SMS'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio<String>(
                                value: 'رسائل SMS',
                                groupValue: currentOption,
                                fillColor: WidgetStateProperty.all(
                                  theme.colorScheme.secondary,
                                ),
                                activeColor: theme.colorScheme.secondary,
                                onChanged: (value) {
                                  setState(() {
                                    currentOption = value;
                                  });
                                },
                              ),
                              const SizedBox(width: 4),
                              CustomAutoSizeText(
                                text: 'رسائل SMS',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                style: theme.textTheme.bodySmall,
                                colorText: theme.colorScheme.secondary,
                              ),
                            ],
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



 
}
