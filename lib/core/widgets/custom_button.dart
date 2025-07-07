import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/responsive_notifier.dart';
import '../providers/theme_data_provider.dart';

class CustomButton extends ConsumerWidget {
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  
  final VoidCallback? onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    this.textStyle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    final responsive = ref.watch(responsiveProvider);
    return ElevatedButton(
      onPressed: onPressed,
    
      style: ElevatedButton.styleFrom(
        padding: responsive.paddingSym(h: 16, v: 16),
        backgroundColor: backgroundColor ??theme.colorScheme.surfaceBright,
        // foregroundColor: textColor ?? theme.colorScheme.onPrimary,
        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        textStyle: textStyle ?? theme.textTheme.bodyMedium?.copyWith(
          color: textColor?? theme.colorScheme.onPrimary,
          fontWeight: FontWeight.w400,
        ),
        
      ),
      child: CustomAutoSizeText(
            text: 
              text,
              colorText: textColor ?? theme.colorScheme.onPrimary,
              

           
            ),
    );
  }
}