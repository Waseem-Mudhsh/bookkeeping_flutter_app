import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/utils/responsive_values.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/domain/entities/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import '../../../../core/providers/responsive_notifier.dart';
import '../../../../core/providers/theme_data_provider.dart';
import '../../../../core/widgets/custom_text_form_field.dart'; // تأكد من وجود هذا الودجت
import '../../../../core/widgets/responsive_space.dart';
import '../../domain/entities/currency.dart'; // تأكد من وجود هذا الـ entity
import '../providers/currency_provider.dart'; // تأكد من وجود هذا الـ provider

class CustomShowBalince extends ConsumerStatefulWidget {
  final Account account;

  const CustomShowBalince({super.key, required this.account});

  @override
  ConsumerState<CustomShowBalince> createState() => _CustomShowBalinceState();
}

class _CustomShowBalinceState extends ConsumerState<CustomShowBalince> {
  late List<Currency> currencies;
  late Currency currencySelected;
  bool _obscureText = true; // Default to obscured for security

  final TextEditingController _searchController = TextEditingController();
  List<Currency> filteredCurrencies = []; // Added for search functionality

  @override
  void initState() {
    super.initState();
    currencies = ref.read(currencyListProvider);
    currencySelected = currencies.first;
    filteredCurrencies = currencies; // Initialize filtered list with all currencies
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final theme = ref.watch(themeDataProvider);
        final responsive = ref.watch(responsiveProvider);

        return Card(
          elevation: 8, // زيادة الارتفاع للظل
          
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(responsive.w(16)), // حواف أكثر استدارة
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(responsive.w(16)),
              gradient: LinearGradient( // خلفية بتدرج لوني
                colors: [theme.colorScheme.secondary, theme.colorScheme.secondary.withValues(alpha: 0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                
             
              ),
            ),
            child: Padding(
              padding: responsive.paddingAll(8), // زيادة المساحة الداخلية
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // لجعل العناصر تتمدد أفقياً
                children: [
                  // قسم الرأس - محدد العملة والرصيد
                  _buildHeaderSection(theme, responsive),

                  const ResponsiveSpace(height: 6), // مسافة أكبر
                  Divider(height: 1, color: theme.colorScheme.onPrimary.withValues(alpha: 0.3)), // فاصل أفتح
                  const ResponsiveSpace(height: 6),

                  // نظرة عامة على الرصيد - مدين/دائن
                  _buildBalanceOverviewSection(theme, responsive),

                  const ResponsiveSpace(height: 6),
                  Divider(height: 1, color: theme.colorScheme.onPrimary.withValues(alpha: 0.3)),
                  const ResponsiveSpace(height: 6),

                  // الإجراءات السريعة
                  _buildQuickActionsSection(theme, responsive),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderSection(ThemeData theme, ResponsiveValues responsive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // توزيع متساوٍ
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // محدد العملة
        _buildCurrencySelector(theme, responsive),


        // عرض الرصيد
        Expanded(child: _buildBalanceDisplay(theme, responsive)),
        const ResponsiveSpace(width: 8),

        // زر إظهار/إخفاء الرصيد
        IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: theme.colorScheme.onPrimary, // لون الأيقونة من primary
            size: responsive.w(24), // حجم أيقونة أكبر
          ),
          onPressed: _toggleBalanceVisibility,
          tooltip: _obscureText ? 'إظهار الرصيد' : 'إخفاء الرصيد',
        ),
      ],
    );
  }

  Widget _buildCurrencySelector(ThemeData theme, ResponsiveValues responsive) {
    return InkWell(
      borderRadius: BorderRadius.circular(responsive.w(12)), // حواف مستديرة
      onTap: () => _showEnhancedCurrencySelectionSheet(theme),
      child: Padding(
        padding: responsive.paddingSym(h: 8, v: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // علم/أيقونة العملة
            // currencySelected.flagUrl != null
            //     ? ClipOval(
            //         child: Image.asset(
            //           currencySelected.flagUrl!,
            //           fit: BoxFit.cover,
            //           width: responsive.w(24), // حجم أكبر للعلم/الأيقونة
            //           height: responsive.h(24),
            //           scale: 1.0,
            //         ),
            //       ) :
                 ResponsiveSpace(
                    // width: responsive.w(24),
                    height: responsive.h(24),
                    
                    child: Center(
                      child: CustomAutoSizeText(
                        text: currencySelected.name,
                        style: theme.textTheme.bodyMedium,
                        fontSize: 10,
                        colorText: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            ResponsiveSpace(width: responsive.w(4)), // مسافة بين العلم والسهم
            Icon(
              Icons.arrow_drop_down,
              color: theme.colorScheme.onPrimary,
              size: responsive.w(24),
            ),
          ],
        ),
      ),
    );
  }

  void _showEnhancedCurrencySelectionSheet(ThemeData theme) {
    final responsive = ref.responsive;
    showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // حواف أكثر استدارة للـ BottomSheet
      ),
      isScrollControlled: false, // للسماح للـ BottomSheet بالتوسع إذا كان المحتوى طويلاً
      builder: (context) {
        return StatefulBuilder( // استخدام StatefulBuilder لتحديث محتوى الـ BottomSheet عند البحث
          builder: (BuildContext context, StateSetter modalSetState) {
            return SafeArea(
              child: Padding(
                padding:responsive.paddingOnly(
                  bottom: MediaQuery.of(context).viewInsets.bottom, // لضبط المساحة عند ظهور لوحة المفاتيح
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // الرأس مع حقل البحث
                    Padding(
                      padding: responsive.paddingAll(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'اختر العملة',
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const ResponsiveSpace(height: 8),
                          ResponsiveSpace(
                            height: 50,
                            child: CustomTextField(
                              prefixIcon: Icon(
                                Icons.search,
                                color: theme.colorScheme.onSurface,
                              ),
                              hint: 'ابحث عن عملة...',
                              onChanged: (value) {
                                modalSetState(() {
                                  filteredCurrencies = currencies
                                      .where(
                                        (c) =>
                                            c.name.toLowerCase().contains(value.toLowerCase()) ||
                                            c.code.toLowerCase().contains(value.toLowerCase()),
                                      )
                                      .toList();
                                });
                              },
                              controller: _searchController,
                              label: 'ابحث عن عملة...',
                            ),
                          ),
                        ],
                      ),
                    ),

                    Divider(height: 1, color: theme.dividerColor),

                    // قائمة العملات
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: filteredCurrencies.length, // استخدام القائمة المفلترة
                        separatorBuilder: (_,_) => Divider(
                          height: 0.5,
                          color: theme.dividerColor.withValues(alpha: 0.5),
                          indent: 16,
                          endIndent: 16,
                        ),
                        itemBuilder: (context, index) {
                          final currency = filteredCurrencies[index];
                          return _buildEnhancedCurrencyListItem(currency, theme);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildEnhancedCurrencyListItem(Currency currency, ThemeData theme) {
    final isSelected = currency == currencySelected;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        width: 48, // حجم أكبر للأيقونة
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.colorScheme.surface.withValues(alpha: 0.2), // لون خلفية للأيقونة
        ),
        child: currency.flagUrl != null
            ? ClipOval(
                child: Image.asset(currency.flagUrl!, fit: BoxFit.cover),
              )
            : Center(
                child: CustomAutoSizeText(
                  text: currency.code.substring(0, 2),
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
      ),
      title: CustomAutoSizeText(
        text: currency.name,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: theme.colorScheme.onSurface,
        ),
      ),
      subtitle: CustomAutoSizeText(
        text: currency.code,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            currency.balanceDue?.toStringAsFixed(2) ?? '0.00',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.secondary, // استخدام لون مميز للرصيد
            ),
          ),
          Text(
            'رصيد',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
      tileColor: isSelected ? theme.colorScheme.primary.withValues(alpha: 0.1) : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onTap: () {
        setState(() {
          currencySelected = currency;
          _searchController.clear(); // مسح حقل البحث عند الاختيار
          filteredCurrencies = currencies; // إعادة تعيين القائمة المفلترة
        });
        Navigator.pop(context);
      },
    );
  }

  Widget _buildBalanceDisplay(ThemeData theme, ResponsiveValues responsive) {
    return Container(
      padding: responsive.paddingSym(h: 8, v: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary.withValues(alpha: 0.15), // خلفية شبه شفافة
        borderRadius: BorderRadius.circular(responsive.w(8)),
      ),
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: _obscureText
              ? CustomAutoSizeText(
                  key: const ValueKey('obscured_balance'), // مفتاح لـ AnimatedSwitcher
                  text: '••••••',
                  letterSpacing: 2,
                  colorText: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: responsive.w(16), // حجم خط أكبر للرصيد
                  style: theme.textTheme.bodyLarge
                )
              : Row(
                  key: const ValueKey('visible_balance'), // مفتاح لـ AnimatedSwitcher
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: CustomAutoSizeText(
                        text: widget.account.totalAccountBalance.toStringAsFixed(2) ,
                        fontWeight: FontWeight.bold,
                        colorText: theme.colorScheme.onPrimary,
                        fontSize: responsive.w(16),
                        
                        style: theme.textTheme.bodyLarge
                      ),
                    ),
                    const ResponsiveSpace(width: 8),
                    CustomAutoSizeText(
                      text: currencySelected.code,
                      colorText: theme.colorScheme.onPrimary.withValues(alpha: 0.8),
                      fontSize: responsive.w(12),
                      style: theme.textTheme.bodyMedium
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildBalanceOverviewSection(ThemeData theme, ResponsiveValues responsive) {
    // استخدم بياناتك الفعلية هنا
    final double debtorBalance = 1500.00; // مثال: الرصيد المدين
    final double creditorBalance = 500000000000.00; // مثال: الرصيد الدائن

    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: _buildBalanceBox(
              label: 'مدين',
              value: debtorBalance,
              theme: theme,
              responsive: responsive,
              isDebtor: true,
            ),
          ),
          ResponsiveSpace(width: responsive.w(6)),
          VerticalDivider(
            thickness: 1.5, // سمك أكبر للفاصل
            color: theme.colorScheme.onSecondary.withValues(alpha: 0.3), // لون الفاصل
          ),
          
          ResponsiveSpace(width: responsive.w(6)),
          Expanded(
            child: _buildBalanceBox(
              label: 'دائن',
              value: creditorBalance,
              theme: theme,
              responsive: responsive,
              isDebtor: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceBox({
    required String label,
    required double value,
    required ThemeData theme,
    required ResponsiveValues responsive,
    required bool isDebtor,
  }) {
    Color balanceColor = isDebtor ? Colors.redAccent.shade200 : Colors.greenAccent.shade200; // ألوان مميزة
    IconData icon = isDebtor ? Icons.arrow_downward : Icons.arrow_upward; // أيقونات توضيحية

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: balanceColor,
              size: responsive.w(18),
            ),
            ResponsiveSpace(width: responsive.w(4)),
            CustomAutoSizeText(
              text: label,
              style: theme.textTheme.bodyMedium,
                colorText: theme.colorScheme.onPrimary.withValues(alpha: 0.8),
                fontWeight: FontWeight.bold,
                fontSize: 12  ,
              
            ),
          ],
        ),
        ResponsiveSpace(height: responsive.h(4)),
        CustomAutoSizeText(
          text: _obscureText ? '••••••' : value.toStringAsFixed(2),
          fontWeight: FontWeight.bold,
          colorText: _obscureText ? theme.colorScheme.onPrimary : balanceColor,
          style: theme.textTheme.headlineSmall
        ),
      ],
    );
  }

  Widget _buildQuickActionsSection(ThemeData theme, ResponsiveValues responsive) {
    return Center(
      child: Wrap(
        spacing: responsive.w(8), // مسافة أفقية أكبر
        runSpacing: responsive.h(8), // مسافة عمودية أكبر
        alignment: WrapAlignment.spaceAround, // توزيع العناصر بالتساوي
        children: [
          _buildActionButton(
            icon: Icons.attach_money, // أيقونة للإيرادات
            label: 'إضافة رصيد',
            theme: theme,
            responsive: responsive,
            onPressed: _handleAddBalance,
          ),
         
          _buildActionButton(
            icon: Icons.picture_as_pdf,
            label: 'تصدير PDF',
            theme: theme,
            responsive: responsive,
            onPressed: _handleExportToPdf,
          ),
          _buildActionButton(
            icon: Icons.share,
            label: 'مشاركة',
            theme: theme,
            responsive: responsive,
            onPressed: _handleShare,
          ),
          _buildActionButton(
            icon: Icons.note_add,
            label: 'ملاحظة',
            theme: theme,
            responsive: responsive,
            onPressed: _handleAddNote,
          ),
          _buildActionButton(
            icon: Icons.refresh,
            label: 'تحديث',
            theme: theme,
            responsive: responsive,
            onPressed: _handleRefresh,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required ThemeData theme,
    required ResponsiveValues responsive,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.transparent, // لجعل تأثير الـ InkWell مرئياً
      child: InkWell(
        borderRadius: BorderRadius.circular(responsive.w(12)),
        onTap: onPressed,
        child: Padding(
          padding: responsive.paddingAll(8.0), // زيادة مساحة الضغط
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: theme.colorScheme.onPrimary, // أيقونة بلون نص الكارت
                size: responsive.w(20), // حجم أيقونة أكبر
              ),
              ResponsiveSpace(height: responsive.h(2)),
              CustomAutoSizeText(
                text: label,
                fontWeight: FontWeight.w500,
                colorText: theme.colorScheme.onPrimary.withValues(alpha: 0.9), // نص بلون نص الكارت
                style: theme.textTheme.bodySmall,
                fontSize: 10,
                maxLines: 1,
                minFontSize: 8,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleBalanceVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // Action Handlers
  void _handleAddBalance() {

    // TODO: Implement add balance (e.g., navigate to add income screen)
    debugPrint('Add Balance clicked');
  }

  void _handleExportToPdf() {
    // TODO: Implement PDF export
    debugPrint('Export to PDF clicked');
  }

  void _handleShare() {
    // TODO: Implement share functionality
    debugPrint('Share clicked');
  }

  void _handleAddNote() {
    // TODO: Implement add note
    debugPrint('Add Note clicked');
  }

  void _handleRefresh() {
    // TODO: Implement refresh logic (e.g., refetch balances)
    debugPrint('Refresh clicked');
    // For demonstration, let's refresh filtered currencies in the main view if needed
    setState(() {
      // Example: If currency data can change, re-read it
      // currencies = ref.read(currencyListProvider);
      // filteredCurrencies = currencies;
    });
  }
}