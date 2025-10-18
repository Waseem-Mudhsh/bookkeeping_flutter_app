import 'package:bookkeeping_flutter_app/core/base_layout/base_layout_screen.dart';
import 'package:bookkeeping_flutter_app/core/base_layout/build_non_tabbar_layout.dart';
import 'package:bookkeeping_flutter_app/core/providers/settings_provider.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/utils/route_names.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_text_form_field.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../providers/login_provider.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  final String phoneNumber;
  const ResetPasswordScreen({super.key, required this.phoneNumber});

  @override
  ConsumerState<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKeyResetPassword = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (_formKeyResetPassword.currentState?.validate() ?? false) {
      await ref.read(settingsProvider.notifier).updatePassword(
            widget.phoneNumber,
            _passwordController.text,
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomAutoSizeText(text: 'تم تحديث كلمة المرور بنجاح',
            style: ref.theme.textTheme.bodySmall,
           colorText:ref.theme.colorScheme.onPrimary,fontSize: 10,),
            backgroundColor: ref.theme.colorScheme.primary,
          ),
        );
        // Go back to login screen
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => RouteNames.loginScreen.screen),
          (Route<dynamic> route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.theme;
    final responsive = ref.responsive;
    final isPasswordVisible = ref.watch(passwordVisibilityProvider);

    return BaseLayoutScreen(
      body: BuildNonTabbarLayout(
        titleWidget: CustomAutoSizeText(
          text: 'تعيين كلمة مرور جديدة',
          style: theme.textTheme.bodyMedium,
          fontWeight: FontWeight.bold,
          fontSize: 12,
          colorText: theme.colorScheme.primary,
        ),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: responsive.paddingSym(h: 16),
              child: Form(
                key: _formKeyResetPassword,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CustomHugeIcon(icon: HugeIcons.strokeRoundedKey01, size: 60),
                    const ResponsiveSpace(height: 32),
                    CustomTextField(
                      controller: _passwordController,
                      obscureText: !isPasswordVisible,
                      label: 'كلمة المرور الجديدة',
                      hint: 'ادخل كلمة المرور',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: CustomHugeIcon(icon: isPasswordVisible ? HugeIcons.strokeRoundedViewOffSlash : HugeIcons.strokeRoundedView),
                        onPressed: () => ref.read(passwordVisibilityProvider.notifier).state = !isPasswordVisible,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'الرجاء إدخال كلمة المرور';
                        if (value.length < 6) return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                        return null;
                      },
                    ),
                    const ResponsiveSpace(height: 16),
                    CustomTextField(
                      controller: _confirmPasswordController,
                      obscureText: !isPasswordVisible,
                      label: 'تأكيد كلمة المرور',
                      hint: 'أعد إدخال كلمة المرور',
                      prefixIcon: const Icon(Icons.lock_outline),
                      validator: (value) {
                        if (value != _passwordController.text) return 'كلمتا المرور غير متطابقتين';
                        return null;
                      },
                    ),
                    const ResponsiveSpace(height: 32),
                    CustomButton(
                      text: 'حفظ كلمة المرور',
                      onPressed: _resetPassword,
                      backgroundColor: theme.colorScheme.primary,
                      textColor: theme.colorScheme.onPrimary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
