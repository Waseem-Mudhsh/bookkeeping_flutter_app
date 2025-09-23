import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/utils/route_names.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/domain/entities/account.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomDrawer extends ConsumerWidget {
  final Account? account;
  const CustomDrawer({super.key, this.account});

  final String appVersion = "v1.0.0";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    final responsive = ref.responsive;

    return Drawer(
      width: responsive.deviceSize.width * 0.9,
      backgroundColor: theme.colorScheme.surface,
      child: Column(
        children: <Widget>[
          // 1. رأس الـ Drawer (Header)
          _buildHeader(context, theme, account),

          // 2. قائمة الخيارات (Menu)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const ResponsiveSpace(height: 4),
                  _buildMenuItem(
                    context,
                    ref,
                    title: 'الصفحة الرئيسية',
                    subTitle: 'العودة إلى الصفحة الرئيسية للتطبيق',
                    icon: Icons.home_outlined,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RouteNames.home.screen));
                    },
                  ),
                  _buildMenuItem(
                    context,
                    ref,
                    title: 'الإعدادات',
                    subTitle: 'تغيير اللغة، الثيم، العملة، ونسخة احتياطية',
                    icon: Icons.settings_outlined,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RouteNames.settings.screen));
                    },
                  ),
                  const ResponsiveSpace(height: 8),
                  const Divider(thickness: 0.5, height: 0.5, color: Colors.grey),
                  const ResponsiveSpace(height: 8),
                  _buildMenuItem(
                    context,
                    ref,
                    title: 'الدعم والمساعدة',
                    subTitle: 'تواصل معنا في حال وجود أي مشكلة',
                    icon: Icons.support_agent_outlined,
                    onTap: () {
                      Navigator.pop(context); // TODO: Navigate to Support
                    },
                  ),
                  _buildMenuItem(
                    context,
                    ref,
                    title: 'من نحن',
                    subTitle: 'معلومات عن فريق العمل',
                    icon: Icons.people_outline,
                    onTap: () {
                      Navigator.pop(context); // TODO: Navigate to About Us
                    },
                  ),
                  _buildMenuItem(
                    context,
                    ref,
                    title: 'حول التطبيق',
                    subTitle: 'معلومات عن التطبيق',
                    icon: Icons.info_outline,
                    onTap: () {
                      Navigator.pop(context); // TODO: Navigate to App Info
                    },
                  ),
                ],
              ),
            ),
          ),

          // 3. زر تسجيل الخروج ورقم الإصدار
          const Divider(thickness: 0.5, height: 0.5, color: Colors.grey),
          const ResponsiveSpace(height: 16),
          Padding(
            padding: responsive.paddingSym(h: 16),
            child: CustomButton(
              text: 'تسجيل الخروج',
              onPressed: () {
                // TODO: Implement Logout Logic
                Navigator.pop(context);
              },
              backgroundColor: theme.colorScheme.error,
              textColor: theme.colorScheme.onError,
            ),
          ),
          const ResponsiveSpace(height: 16),
          Text(
            'الإصدار: $appVersion',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
            ),
          ),
          const ResponsiveSpace(height: 16),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme, Account? account) {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(color: theme.colorScheme.primary),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: theme.colorScheme.onPrimaryContainer,
              child: account != null
                  ? Text(
                      account.name.isNotEmpty ? account.name[0] : '',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RouteNames.profile.screen));
                    },
                    icon: CustomHugeIcon(icon: HugeIcons.strokeRoundedUser,
                    color: theme.colorScheme.primary,
                    size: 32,)
                      
                      
                      
                    ),
            ),
            const ResponsiveSpace(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAutoSizeText(
                    text: account?.name.isNotEmpty ?? false
                        ? account!.name
                        : 'حساب تجريبي',
                    style: theme.textTheme.bodyMedium,
                    fontWeight: FontWeight.bold,
                    colorText: theme.colorScheme.onPrimary,
                    fontSize: 16,
                  ),
                  const ResponsiveSpace(height: 4),
                  CustomAutoSizeText(
                    text: account?.category.isNotEmpty ?? false
                        ? account!.category
                        : 'حساب تجريبي',
                    style: theme.textTheme.bodyMedium,
                    fontWeight: FontWeight.w600,
                    colorText: theme.colorScheme.onPrimary.withValues(alpha: 0.6),
                    fontSize: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required String subTitle,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    final theme = ref.theme;
    final responsive =ref.responsive;
    
    // الألوان الافتراضية
    final iconColor = theme.colorScheme.primary;
    final textColor = theme.colorScheme.primary;
    final tileColor = Colors.transparent;

    return Padding(
      padding: responsive.paddingSym(h: 16,v: 4),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        tileColor: tileColor,
        contentPadding:  responsive.paddingSym(h: 16,v: 4),
        onTap: onTap,
        leading: Icon(icon, color: iconColor),
        title: CustomAutoSizeText(
          text: title,
          style: theme.textTheme.bodyMedium,
          colorText: textColor,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        subtitle: CustomAutoSizeText(
          text: subTitle,
          style: theme.textTheme.bodySmall,
          colorText: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          fontSize: 12,
        ),
      ),
    );
  }
}