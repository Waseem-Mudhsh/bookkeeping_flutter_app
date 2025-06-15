import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/responsive_notifier.dart';
import '../providers/theme_data_provider.dart';

class CustomText extends ConsumerWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final Color? colorText;
  final double fontSize;
  final FontWeight? fontWeight;
  final double? minFontSize;
  final double? maxFontSize;
  final double? stepGranularity;
  
  

  const CustomText({
    super.key,
    required this.text,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.colorText,
    this.fontSize=14,
    this.fontWeight,
    this.minFontSize,
    this.maxFontSize,
    this.stepGranularity,
    
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    final responsive = ref.watch(responsiveProvider);

    return AutoSizeText(
      text,
      style: style?.copyWith(
        color: colorText ?? theme.colorScheme.onSurface,
        fontSize:  responsive.sp(fontSize),
        fontWeight: fontWeight ?? FontWeight.normal,
      ) ?? theme.textTheme.bodyMedium,
      textAlign: textAlign,
      maxLines: maxLines?? 2,
      overflow: overflow ?? TextOverflow.ellipsis,
      minFontSize: minFontSize ?? 10,
      maxFontSize: responsive.sp(maxFontSize ?? fontSize),
      stepGranularity: stepGranularity ?? 1,
      // presetFontSizes: [18, 14, 12, 10],

    );
  }
}