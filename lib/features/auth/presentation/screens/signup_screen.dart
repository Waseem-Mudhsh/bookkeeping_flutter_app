import 'package:bookkeeping_flutter_app/core/base_layout/base_layout_screen.dart';
import 'package:bookkeeping_flutter_app/core/base_layout/build_non_tabbar_layout.dart';
import 'package:bookkeeping_flutter_app/core/providers/settings_provider.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_padding.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_text_form_field.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:bookkeeping_flutter_app/features/auth/presentation/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';



class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(loadingStateProvider.notifier).state = true;

      await ref.read(settingsProvider.notifier).registerUser(
            _usernameController.text,
            _phoneController.text,
            _passwordController.text,
          );

      ref.read(loadingStateProvider.notifier).state = false;

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomAutoSizeText(
              text: 'تم إنشاء الحساب بنجاح! يمكنك الآن تسجيل الدخول.',
              colorText: ref.theme.colorScheme.onPrimary,
              style: ref.theme.textTheme.bodySmall,
              fontSize: 10,
            ),
            backgroundColor: ref.theme.colorScheme.primary,
          ),
        );
        // العودة إلى شاشة تسجيل الدخول
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPasswordVisible = ref.watch(passwordVisibilityProvider);
    final isLoading = ref.watch(loadingStateProvider);
    final responsive = ref.responsive;
    final theme = ref.theme;

    return BaseLayoutScreen(
      backgroundColor: theme.colorScheme.surface,
      body: BuildNonTabbarLayout(
        padding: 0,
        physics: responsive.orientation == Orientation.portrait
            ? const NeverScrollableScrollPhysics()
            : const ClampingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Container(
                  color: ref.theme.colorScheme.surface,
                  constraints: BoxConstraints(
                    minHeight: responsive.deviceSize.height,
                    maxHeight: responsive.deviceSize.height * 1.5,
                  ),
                ),
                _buildLogo(ref),
                Positioned(
                  top: responsive.h(150),
                  left: 0,
                  right: 0,
                  child: CustomPadding(
                    horizontal: 64,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildSignUpForm(ref, isPasswordVisible, isLoading, _handleSignUp),
                        const ResponsiveSpace(height: 16),
                        _buildBottomSection(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo(WidgetRef ref) {
    final theme = ref.theme;
    return Container(
      width: double.infinity,
      height: ref.responsive.h(200),
      color: theme.colorScheme.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const ResponsiveSpace(height: 32),
          CustomAutoSizeText(
            text: '{ }',
            colorText: theme.colorScheme.onPrimary,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            style: theme.textTheme.headlineMedium,
          ),
          CustomAutoSizeText(
            text: 'تطبيق تابع',
            colorText: theme.colorScheme.onPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            style: theme.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpForm(WidgetRef ref, bool isPasswordVisible, bool isLoading, Future<void> Function() performSignUp) {
    final theme = ref.theme;
    final responsive = ref.responsive;
    return Padding(
      padding: responsive.paddingSym(h: 16),
      child: Card(
        elevation: 6.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: responsive.paddingSym(h: 24, v: 32),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomAutoSizeText(
                  text: 'إنشاء حساب جديد',
                  style: theme.textTheme.headlineMedium,
                  fontWeight: FontWeight.bold,
                  colorText: theme.colorScheme.primary,
                ),
                const ResponsiveSpace(height: 32),
                CustomTextField(
                  controller: _usernameController,
                  label: 'اسم المستخدم',
                  hint: 'ادخل اسم المستخدم',
                  prefixIcon:  CustomHugeIcon(icon: HugeIcons.strokeRoundedUser02,
                  color: theme.colorScheme.onSurface,),
                  validator: (value) => value == null || value.isEmpty ? 'الرجاء إدخال اسم المستخدم' : null,
                ),
                const ResponsiveSpace(height: 16),
                CustomTextField(
                  controller: _phoneController,
                  label: 'رقم الهاتف',
                  prefixIcon:  CustomHugeIcon(icon: HugeIcons.strokeRoundedSmartPhone01,
                  color: theme.colorScheme.onSurface,),
                  hint: 'ادخل رقم الهاتف',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(9),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'الرجاء إدخال رقم الهاتف';
                    if (value.length != 9) return 'يجب أن يتكون الرقم من 9 أرقام';
                    return null;
                  },
                ),
                const ResponsiveSpace(height: 16),
                CustomTextField(
                  controller: _passwordController,
                  obscureText: !isPasswordVisible,
                  label: 'كلمة المرور',
                  hint: 'ادخل كلمة المرور',
                  prefixIcon: CustomHugeIcon(icon: HugeIcons.strokeRoundedCircleLock01,
                  color: theme.colorScheme.onSurface,),
                  suffixIcon: IconButton(
                    icon: CustomHugeIcon(
                      icon: isPasswordVisible ? HugeIcons.strokeRoundedViewOffSlash : HugeIcons.strokeRoundedView,
                    ),
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
                  prefixIcon:  CustomHugeIcon(icon: HugeIcons.strokeRoundedCircleLock01,
                  color: theme.colorScheme.onSurface,),
                  validator: (value) {
                    if (value != _passwordController.text) return 'كلمتا المرور غير متطابقتين';
                    return null;
                  },
                ),
                const ResponsiveSpace(height: 32),
                CustomButton(
                  backgroundColor: theme.colorScheme.primary,
                  textColor: theme.colorScheme.onPrimary,
                  text: 'إنشاء الحساب',
                  isLoading: isLoading,
                  onPressed: isLoading ? null : performSignUp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    final theme = ref.theme;
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomAutoSizeText(
            text: 'لديك حساب بالفعل؟',
            style: theme.textTheme.bodySmall,
            fontSize: 10,
            colorText: theme.colorScheme.onSurface,
          ),
          const ResponsiveSpace(width: 4),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: CustomAutoSizeText(
              text: 'تسجيل الدخول',
              style: theme.textTheme.bodySmall,
              colorText: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
