import 'dart:ui'; // Required for BackdropFilter
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
      backgroundColor: Colors.transparent, // Make drawer background transparent
      child: BackdropFilter(
        
        // Apply the frosted glass effect
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withValues(alpha: 0.8),
          ),
          child: Column(
            children: <Widget>[
              const ResponsiveSpace(height: 48),

              // 1. Drawer Header (Modernized)
              _buildHeader(context, ref, account),
              const ResponsiveSpace(height: 16),

              // 2. Menu Options
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Accounts section
                      _buildMenuItem(
                        context,
                        ref,
                        title: 'الصفحة الرئيسية',
                        subTitle: 'عرض جميع الحسابات والرصيد الكلي',
                        icon: HugeIcons.strokeRoundedWallet01,
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => RouteNames.home.screen));
                        },
                      ),
                      _buildMenuItem(
                        context,
                        ref,
                        title: 'الديون الشخصية',
                        subTitle: 'عرض الديون الشخصية',
                        icon: HugeIcons.strokeRoundedWallet01,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RouteNames.debtsOfClientScreen.screen));
                        },
                      ),
                      const ResponsiveSpace(height: 16),
                      // Separator
                      _buildSeparator(context, ref),
                      const ResponsiveSpace(height: 16),
                      // Other menu items
                      _buildMenuItem(
                        context,
                        ref,
                        title: 'الإعدادات',
                        subTitle: 'تغيير اللغة، الثيم، العملة، ونسخة احتياطية',
                        icon: HugeIcons.strokeRoundedSetting06,
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => RouteNames.settings.screen));
                        },
                      ),
                      _buildMenuItem(
                        context,
                        ref,
                        title: 'الدعم والمساعدة',
                        subTitle: 'تواصل معنا في حال وجود أي مشكلة',
                        icon: HugeIcons.strokeRoundedCustomerService,
                        onTap: () {
                          Navigator.pop(context); 
                        },
                      ),
                      _buildMenuItem(
                        context,
                        ref,
                        title: 'من نحن',
                        subTitle: 'معلومات عن فريق العمل',
                        icon: HugeIcons.strokeRoundedUserGroup,
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      _buildMenuItem(
                        context,
                        ref,
                        title: 'حول التطبيق',
                        subTitle: 'معلومات عن التطبيق',
                        icon: HugeIcons.strokeRoundedInformationSquare,
                        onTap: () {
                          Navigator.pop(context); 
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // 3. Logout Button and Version
              _buildSeparator(context, ref),
              const ResponsiveSpace(height: 16),
              Padding(
                padding: responsive.paddingSym(h: 16),
                child: CustomButton(
                  text: 'تسجيل الخروج',
                  onPressed: () {
                    
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RouteNames.loginScreen.screen));
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
        ),
      ),
    );
  }

  // --- Widgets for Reusability ---

  Widget _buildHeader(BuildContext context, WidgetRef ref, Account? account) {
    final theme = ref.theme;
    final responsive = ref.responsive;
    return Container(
      margin: responsive.paddingSym(h: 16),
      padding: responsive.paddingSym(h: 12, v: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: theme.colorScheme.onPrimary,
          child: account != null
              ? Text(
                  account.name.isNotEmpty ? account.name[0] : '',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : CustomHugeIcon(
                  icon: HugeIcons.strokeRoundedUser,
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
        ),
        title: CustomAutoSizeText(
          text: account?.name.isNotEmpty ?? false ? account!.name : 'اسم المستخدم',
          style: theme.textTheme.bodyMedium,
          fontWeight: FontWeight.bold,
          colorText: theme.colorScheme.onPrimary,
          fontSize: 14,
        ),
        subtitle: CustomAutoSizeText(
          text: account?.category.isNotEmpty ?? false
              ? account!.category
              : 'تعديل البيانات الشخصية',
          style: theme.textTheme.bodyMedium,
          fontWeight: FontWeight.w600,
          colorText: theme.colorScheme.onPrimary.withValues(alpha: 0.6),
          fontSize: 10,
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RouteNames.profile.screen));
        },
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
    final responsive = ref.responsive;
    return Padding(
      padding: responsive.paddingSym(h: 12, v: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: theme.colorScheme.primary.withValues(alpha: 0.2),
          highlightColor: theme.colorScheme.primary.withValues(alpha: 0.1),
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: responsive.paddingSym(h: 16, v: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                CustomHugeIcon( icon: icon, color: theme.colorScheme.primary),
                const ResponsiveSpace(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomAutoSizeText(
                        text: title,
                        style: theme.textTheme.bodyMedium,
                        colorText: theme.colorScheme.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      const ResponsiveSpace(height: 4),
                      CustomAutoSizeText(
                        text: subTitle,
                        style: theme.textTheme.bodySmall,
                        colorText: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSeparator(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
    );
  }
}