import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CustomButton extends ConsumerWidget {
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final bool isLoading; // 1. إضافة خاصية isLoading
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.text,
    this.textColor, // جعلها اختيارية
    this.backgroundColor, // جعلها اختيارية
    this.textStyle,
    this.onPressed,
    this.isLoading = false, // 2. تعيين قيمة افتراضية لـ isLoading
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    final responsive = ref.responsive;

    return ElevatedButton(

      // 3. تعطيل الزر إذا كان isLoading صحيحًا
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          responsive.w(width ?? double.infinity),
          responsive.h(height ?? 48),
        ),
        padding: responsive.paddingSym(h: 16, v: 16),
        // استخدام اللون الافتراضي إذا لم يتم تحديده
        backgroundColor: backgroundColor ?? theme.colorScheme.primary, // جعل اللون الرئيسي هو الافتراضي
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4), // استخدام ResponsiveValues لـ BorderRadius
        ),
        textStyle: textStyle ??
            theme.textTheme.bodyMedium?.copyWith(
              color: textColor ?? theme.colorScheme.onPrimary,
              fontWeight: FontWeight.w400,
            ),
        // 4. تحديد لون foregroundColor للـ ElevatedButton نفسه
        // هذا سيؤثر على لون النص أو الأيقونة الداخلية
        foregroundColor: textColor ?? theme.colorScheme.onPrimary,
        // يمكنك أيضًا إضافة لون للـ overlay (التأثير عند الضغط)
        overlayColor: Colors.transparent,
      ),
      // 5. عرض مؤشر التحميل أو النص بناءً على isLoading
      child: isLoading
          ? SizedBox(
              width: responsive.w(24), // تحديد حجم لمؤشر التحميل
              height: responsive.w(24),
              child: CircularProgressIndicator(
                strokeWidth: 2.5, // سمك خط المؤشر
                valueColor: AlwaysStoppedAnimation<Color>(
                    textColor ?? theme.colorScheme.onPrimary), // لون المؤشر
              ),
            )
          : CustomAutoSizeText(
              text: text,
              colorText: textColor ?? theme.colorScheme.onPrimary,
            ),
    );
  }
}