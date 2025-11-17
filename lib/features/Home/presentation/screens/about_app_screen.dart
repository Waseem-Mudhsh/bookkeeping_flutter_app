import 'package:bookkeeping_flutter_app/core/app_scaffold/adaptive_scaffold.dart';
import 'package:bookkeeping_flutter_app/core/base_layout/build_non_tabbar_layout.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

class AboutAppScreen extends ConsumerWidget {
  const AboutAppScreen({super.key});

  final String appVersion = "v1.0.0"; // Can be fetched dynamically later

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    final responsive = ref.responsive;

    return AdaptiveScaffold(
      body: BuildNonTabbarLayout(
        titleWidget: CustomAutoSizeText(
          text: 'حول التطبيق',
          style: theme.textTheme.bodyMedium,
          fontWeight: FontWeight.bold,
          fontSize: 12,
          colorText: theme.colorScheme.primary,
        ),
        slivers: [
          const SliverToBoxAdapter(child: ResponsiveSpace(height: 24)),
          SliverToBoxAdapter(
            child: Padding(
              padding: responsive.paddingSym(h: 16),
              child: Column(
                children: [
                  CustomHugeIcon(
                    icon: HugeIcons.strokeRoundedInformationSquare,
                    color: theme.colorScheme.primary,
                    size: 80,
                  ),
                  const ResponsiveSpace(height: 16),
                  CustomAutoSizeText(
                    text: 'تطبيق تابع',
                    style: theme.textTheme.headlineMedium,
                    fontWeight: FontWeight.bold,
                    colorText: theme.colorScheme.primary,
                  ),
                  CustomAutoSizeText(
                    text: 'الإصدار $appVersion',
                    // style: theme.textTheme.bodySmall,
                    colorText: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                  ),
                  const ResponsiveSpace(height: 32),
                  _buildInfoList(ref),
                  const ResponsiveSpace(height: 48),
                  CustomAutoSizeText(
                    text: '© ${DateTime.now().year} Waseem Dev. جميع الحقوق محفوظة.',
                    style: theme.textTheme.labelSmall,
                    colorText: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                    fontSize: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoList(WidgetRef ref) {
    return Column(
      children: [
        _buildInfoTile(
          ref,
          icon: HugeIcons.strokeRoundedDocumentCode,
          title: 'شروط الخدمة',
          onTap: () {
            // TODO: Implement navigation to Terms of Service page/URL
          },
        ),
        _buildInfoTile(
          ref,
          icon: HugeIcons.strokeRoundedShield02,
          title: 'سياسة الخصوصية',
          onTap: () {
            // TODO: Implement navigation to Privacy Policy page/URL
          },
        ),
        _buildInfoTile(
          ref,
          icon: HugeIcons.strokeRoundedCopyright,
          title: 'تراخيص المصادر المفتوحة',
          onTap: () {
            // TODO: Implement navigation to Open Source Licenses page
          },
        ),
      ],
    );
  }

  Widget _buildInfoTile(WidgetRef ref, {required IconData icon, required String title, VoidCallback? onTap}) {
    final theme = ref.theme;
    final responsive = ref.responsive;
    return Container(
      margin: responsive.paddingOnly(bottom: 8),
      child: ListTile(
        onTap: onTap,
        leading: CustomHugeIcon(icon: icon, color: theme.colorScheme.primary, size: 24),
        title: CustomAutoSizeText(
          text: title,
          style: theme.textTheme.bodyMedium,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        trailing: const CustomHugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01, size: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
