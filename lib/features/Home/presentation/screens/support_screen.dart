import 'package:bookkeeping_flutter_app/core/base_layout/base_layout_screen.dart';
import 'package:bookkeeping_flutter_app/core/base_layout/build_non_tabbar_layout.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_expansion_tile.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

class SupportScreen extends ConsumerWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;

    return BaseLayoutScreen(
      body: BuildNonTabbarLayout(
        titleWidget: CustomAutoSizeText(
          text: 'الدعم والمساعدة',
          style: theme.textTheme.bodyMedium,
          fontWeight: FontWeight.bold,
          fontSize: 12,
          colorText: theme.colorScheme.primary,
        ),
        slivers: [
          const SliverToBoxAdapter(child: ResponsiveSpace(height: 24)),
          SliverToBoxAdapter(
            child: _buildSectionTitle(ref, 'الأسئلة الشائعة', HugeIcons.strokeRoundedHelpCircle),
          ),
          const SliverToBoxAdapter(child: ResponsiveSpace(height: 16)),
          SliverToBoxAdapter(child: _buildFaqList(ref)),
          const SliverToBoxAdapter(child: ResponsiveSpace(height: 32)),
          SliverToBoxAdapter(
            child: _buildSectionTitle(ref, 'تواصل معنا', HugeIcons.strokeRoundedCustomerService),
          ),
          const SliverToBoxAdapter(child: ResponsiveSpace(height: 16)),
          _buildContactList(ref),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(WidgetRef ref, String title, IconData icon) {
    final theme = ref.theme;
    return Row(
      children: [
        CustomHugeIcon(icon: icon, color: theme.colorScheme.onSurfaceVariant, size: 20),
        const ResponsiveSpace(width: 8),
        CustomAutoSizeText(
          text: title,
          style: theme.textTheme.bodyMedium,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          colorText: theme.colorScheme.onSurfaceVariant,
        ),
      ],
    );
  }

  Widget _buildFaqList(WidgetRef ref) {
    final theme = ref.theme;
    

    final faqs = {
      'كيف يمكنني إضافة حساب جديد؟': 'من الشاشة الرئيسية، اضغط على زر "إضافة حساب جديد" واتبع التعليمات لملء بيانات الحساب.',
      'هل يمكنني تصدير بياناتي؟': 'نعم، من شاشة الإعدادات يمكنك العثور على خيار "تصدير البيانات" لحفظ نسخة من معلوماتك.',
      'كيف أغير كلمة المرور؟': 'يمكنك تغيير كلمة المرور من خلال صفحة "الملف الشخصي" ثم اختيار "تغيير كلمة المرور".',
      'ماذا أفعل إذا نسيت كلمة المرور؟': 'في شاشة تسجيل الدخول، اضغط على "هل نسيت كلمة المرور؟" واتبع الخطوات لاستعادتها عبر رقم الهاتف.',
    };

    return Container(
       decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.5), width: 0.5),
        color: theme.colorScheme.surface,
      ),
      margin: EdgeInsets.zero,
      
      child: Column(
        children: faqs.entries.map((entry) {
          final question = entry.key;
          final answer = entry.value;
          return Column(
            children: [
              CustomExpansionTile(
                title:question,
                
                children: [
                  CustomAutoSizeText(
                    text: answer,
                    style: theme.textTheme.bodyMedium,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    colorText: theme.colorScheme.onSurfaceVariant,
                    maxLines: 5,
                  ),
                ],
              ),
              if (entry != faqs.entries.last) Divider(
                thickness: 0.5,
                height: 0.5,
                indent: 16,
                endIndent: 16,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
              ),
            ],
          );
        }).toList(),
      )
    );
  }

  Widget _buildContactList(WidgetRef ref) {
    

    return SliverList(
      delegate: SliverChildListDelegate([
        _buildContactTile(
          ref,
          icon: HugeIcons.strokeRoundedMail01,
          title: 'البريد الإلكتروني',
          subtitle: 'support@example.com',
          onTap: () {
            // TODO: Implement launch email client
          },
        ),
        _buildContactTile(
          ref,
          icon: HugeIcons.strokeRoundedSmartPhone01,
          title: 'رقم الهاتف',
          subtitle: '+967 123 456 789',
          onTap: () {
            // TODO: Implement launch phone dialer
          },
        ),
      ]),
    );
  }

  Widget _buildContactTile(WidgetRef ref, {required IconData icon, required String title, required String subtitle, VoidCallback? onTap}) {
    final theme = ref.theme;
    final responsive = ref.responsive;
    return Container(
      margin: responsive.paddingOnly(bottom: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: CustomHugeIcon(icon: icon, color: theme.colorScheme.primary, size: 24),
        title: CustomAutoSizeText(
          text: title,
          style: theme.textTheme.bodyMedium,
          fontWeight: FontWeight.w600,
          colorText: theme.colorScheme.primary,
          fontSize: 12,
        ),
        subtitle: CustomAutoSizeText(
          text: subtitle,
          style: theme.textTheme.bodySmall,
          colorText: theme.colorScheme.onSurfaceVariant,
        ),
        trailing: const CustomHugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01, size: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
class _QuestionsAndAnswersSection extends ConsumerWidget {
  final Widget title;
  final List<Widget> children;
  

  const _QuestionsAndAnswersSection({
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
          title,
          const ResponsiveSpace(height: 12),
          Container(
            decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.5), width: 0.5),
        color: theme.colorScheme.surface,
      ),
      margin: EdgeInsets.zero,

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