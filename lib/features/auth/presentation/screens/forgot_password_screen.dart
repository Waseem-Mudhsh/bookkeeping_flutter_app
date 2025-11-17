import 'package:bookkeeping_flutter_app/core/app_scaffold/adaptive_scaffold.dart';
import 'package:bookkeeping_flutter_app/core/base_layout/build_non_tabbar_layout.dart';
import 'package:bookkeeping_flutter_app/core/providers/shared_preferences_provider.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/utils/route_names.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_text_form_field.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../providers/login_provider.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKeyForgotPassword = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _sendVerificationCode() {
    if (_formKeyForgotPassword.currentState?.validate() ?? false) {
      // Simulate sending code and navigate to OTP screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RouteNames.otpVerificationScreen.screenWithArgs({
            'phoneNumber': _phoneController.text,
          }),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.theme;
    final responsive = ref.responsive;
    final isLoading = ref.watch(loadingStateProvider);
    final phoneNumber = ref.watch(sharedPreferencesProvider).value?.getString('userPhoneNumber') ?? '';

    return AdaptiveScaffold(
      body: BuildNonTabbarLayout(
        titleWidget: CustomAutoSizeText(
          text: 'استعادة كلمة المرور',
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
                key: _formKeyForgotPassword,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CustomHugeIcon(
                      icon: HugeIcons.strokeRoundedMessageQuestion,
                      size: 60,
                    ),
                    const ResponsiveSpace(height: 16),
                    CustomAutoSizeText(
                      text: 'أدخل رقم هاتفك المسجل لإرسال رمز التحقق',
                      style: theme.textTheme.bodyMedium,
                      colorText: theme.colorScheme.onSurfaceVariant,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      fontSize: 12,
                    ),
                    const ResponsiveSpace(height: 32),
                    CustomTextField(
                      controller: _phoneController,
                      label: 'رقم الهاتف',
                      hint: 'ادخل رقم الهاتف',
                      prefixIcon: CustomHugeIcon(
                        icon: HugeIcons.strokeRoundedSmartPhone01,
                        color: theme.colorScheme.onSurface,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(9),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال رقم الهاتف';
                        }
                        if (value.length != 9) {
                          return 'يجب أن يتكون الرقم من 9 أرقام';
                        }
                        if (value != phoneNumber) {
                          return 'يرجى إدخال رقم هاتف صحيح';
                        }
                        return null;
                      },
                    ),
                    const ResponsiveSpace(height: 32),
                    CustomButton(
                      text: 'إرسال الرمز',
                      onPressed: isLoading ? null : _sendVerificationCode,
                      isLoading: isLoading,
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
