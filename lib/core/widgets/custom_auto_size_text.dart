import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/providers/responsive_notifier.dart';
import 'package:bookkeeping_flutter_app/core/providers/theme_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAutoSizeText extends ConsumerWidget {
  final String text;
  final double? fontSize;
  final double minFontSize;
  final double? maxFontSize;
  final double stepGranularity;
  final List<double>? presetFontSizes;
  final int maxLines;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final FontWeight? fontWeight;
  final Color? colorText;

  const CustomAutoSizeText({
    super.key,
    required this.text,
    this.fontSize,
    this.minFontSize = 10,
    this.maxFontSize,
    this.stepGranularity = 1,
    this.presetFontSizes,
    this.maxLines = 1,
    this.style,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.fontWeight,
    this.colorText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ref.watch(responsiveProvider);
    final theme = ref.watch(themeDataProvider);

    final baseStyle =
        style != null
            ? style?.copyWith(
              color: colorText ?? theme.colorScheme.onSurface,
              fontSize: responsive.sp(fontSize ?? 10),
              fontWeight: fontWeight ?? FontWeight.normal,
            )
            : const TextStyle(
              fontFamily: 'Tajawal',
            );
             
           
    // final baseStyle = style ?? const TextStyle();

    if (fontSize != null) {
      // debugPrint('مع fontSize (ثابت): ${responsive.sp(fontSize!)}');
      return Text(
        text,
        style: baseStyle,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
      );
    }

    if (presetFontSizes != null && presetFontSizes!.isNotEmpty) {
      return AutoSizeText(
        text,
        style: baseStyle,
        presetFontSizes: presetFontSizes!.map((s) => responsive.sp(s)).toList(),
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
      );
    }

    double calculatedFontSize = responsive.sp(16);

    // منطق ذكي إضافي حسب طول النص
    if (text.length > 40) {
      calculatedFontSize *= 0.85;
    } else if (text.length > 20) {
      calculatedFontSize *= 0.92;
    }

    calculatedFontSize = calculatedFontSize.clamp(
      minFontSize,
      maxFontSize ?? 24,
    ); //تقليص الحجم ضمن حدود معقولة

    return Text(
      text,
      style: baseStyle,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}
