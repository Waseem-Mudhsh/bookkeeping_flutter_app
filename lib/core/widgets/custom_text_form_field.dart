import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/responsive_notifier.dart';
import '../providers/theme_data_provider.dart';

class CustomTextField extends ConsumerWidget {
  /// A custom text field widget that provides a standard input field with various customization options.
  final TextEditingController controller;
  final String label;
  final String? hint;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function(String)? onChanged;
  final bool readOnly;
  final bool enabled;
  final bool autofocus;
  final bool obscureText;
  final Color? fillColor;
  final TextAlign textAlign;
  final int? maxLines;
  final bool? hasBorder;
  final List<TextInputFormatter>? inputFormatters;


  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.style,
    this.labelStyle,
    this.hintStyle,
    this.keyboardType,
    this.validator,
    this.onTap,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.obscureText = false,
    this.fillColor,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
    this.hasBorder = true,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    final responsive = ref.watch(responsiveProvider);
    return TextFormField(
      textAlign: textAlign,
      obscuringCharacter: '*',
      inputFormatters: [
        ...?inputFormatters,],
      focusNode: FocusNode(),

      keyboardType: keyboardType ?? TextInputType.text,
      style: style ?? theme.textTheme.bodyMedium,

      controller: controller,
      readOnly: readOnly,
      enabled: enabled,
      autofocus: autofocus,
      obscureText: obscureText,

      decoration: InputDecoration(
        floatingLabelStyle: theme.textTheme.bodyMedium!.copyWith(
              color: theme.colorScheme.primary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
        fillColor: fillColor ?? theme.colorScheme.surface,
        constraints: BoxConstraints(
          minHeight: responsive.h(50),
          maxHeight: responsive.h(100),
        ),
        enabledBorder:
            hasBorder!
                ? OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    width: responsive.w(0.5),
                  ),
                )
                : InputBorder.none,
        focusedBorder:
            hasBorder!
                ? OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                    color: theme.colorScheme.primary,
                    width: responsive.w(0.5),
                  ),
                )
                : InputBorder.none,

        focusedErrorBorder:
            hasBorder!
                ? OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                    color: theme.colorScheme.error,
                    width: responsive.w(0.5),
                  ),
                )
                : InputBorder.none,
        disabledBorder:
            hasBorder!
                ? OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    width: responsive.w(0.5),
                  ),
                )
                : InputBorder.none,

        labelText: label,
        labelStyle:
            labelStyle ??
            theme.textTheme.bodySmall!.copyWith(
              color: theme.colorScheme.onSurface,
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
        hintText: hint,
        hintStyle:
            hintStyle ??
            theme.textTheme.bodySmall!.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              fontSize: 12,
            ),
        suffixIcon: Container(
          margin: responsive.paddingAll(4),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
           
            borderRadius: BorderRadius.circular(4),
          ),
          child: suffixIcon,
        ),

        prefixIcon: prefixIcon,

        errorMaxLines: 2,
      ),
      maxLines: maxLines,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onTap: onTap,
      onChanged: onChanged,
    );
  }
}
