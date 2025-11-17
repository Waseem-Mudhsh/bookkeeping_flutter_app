
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
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
  final String? fontFamily;
  final double? letterSpacing;
  final double? wordSpacing;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;
  final Paint? foreground;
  final FontStyle? fontStyle;
  final String? debugLabel;

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
    this.fontFamily,
    this.letterSpacing,
    this.wordSpacing,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.foreground,
    this.fontStyle,
    this.debugLabel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ref.responsive;
    final theme = ref.theme;

    // إنشاء النمط الأساسي مع دمج جميع الخصائص
    TextStyle buildTextStyle(double fontSize) {
      return (style ?? const TextStyle()).copyWith(
        color: colorText ?? style?.color ?? theme.colorScheme.onSurface,
        fontSize: responsive.sp(fontSize),
        fontWeight: fontWeight ?? style?.fontWeight ?? FontWeight.normal,
        fontFamily: fontFamily ?? style?.fontFamily,
        letterSpacing: letterSpacing ?? style?.letterSpacing,
        wordSpacing: wordSpacing ?? style?.wordSpacing,
        decoration: decoration ?? style?.decoration,
        decorationColor: decorationColor ?? style?.decorationColor,
        decorationStyle: decorationStyle ?? style?.decorationStyle,
        decorationThickness: decorationThickness ?? style?.decorationThickness,
        foreground: foreground ?? style?.foreground,
        fontStyle: fontStyle ?? style?.fontStyle,
        debugLabel: debugLabel,

      );
    }

    if (fontSize != null) {
      return Text(
        text,
        style: buildTextStyle(fontSize!),
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
      );
    }

    if (presetFontSizes != null && presetFontSizes!.isNotEmpty) {
      return AutoSizeText(
        text,
        style: buildTextStyle(presetFontSizes!.first), // استخدام أول حجم كمثال
        presetFontSizes: presetFontSizes!.map((s) => responsive.sp(s)).toList(),
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        minFontSize: minFontSize,
        stepGranularity: stepGranularity,
      );
    }

    // المنطق الذكي لضبط حجم الخط
    double calculateSmartFontSize() {
      double baseSize = 16; // الحجم الأساسي
      
      // تعديل حسب طول النص
      if (text.length > 20) {
        baseSize *= 0.85;
      } else if (text.length > 10) {
       baseSize *= 0.92;
      }
      
      // التأكد من الحدود الدنيا والقصوى
      return baseSize.clamp(
        minFontSize, 
        maxFontSize ?? double.infinity
      );
    }

    return Text(
      text,
      style: buildTextStyle(calculateSmartFontSize()),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}