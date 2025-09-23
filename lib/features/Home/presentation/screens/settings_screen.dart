import 'package:bookkeeping_flutter_app/core/base_layout/build_non_tabbar_layout.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_expansion_tile.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/presentation/widgets/balance_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/base_layout/base_layout_screen.dart';
import '../../../../core/providers/settings_provider.dart';
import '../../../../core/widgets/custom_overlay.dart';

// Providers لإدارة الحالة
final languageProvider = StateProvider<String>((ref) => 'ar');

final currencyProvider = StateProvider<String>((ref) => 'SAR');

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme =ref.theme;
    return BaseLayoutScreen(
     
      body: BuildNonTabbarLayout(
        
        titleWidget:  CustomAutoSizeText(
          text: 'الاعدادات',
          fontSize: 14,
          fontWeight: FontWeight.w700,
          colorText: theme.colorScheme.primary
        ),
        
        slivers: [
          SliverToBoxAdapter(child: ResponsiveSpace(height: 16,),),
          SliverToBoxAdapter(child: _buildLanguageTile(context, ref),),
          SliverToBoxAdapter(child: ResponsiveSpace(height: 2,),),
          SliverToBoxAdapter(child: const Divider(thickness: 0.5,),),
          SliverToBoxAdapter(child: ResponsiveSpace(height: 2,),),
          SliverToBoxAdapter(child: _buildThemeTile(context, ref),),
          SliverToBoxAdapter(child: ResponsiveSpace(height: 2,),),
          SliverToBoxAdapter(child: const Divider(thickness: 0.5, ),),
          SliverToBoxAdapter(child: ResponsiveSpace(height: 2,),),
          SliverToBoxAdapter(child: _buildCurrencyTile(context, ref),),
          SliverToBoxAdapter(child: ResponsiveSpace(height: 2,),),
          SliverToBoxAdapter(child: const Divider( thickness: 0.5, ),),
          SliverToBoxAdapter(child: ResponsiveSpace(height: 2,),),
          SliverToBoxAdapter(child: _buildBackupTile(context, ref),),
          SliverToBoxAdapter(child: const Divider(thickness: 0.5, ),),
          SliverToBoxAdapter(child: ResponsiveSpace(height: 2,),),


        ],
       
      ),
    );
  }

  // ExpansionTile لتغيير اللغة
  Widget _buildLanguageTile(BuildContext context, WidgetRef ref) {
    final selectedLanguage = ref.watch(languageProvider);
    return CustomExpansionTile(
      leading:HugeIcons.strokeRoundedGlobe,
      title: 'اللغة',
      subtitle: 
        'اللغة الحالية: ${selectedLanguage == 'ar' ? 'العربية' : 'English'}',
      children: <Widget>[
        RadioListTile<String>(
          title: const CustomAutoSizeText(
            text: 'العربية',
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
          value: 'ar',
          groupValue: selectedLanguage,
          onChanged: (String? value) {
            if (value != null) {
              ref.read(languageProvider.notifier).state = value;
              // TODO: implement actual language change
            }
          },
        ),
        RadioListTile<String>(
          title: const CustomAutoSizeText(
            text: 'English',
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
          value: 'en',
          groupValue: selectedLanguage,
          onChanged: (String? value) {
            if (value != null) {
              ref.read(languageProvider.notifier).state = value;
              // TODO: implement actual language change
            }
          },
        ),
      
      ],
    );
  }

  // ExpansionTile لتغيير الثيم
  Widget _buildThemeTile(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final isDark = settings['isDarkMode'] ?? false;

    return CustomExpansionTile(
      leading: 
        isDark == true ? HugeIcons.strokeRoundedMoon02 :HugeIcons.strokeRoundedSun01,
      
      title: 'الثيم',
      subtitle: 'الثيم الحالي: ${isDark == true ? 'داكن' : 'فاتح'}',
      children: <Widget>[
        RadioListTile(
          title: const CustomAutoSizeText(
            text: 'فاتح',
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
          value: false,
          groupValue: isDark,
          onChanged: (dynamic value) async {
            await ref.read(settingsProvider.notifier).toggleDarkMode(value);
          },
        ),
        RadioListTile(
          title: const CustomAutoSizeText(
            text: 'داكن',
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
          value: true,
          groupValue: isDark,
          onChanged: (dynamic value) async {
            await ref.read(settingsProvider.notifier).toggleDarkMode(value);
          },
        ),
      ],
    );
  }

  // ExpansionTile لتحديد العملة الافتراضية
  Widget _buildCurrencyTile(BuildContext context, WidgetRef ref) {
    final selectedCurrency = ref.watch(currencyProvider);
    return CustomExpansionTile(
      leading: HugeIcons.strokeRoundedDollar01,
      title: 'العملة الافتراضية',
      subtitle: 
        'العملة الحالية: ${selectedCurrency == 'SAR'
            ? 'ريال سعودي'
            : selectedCurrency == 'USD'
            ? 'دولار أمريكي'
            : 'يمني'}',
      
      children: <Widget>[
        RadioListTile<String>(
          title: const CustomAutoSizeText(
            text: 'ريال سعودي (SAR)',
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
          value: 'SAR',
          groupValue: selectedCurrency,
          onChanged: (String? value) {
            if (value != null) {
              ref.read(currencyProvider.notifier).state = value;
            }
          },
        ),
        RadioListTile<String>(
          title: const CustomAutoSizeText(
            text: 'دولار امريكي (USD)',
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
          value: 'USD',
          groupValue: selectedCurrency,
          onChanged: (String? value) {
            if (value != null) {
              ref.read(currencyProvider.notifier).state = value;
            }
          },
        ),
        RadioListTile<String>(
          title:const CustomAutoSizeText(
            text: 'يمني (YER)',
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
          value: 'YER',
          groupValue: selectedCurrency,
          onChanged: (String? value) {
            if (value != null) {
              ref.read(currencyProvider.notifier).state = value;
            }
          },
        ),
      ],
    );
  }
  Widget _buildBackupTile(BuildContext context, WidgetRef ref) {
   final theme = ref.theme;
    return CustomExpansionTile(
      leading: HugeIcons.strokeRoundedCloudUpload,
      title: 'نسخة احتياطية',
      subtitle: 'تاريخ اخر نسخة احتياطية: 2023-06-25',
       children: <Widget>[
        ListTile(
          title: const CustomAutoSizeText(
            text: 'انشاء نسخة احتياطية',
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
          leading:HugeIcon(icon: HugeIcons.strokeRoundedCloudUpload,
           color: theme.colorScheme.onSurface),
          onTap: () {
            _showBackupDialog(context, ref);
          },
        ),
        ListTile(
          title: const CustomAutoSizeText(
            text: 'تحميل نسخة احتياطية',
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
          leading:HugeIcon(icon: HugeIcons.strokeRoundedCloudDownload,
           color: theme.colorScheme.onSurface,),
          onTap: () {
            _showBackupDialog(context, ref);
          },
        ),
        ListTile(
          title: const CustomAutoSizeText(
            text: 'حذف نسخة احتياطية',
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
          leading: HugeIcon(icon: HugeIcons.strokeRoundedDelete01,
           color: theme.colorScheme.onSurface,),
          onTap: () {
            _showBackupDialog(context, ref);
          },
        )
       ]
       );
  }

  void _showBackupDialog(BuildContext context, WidgetRef ref) {
    // الكود لم يتغير عن المثال السابق
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //       title: const Text('إنشاء نسخة احتياطية'),
    //       content: const Text(
    //         'هل أنت متأكد من رغبتك في إنشاء نسخة احتياطية الآن؟',
    //       ),
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //           child: const Text('إلغاء'),
    //         ),
    //         TextButton(
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //             ScaffoldMessenger.of(context).showSnackBar(
    //               const SnackBar(
    //                 content: Text('تم إنشاء نسخة احتياطية بنجاح!'),
    //               ),
    //             );
    //           },
    //           child: const Text('تأكيد'),
    //         ),
    //       ],
    //     );
    //   },
    // );
    final responsive = ref.responsive;
    final theme = ref.theme;
   return  CustomOverlay.show(
    context: context,
    child: Container(
      width: responsive.deviceSize.width * 0.9,
      padding: responsive.paddingAll(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           CustomAutoSizeText( text:'انشاء نسخة احتياطية',
            fontSize: 16,
            style: theme.textTheme.bodyLarge,
            fontWeight: FontWeight.w700,
            colorText: theme.colorScheme.primary ,
            ),
          const ResponsiveSpace(height: 16,),
          CustomAutoSizeText(text:  'هل انت متاكد من رغبتك في انشاء نسخة احتياطية الان؟',
          fontSize: 14,
          maxLines: 3,
          style: theme.textTheme.bodyMedium,
          colorText: theme.colorScheme.onSurface,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
             CustomButton(
              width: 50,
              text: 'الغاء',
              backgroundColor: theme.colorScheme.surface,
              textColor: theme.colorScheme.onSurface,
              onPressed: () {
                CustomOverlay.dismiss();
              },
             ),
             ResponsiveSpace(width: 24),
              CustomButton(
                width: 50,
                onPressed: () {
                  CustomOverlay.dismiss();
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                      content: CustomAutoSizeText( text:'تم انشاء نسخة احتياطية بنجاح!',
                      fontSize: 12,
                      style: theme.textTheme.bodySmall,
                      ),
                    ),
                  );
                },
                text:'تاكيد',
                backgroundColor: theme.colorScheme.primary,
              ),
    ]
    )
    ]
    )
    )
      
   );

            
              }
   
  }

