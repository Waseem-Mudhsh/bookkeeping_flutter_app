import 'package:bookkeeping_flutter_app/core/app_scaffold/adaptive_scaffold.dart';
import 'package:bookkeeping_flutter_app/core/base_layout/build_non_tabbar_layout.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

class AboutUsScreen extends ConsumerWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    final responsive = ref.responsive;

    return AdaptiveScaffold(
      body: BuildNonTabbarLayout(
        titleWidget: CustomAutoSizeText(
          text: 'من نحن',
          style: theme.textTheme.bodyMedium,
          fontWeight: FontWeight.bold,
          fontSize: 14, // Consistent with other main titles
          colorText: theme.colorScheme.primary,
        ),
        slivers: [
          const SliverToBoxAdapter(child: ResponsiveSpace(height: 24)),
          SliverToBoxAdapter(
            child: Padding(
              padding: responsive.paddingSym(h: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Logo/Icon
                  Center(
                    child: CustomHugeIcon(
                      icon: HugeIcons.strokeRoundedBook01, // Placeholder icon, replace with actual app logo
                      color: theme.colorScheme.primary,
                      size: 80,
                    ),
                  ),
                  const ResponsiveSpace(height: 16),
                  Center(
                    child: CustomAutoSizeText(
                      text: 'تطبيق تابع',
                      style: theme.textTheme.headlineMedium,
                      fontWeight: FontWeight.bold,
                      colorText: theme.colorScheme.primary,
                    ),
                  ),
                  const ResponsiveSpace(height: 32),

                  // Section: Our Vision
                  _buildSectionTitle(ref, 'رؤيتنا', HugeIcons.strokeRoundedEye),
                  const ResponsiveSpace(height: 12),
                  CustomAutoSizeText(
                    text: 'نسعى في تطبيق "تابع" إلى تمكين الأفراد والشركات الصغيرة من إدارة حساباتهم المالية وديونهم بكفاءة ويسر. رؤيتنا هي توفير أداة شاملة وموثوقة تساعدك على تتبع معاملاتك، وتحسين قراراتك المالية، وتحقيق الاستقرار الاقتصادي.',
                    style: theme.textTheme.bodyMedium,
                    colorText: theme.colorScheme.onSurfaceVariant,
                    fontSize: 12, // Consistent with body text in SupportScreen
                    maxLines: 10,
                  ),
                  const ResponsiveSpace(height: 24),

                  // Section: Our Mission
                  _buildSectionTitle(ref, 'رسالتنا', HugeIcons.strokeRoundedTarget01),
                  const ResponsiveSpace(height: 12),
                  CustomAutoSizeText(
                    text: 'تتمثل رسالتنا في تقديم حلول تقنية مبتكرة وسهلة الاستخدام لإدارة الديون والحسابات، مع التركيز على الأمان والخصوصية. نحن ملتزمون بتقديم دعم مستمر وتحديثات دورية لضمان أفضل تجربة لمستخدمينا.',
                    style: theme.textTheme.bodyMedium,
                    colorText: theme.colorScheme.onSurfaceVariant,
                    fontSize: 12, // Consistent with body text in SupportScreen
                    maxLines: 10,
                  ),
                  const ResponsiveSpace(height: 24),

                  // Section: The Team (Optional, can be simplified)
                  _buildSectionTitle(ref, 'فريق العمل', HugeIcons.strokeRoundedUserGroup),
                  const ResponsiveSpace(height: 12),
                  CustomAutoSizeText(
                    text: 'يتكون فريق "تابع" من مجموعة من المطورين والمصممين والخبراء الماليين الشغوفين بتقديم أفضل الحلول التقنية. نعمل معًا لضمان أن يكون تطبيقنا يلبي احتياجاتك ويتجاوز توقعاتك.',
                    style: theme.textTheme.bodyMedium,
                    colorText: theme.colorScheme.onSurfaceVariant,
                    fontSize: 12, // Consistent with body text in SupportScreen
                    maxLines: 10,
                  ),
                  const ResponsiveSpace(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(WidgetRef ref, String title, IconData icon) {
    final theme = ref.theme;
    return Row(
      children: [
        CustomHugeIcon(icon: icon, color: theme.colorScheme.primary, size: 20),
        const ResponsiveSpace(width: 8),
        CustomAutoSizeText(
          text: title,
          style: theme.textTheme.bodyMedium, // Using bodyMedium as base
          fontWeight: FontWeight.bold,
          fontSize: 14, // Consistent with main title and section titles in SupportScreen
          colorText: theme.colorScheme.primary, // Consistent with main title
        ),
      ],
    );
  }
}
