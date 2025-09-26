import 'package:bookkeeping_flutter_app/core/base_layout/base_layout_screen.dart';
import 'package:bookkeeping_flutter_app/core/base_layout/build_non_tabbar_layout.dart';
import 'package:bookkeeping_flutter_app/core/providers/settings_provider.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_expansion_tile.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_overlay.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

// Providers لإدارة الحالة
final languageProvider = StateProvider<String>((ref) => 'ar');
final currencyProvider = StateProvider<String>((ref) => 'SAR');

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;

    return BaseLayoutScreen(
      body: BuildNonTabbarLayout(
        titleWidget: CustomAutoSizeText(
          text: 'الإعدادات',
          fontSize: 14,
          style: theme.textTheme.bodyMedium,
          fontWeight: FontWeight.bold,
          colorText: theme.colorScheme.primary,
        ),
        slivers: [
          const SliverToBoxAdapter(child: ResponsiveSpace(height: 16)),

          // 1. General Settings Section
          _SettingsSection(
            title: 'إعدادات عامة',
            children: [
              _buildLanguageTile(context, ref),
              _buildThemeTile(context, ref),
              _buildCurrencyTile(context, ref),
            ],
          ),

          const SliverToBoxAdapter(child: ResponsiveSpace(height: 24)),

          // 2. Data & Privacy Section
          _SettingsSection(
            title: 'البيانات والخصوصية',
            children: [
              _buildBackupTile(context, ref),
            ],
          ),
        ],
      ),
    );
  }

  // --- Reusable Widget Builders for Expansion Tiles ---

  Widget _buildLanguageTile(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    final selectedLanguage = ref.watch(languageProvider);
    return _SettingsExpansionTile(
      leading: HugeIcons.strokeRoundedGlobe,
      title: 'اللغة',
      subtitle: selectedLanguage == 'ar' ? 'العربية' : 'English',
      children: [
        RadioListTile<String>(
          title: CustomAutoSizeText( text: 'العربية',
           style: theme.textTheme.bodySmall,
           fontSize: 12,
           ),
          value: 'ar',
          groupValue: selectedLanguage,
          onChanged: (value) => ref.read(languageProvider.notifier).state = value!,
        ),
        RadioListTile<String>(
           title: CustomAutoSizeText( text: 'English',
            style: theme.textTheme.bodySmall,
            fontSize: 12,
            ),
          value: 'en',
          groupValue: selectedLanguage,
          onChanged: (value) => ref.read(languageProvider.notifier).state = value!,
        ),
      ],
    );
  }

  Widget _buildThemeTile(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    final isDark = ref.watch(settingsProvider).containsKey('isDarkMode') ? ref.watch(settingsProvider)['isDarkMode'] as bool : false;
    return _SettingsExpansionTile(
      leading: isDark ? HugeIcons.strokeRoundedMoon02 : HugeIcons.strokeRoundedSun01,
      title: 'الثيم',
      subtitle: isDark ? 'داكن' : 'فاتح',
      children: [
        RadioListTile<bool>(
          title: CustomAutoSizeText( text: 'فاتح',
          style: theme.textTheme.bodySmall,
          fontSize: 12,),
          value: false,
          groupValue: isDark,
          onChanged: (value) => ref.read(settingsProvider.notifier).toggleDarkMode(value!),
        ),
        RadioListTile<bool>(
           title: CustomAutoSizeText( text: 'داكن',
           style: theme.textTheme.bodySmall,
          fontSize: 12,),
          value: true,
          groupValue: isDark,
          onChanged: (value) => ref.read(settingsProvider.notifier).toggleDarkMode(value!),
        ),
      ],
    );
  }

  Widget _buildCurrencyTile(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    final selectedCurrency = ref.watch(currencyProvider);
    String currencyText = '';
    switch (selectedCurrency) {
      case 'SAR':
        currencyText = 'ريال سعودي';
        break;
      case 'USD':
        currencyText = 'دولار أمريكي';
        break;
      case 'YER':
        currencyText = 'ريال يمني';
        break;
    }
    return _SettingsExpansionTile(
      leading: HugeIcons.strokeRoundedDollar01,
      title: 'العملة الافتراضية',
      subtitle: currencyText,
      children: [
        RadioListTile<String>(
          title: CustomAutoSizeText( text: 'ريال سعودي (SAR)',
          style: theme.textTheme.bodySmall,
          fontSize: 12,),
          value: 'SAR',
          groupValue: selectedCurrency,
          onChanged: (value) => ref.read(currencyProvider.notifier).state = value!,
        ),
        RadioListTile<String>(
          title: CustomAutoSizeText( text: 'دولار امريكي (USD)', 
          style: theme.textTheme.bodySmall,
          fontSize: 12,),
          value: 'USD',
          groupValue: selectedCurrency,
          onChanged: (value) => ref.read(currencyProvider.notifier).state = value!,
        ),
        RadioListTile<String>(
           title: CustomAutoSizeText( text: 'ريال يمني (YER)',
           style: theme.textTheme.bodySmall,
          fontSize: 12,),
          value: 'YER',
          groupValue: selectedCurrency,
          onChanged: (value) => ref.read(currencyProvider.notifier).state = value!,
        ),
      ],
    );
  }

  Widget _buildBackupTile(BuildContext context, WidgetRef ref) {
    return _SettingsExpansionTile(
      leading: HugeIcons.strokeRoundedCloudUpload,
      title: 'نسخة احتياطية',
      subtitle: 'تاريخ اخر نسخة احتياطية: 2023-06-25',
      children: [
        _SettingsListTile(
          title: 'انشاء نسخة احتياطية',
          icon: HugeIcons.strokeRoundedCloudUpload,
          onTap: () => _showBackupDialog(context, ref),
        ),
        _SettingsListTile(
          title: 'تحميل نسخة احتياطية',
          icon: HugeIcons.strokeRoundedCloudDownload,
          onTap: () => _showBackupDialog(context, ref),
        ),
        _SettingsListTile(
          title: 'حذف نسخة احتياطية',
          icon: HugeIcons.strokeRoundedDelete01,
          onTap: () => _showBackupDialog(context, ref),
        ),
      ],
    );
  }

  void _showBackupDialog(BuildContext context, WidgetRef ref) {
    final responsive = ref.responsive;
    final theme = ref.theme;
    CustomOverlay.show(
      context: context,
      child: Card(
        margin: responsive.paddingAll(24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 10,
        child: Padding(
          padding: responsive.paddingAll(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomAutoSizeText(
                text: 'إنشاء نسخة احتياطية',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                colorText: theme.colorScheme.primary,
              ),
              const ResponsiveSpace(height: 16),
              CustomAutoSizeText(
                text: 'هل أنت متأكد من رغبتك في إنشاء نسخة احتياطية الآن؟',
                fontSize: 14,
                maxLines: 3,
                colorText: theme.colorScheme.onSurface,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    text: 'إلغاء',
                    onPressed: CustomOverlay.dismiss,
                    backgroundColor: theme.colorScheme.surface,
                    textColor: theme.colorScheme.onSurface,
                  ),
                  const ResponsiveSpace(width: 16),
                  CustomButton(
                    text: 'تأكيد',
                    onPressed: () {
                      CustomOverlay.dismiss();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'تم إنشاء نسخة احتياطية بنجاح!',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      );
                    },
                    backgroundColor: theme.colorScheme.primary,
                    textColor: theme.colorScheme.onPrimary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- New Modular Widgets ---

/// A reusable widget to group related settings into a card.
class _SettingsSection extends ConsumerWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAutoSizeText(
            text: title,
            style: theme.textTheme.titleMedium,
            fontWeight: FontWeight.bold,
            colorText: theme.colorScheme.primary,
            fontSize: 12,
          ),
          const ResponsiveSpace(height: 12),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: children.map((item) {
                return Column(
                  children: [
                    item,
                    if (item != children.last)
                      Divider(
                        thickness: 0.5,
                        height: 0.5,
                        indent: 16,
                        endIndent: 16,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                      ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

/// A modern, reusable tile for settings.
class _SettingsExpansionTile extends StatelessWidget {
  final IconData leading;
  final String title;
  final String subtitle;
  final List<Widget> children;

  const _SettingsExpansionTile({
    required this.leading,
    required this.title,
    required this.subtitle,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    
    return CustomExpansionTile(
      
      leading: leading,
      title: title,
      subtitle: subtitle,
      children: children,
    );
  }
}

/// A custom ListTile for settings with a modern look.
class _SettingsListTile extends ConsumerWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _SettingsListTile({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            HugeIcon(
              icon: icon,
              size: 20,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
            ),
            const ResponsiveSpace(width: 16),
            Expanded(
              child: CustomAutoSizeText(
                text: title,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                colorText: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}