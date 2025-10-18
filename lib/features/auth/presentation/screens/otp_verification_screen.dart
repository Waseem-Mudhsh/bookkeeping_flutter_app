import 'dart:async';
import 'package:bookkeeping_flutter_app/core/base_layout/base_layout_screen.dart';
import 'package:bookkeeping_flutter_app/core/base_layout/build_non_tabbar_layout.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/utils/route_names.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:pinput/pinput.dart';




class OtpVerificationScreen extends ConsumerStatefulWidget {
  final String phoneNumber;
  const OtpVerificationScreen({super.key, required this.phoneNumber});

  @override
  ConsumerState<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  final _pinController = TextEditingController();
  final _formKeyOtpVerification = GlobalKey<FormState>();
  Timer? _timer;
  int _start = 60;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    _start = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        if (mounted) {
          setState(() => timer.cancel());
        }
      } else {
        if (mounted) {
          setState(() => _start--);
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pinController.dispose();
    super.dispose();
  }

  void _verifyOtp() {
    if (_formKeyOtpVerification.currentState?.validate() ?? false) {
      // Simulate OTP check
      if (_pinController.text == "1234") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RouteNames.resetPasswordScreen.screenWithArgs({
              'phoneNumber': widget.phoneNumber,
            }),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomAutoSizeText(text: 'رمز التحقق غير صحيح',
            fontSize: 10, colorText: ref.theme.colorScheme.onError),
            backgroundColor: ref.theme.colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.theme;
    final responsive = ref.responsive;

    final defaultPinTheme = PinTheme(
      width: responsive.w(56),
      height: responsive.h(56),
      textStyle: theme.textTheme.headlineSmall?.copyWith(color: theme.colorScheme.primary),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    return BaseLayoutScreen(
      body: BuildNonTabbarLayout(
        titleWidget: CustomAutoSizeText(
          text: 'التحقق من الرمز',
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
                key: _formKeyOtpVerification,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomHugeIcon(icon: HugeIcons.strokeRoundedShield01, size: 60),
                    const ResponsiveSpace(height: 16),
                    CustomAutoSizeText(
                      text: 'تم إرسال رمز التحقق إلى الرقم\n+967 ${widget.phoneNumber}',
                      style: theme.textTheme.bodyMedium,
                      colorText: theme.colorScheme.onSurfaceVariant,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      fontSize: 12,
                    ),
                    const ResponsiveSpace(height: 32),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        length: 4,
                        controller: _pinController,
                        keyboardType: TextInputType.number,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            border: Border.all(color: theme.colorScheme.primary),
                          ),
                        ),
                        submittedPinTheme: defaultPinTheme,
                        validator: (s) => s?.length == 4 ? null : 'الرجاء إكمال الرمز',
                      ),
                    ),
                    const ResponsiveSpace(height: 32),
                    CustomButton(
                      text: 'تحقق',
                      onPressed: _verifyOtp,
                      backgroundColor: theme.colorScheme.primary,
                      textColor: theme.colorScheme.onPrimary,
                    ),
                    const ResponsiveSpace(height: 24),
                    TextButton(
                      onPressed: _start == 0 ? startTimer : null,
                      child: CustomAutoSizeText(
                        text: _start == 0 ? 'إعادة إرسال الرمز' : 'إعادة الإرسال بعد ($_start)',
                        colorText: _start == 0 ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
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
