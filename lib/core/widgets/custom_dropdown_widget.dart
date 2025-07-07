import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/responsive_notifier.dart';
import '../providers/theme_data_provider.dart';

class TextFieldLikeDropdown<T> extends ConsumerWidget {
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

  const TextFieldLikeDropdown({
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
    this.fillColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    final responsive = ref.watch(responsiveProvider);
    final isValueEmpty = value == null;

    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: isEnabled ? onChanged : null,
      validator: validator,
      isExpanded: isExpanded,
      decoration: InputDecoration(
        
        contentPadding: responsive.paddingSym(h: 12, v: 16),
        fillColor: fillColor ?? theme.colorScheme.surface,
        constraints: BoxConstraints(
          minHeight: responsive.h(50),
          maxHeight: responsive.h(100),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            color: theme.colorScheme.onSurface.withAlpha(40), 
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
        labelStyle: theme.textTheme.bodySmall!.copyWith(
          color: theme.colorScheme.onSurface, 
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
        hintStyle: theme.textTheme.bodySmall!.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.5), 
          fontSize: 10,
        ),
        labelText: isValueEmpty ? null : labelText,
        hintText: isValueEmpty ? hintText : null,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ).copyWith(),
      icon: icon ?? const Icon(Icons.keyboard_arrow_down_rounded),
      dropdownColor: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(4),
      elevation: 8,
      menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
      style: theme.textTheme.bodyMedium,
    );
  }
}