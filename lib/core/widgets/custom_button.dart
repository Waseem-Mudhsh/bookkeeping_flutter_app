
import 'package:bookkeeping_flutter_app/core/providers/responsive_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ButtonState { normal, loading, disabled }

class CustomButton extends ConsumerWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final bool hasBorder;
  final VoidCallback? onTap;
  final ButtonState state;
  final IconData? icon;
  final List<Color>? gradientColors;

  const CustomButton({
    super.key,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    this.hasBorder = false,
    this.onTap,
    this.state = ButtonState.normal,
    this.icon,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

   final responsive = ref.watch(responsiveProvider);

    
    // double paddingVertical = screenWidth * 0.03; // Adaptive padding
    double fontSize = responsive.sp(16);  // Responsive text size
    double borderRadius = responsive.w(10) ; // Adjusts with screen size
    double elevation = responsive.sp(4); // Responsive shadow effect

    bool isDisabled = state == ButtonState.disabled;

    return InkWell(
      onTap: isDisabled || state == ButtonState.loading ? null : onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(vertical: responsive.p(0.03),
         horizontal: responsive.p(0.03)),
        decoration: BoxDecoration(
          color: isDisabled ? Colors.grey : backgroundColor,
          gradient: (gradientColors != null && !isDisabled)
              ? LinearGradient(colors: gradientColors!)
              : null,
          borderRadius: BorderRadius.circular(borderRadius),
          border: hasBorder
              ? Border.all(
                  color: isDisabled ? Colors.grey : textColor,
                  width: 2,
                )
              : null,
          boxShadow: [
            if (state == ButtonState.normal)
              BoxShadow(
                color: Colors.black26,
                blurRadius: elevation,
                spreadRadius: 1,
              ),
          ],
        ),
        child: Center(
          child: state == ButtonState.loading
              ? SizedBox(
                  width: fontSize,
                  height: fontSize,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, color: textColor, size: fontSize * 0.8),
                      SizedBox(width: fontSize * 0.3),
                    ],
                    Text(
                      text,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
