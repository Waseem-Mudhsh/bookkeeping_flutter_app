import 'package:bookkeeping_flutter_app/core/app_scaffold/adaptive_scaffold.dart';

import 'package:bookkeeping_flutter_app/core/base_layout/build_non_tabbar_layout.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_text_field_dropdown.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_text_form_field.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:bookkeeping_flutter_app/features/Currencies/presentation/providers/currency_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/custom_auto_size_text.dart';
import '../../../../core/widgets/custom_huge_icon.dart';
import '../../../Currencies/domain/entities/currency.dart';
class AccountCeilingScreen extends ConsumerStatefulWidget {
  const AccountCeilingScreen({super.key});

  @override
  ConsumerState<AccountCeilingScreen> createState() => _AccountCeilingScreenState();
}

class _AccountCeilingScreenState extends ConsumerState<AccountCeilingScreen> {
  // State variables for toggles and input fields
  bool _isCeilingEnabled = false;
  bool _isDateLimitEnabled = false;
  late Currency selectedCurrency; // Default selection
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  late List<Currency> currencies ;
  @override
  void initState() {
    super.initState();
    currencies = ref.read(currencyListProvider);
    if(currencies.isNotEmpty){
      selectedCurrency = currencies.first;
    }
  }



  @override
  void dispose() {
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
   
    final theme = ref.theme;
    

    return AdaptiveScaffold(
      backgroundColor: theme.colorScheme.surfaceContainerLowest, // خلفية فاتحة للتمييز
      
      body: BuildNonTabbarLayout(
        titleWidget: _buildHeader(),
        slivers: [
          SliverToBoxAdapter(
            child: ResponsiveSpace(height: 24),
          ),
         
          SliverToBoxAdapter(child: ResponsiveSpace(height: 16)),
          SliverToBoxAdapter(
            child: _buildSettingCard(
             
              title: 'تحديد سقف للحساب',
              description: 'يمكنك تحديد مبلغ معين كحد لتجاوز المبلغ المحدد يتم اشعارك بذلك',
              isEnabled: _isCeilingEnabled,
              onToggle: (value) {
                setState(() {
                  _isCeilingEnabled = value;
                });
              },
              content: _isCeilingEnabled
                  ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: _amountController,
                           label: 'المبلغ',
                          hint: '0.00',
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          suffixIcon: CustomHugeIcon(
                            icon: HugeIcons.strokeRoundedMoney01,
                            color: theme.colorScheme.primary,
                            size: 20,
                          ),
                           ),
                      ),
                      ResponsiveSpace(width: 8),
                       Expanded(child: _buildCurrencyDropdown(theme))
                    ],
                  )
                  : null, // No content if disabled
            ),
          ),
          SliverToBoxAdapter(child: ResponsiveSpace(height: 16),),
          SliverToBoxAdapter(
            child:  // --- Date Limit Card ---
            _buildSettingCard(
             
              title: 'تحديد تاريخ للحساب',
              description: 'يمكنك تحديد تاريخ معين كحد لتجاوز التاريخ المحدد يتم اشعارك بذلك',
              isEnabled: _isDateLimitEnabled,
              onToggle: (value) {
                setState(() {
                  _isDateLimitEnabled = value;
                });
              },
              content: _isDateLimitEnabled
                  ? CustomTextField(
                    controller: _dateController,
                    
                    label: 'تاريخ العملية',
                    hint: 'DD-MM-YYYY',
                    suffixIcon: CustomHugeIcon(
                      icon: HugeIcons.strokeRoundedCalendar01,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                    readOnly: true,
                    onTap: () => _selectDate(context),
                  )
                  : null, // No content if disabled
            ),

          ),
          SliverToBoxAdapter(child: ResponsiveSpace(height: 80),),
          SliverToBoxAdapter(
            child: CustomButton(text: 'حفظ',onPressed: () {
              Navigator.pop(context);
            },),
          )
          

        ],),
      
      
    );
  }
  Widget _buildHeader(){
    final theme = ref.theme;
    return  CustomAutoSizeText(
              text:  'سقف الحساب',
              style: theme.textTheme.bodyMedium,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              colorText: theme.colorScheme.primary,
            );
  }
   Widget _buildCurrencyDropdown(ThemeData theme) {
    return CustomTextFieldDropdown<Currency>(
      
      items: currencies
          .map(
            (currency) => DropdownMenuItem<Currency>(
              value: currency,
              child: CustomAutoSizeText(
                text: currency.name,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                colorText: theme.colorScheme.onSurface,
              ),
            ),
          )
          .toList(),
      value: selectedCurrency,
      onChanged:(value){
        setState(() {
          selectedCurrency = value!;
        });
        // Handle currency change
    
      } ,
      hintText: 'اختر العملة',
      labelText: 'العملة',
      validator: (value) => value == null ? 'العملة مطلوبة' : null,
    );
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
      
    }
  }

  // Helper Widget for setting cards
  Widget _buildSettingCard({
   
    required String title,
    required String description,
    required bool isEnabled,
    required ValueChanged<bool> onToggle,
    Widget? content,
  }) {
    final responsive = ref.responsive;
    final theme = ref.theme;
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.bounceIn,
      padding: responsive.paddingAll(16),
    
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(responsive.w(12)),
        border: Border.all(
          color: isEnabled
              ? theme.colorScheme.primary
              : theme.colorScheme.outline.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded( // Allow text to wrap if long
                child: CustomAutoSizeText(text: title,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  colorText: theme.colorScheme.onSurface,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              Switch(
                value: isEnabled,
                onChanged: onToggle,
               
              ),
            ],
          ),
          ResponsiveSpace(height: 8),
         CustomAutoSizeText(text: description,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  colorText: theme.colorScheme.onSurface,
                  style: theme.textTheme.bodySmall,
                ),
          if (isEnabled && content != null) ...[
            ResponsiveSpace(height: 16),
            content,
          ],
        ],
      ),
    );
  }
}