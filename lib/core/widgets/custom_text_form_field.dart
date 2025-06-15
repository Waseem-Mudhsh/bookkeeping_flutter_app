
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/responsive_notifier.dart';
import '../providers/theme_data_provider.dart';

class CustomTextField extends ConsumerWidget {
  /// A custom text field widget that provides a standard input field with various customization options.
  final TextEditingController controller;
  final String label;
  final String? hint;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final Widget? suffixIcon;
  

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.keyboardType,
    this.validator,
    this.onTap,
    this.suffixIcon,
    
  });




  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    final responsive = ref.watch(responsiveProvider);
    return TextFormField(
      keyboardType: keyboardType ?? TextInputType.text,
      style: theme.textTheme.bodyMedium,
      controller: controller,
      
      
      decoration: InputDecoration(
        constraints: BoxConstraints(
          minHeight: responsive.h(50),
          maxHeight: responsive.h(100),
        ),
        
        labelText: label,
        labelStyle: theme.textTheme.bodyMedium,
        hintText: hint,
        hintStyle: theme.textTheme.bodySmall,
        suffixIcon: suffixIcon,
        border:  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: theme.colorScheme.primary, 
            width: responsive.w(1)),
        ),





        errorMaxLines: 2,
      

      ),
      
       autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onTap: onTap,

    );
  }
}