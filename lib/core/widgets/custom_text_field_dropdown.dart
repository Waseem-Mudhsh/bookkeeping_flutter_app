import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/responsive_notifier.dart';
import '../providers/theme_data_provider.dart';

class CustomTextFieldDropdown<T> extends ConsumerWidget {
  final List<DropdownMenuItem<T>>? items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? hintText;
  final String? labelText;
  final String? Function(T?)? validator;
  final bool isExpanded;
  final InputDecoration? decoration;
  final bool isEnabled;
  final Widget? icon;
  final Color? fillColor;

  const CustomTextFieldDropdown({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.hintText,
    this.labelText,
    this.validator,
    this.isExpanded = true,
    this.decoration,
    this.isEnabled = true,
    this.icon,
    this.fillColor, required Icon prefixIcon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    final responsive = ref.watch(responsiveProvider);
    

    return DropdownButtonFormField<T>(
      
      value: value,
      items: items,
      onChanged: isEnabled ? onChanged : null,
      validator: validator,
      isExpanded: isExpanded,
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
        enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    width: responsive.w(0.5),
                  ),
                ),
        focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                    color: theme.colorScheme.primary,
                    width: responsive.w(0.5),
                  ),
                ),
        focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                    color: theme.colorScheme.error,
                    width: responsive.w(0.5),
                  ),
                ),
        disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    width: responsive.w(0.5),
                  ),
                ),
        labelStyle:  theme.textTheme.bodySmall!.copyWith(
              color: theme.colorScheme.onSurface,
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
        hintStyle: theme.textTheme.bodySmall!.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              fontSize: 12,
            ),
        labelText: labelText,
        hintText: hintText ,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ).copyWith(),
      icon: icon ?? const Icon(Icons.keyboard_arrow_down_rounded),
      dropdownColor: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(4),
      
      menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
      style: theme.textTheme.bodyMedium!.copyWith(
        fontSize: 12
      ),
    );
  }
}