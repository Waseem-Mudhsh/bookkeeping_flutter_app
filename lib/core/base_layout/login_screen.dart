import 'package:bookkeeping_flutter_app/core/base_layout/base_layout_screen.dart';
import 'package:bookkeeping_flutter_app/core/base_layout/build_non_tabbar_layout.dart';
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

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    // أولاً، تحقق من صحة المدخلات
    if (_formKey.currentState?.validate() ?? false) {
      final username = _usernameController.text.trim();
      final password = _passwordController.text.trim();

      // التحقق من بيانات الاعتماد
      if (username == 'admin' && password == 'admin') {
        // في حال النجاح، انتقل إلى الشاشة الرئيسية
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RouteNames.home.screen),
        );
      } else {
        // في حال الفشل، أظهر رسالة خطأ
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: ref.theme.colorScheme.error,
            content: CustomAutoSizeText(
              text: 'اسم المستخدم أو كلمة المرور غير صحيحة!',
              colorText: ref.theme.colorScheme.onError,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.theme;
    final responsive = ref.responsive;

    return BaseLayoutScreen(
      body: BuildNonTabbarLayout(
        titleWidget: CustomAutoSizeText(
          text: 'تسجيل الدخول',
          style: theme.textTheme.bodyMedium,
          fontWeight: FontWeight.bold,
          fontSize: 12,
          colorText: theme.colorScheme.primary,
        ),
        hasLeading: false,
        
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: responsive.paddingSym(h: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CustomHugeIcon(
                      icon: HugeIcons.strokeRoundedUser02,
                      size: 60,
                    ),
                    const ResponsiveSpace(height: 32),
                    CustomTextField(
                      controller: _usernameController,
                      label: 'اسم المستخدم',
                      hint: 'ادخل اسم المستخدم',
                      suffixIcon: const CustomHugeIcon(icon: HugeIcons.strokeRoundedUser02),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال اسم المستخدم';
                        }
                        return null;
                      },
                    ),
                    const ResponsiveSpace(height: 16),
                    CustomTextField(
                      controller: _passwordController,
                      label: 'كلمة المرور',
                      hint: 'ادخل كلمة المرور',
                      
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      suffixIcon: const CustomHugeIcon(icon: HugeIcons.strokeRoundedKey01),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال كلمة المرور';
                        }
                        return null;
                      },
                    ),
                    const ResponsiveSpace(height: 32),
                    CustomButton(
                      text: 'تسجيل الدخول',
                      onPressed: _handleLogin,
                      backgroundColor: theme.colorScheme.primary,
                      textColor: theme.colorScheme.onPrimary,
                    ),
                    const ResponsiveSpace(height: 16),
                    TextButton(
                      onPressed: () {
                        // TODO: Implement forgot password functionality
                      },
                      child: const Text('هل نسيت كلمة المرور؟'),
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