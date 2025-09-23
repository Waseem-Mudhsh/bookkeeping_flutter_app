// ignore: file_names
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';



class CustomIconButton extends ConsumerWidget {
  final VoidCallback onPressed;
  final HugeIcon hugeIcon;

  
  final Color? backgroundColor;
  final String? tooltip;

  const CustomIconButton({
    super.key,

    required this.onPressed,
    required this.hugeIcon,

    
    this.backgroundColor,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final responsive = ref.responsive;

    return IconButton(
      tooltip: tooltip,
      padding: responsive.paddingAll(8),
      onPressed: onPressed,
      icon: hugeIcon,
      
      
      style: backgroundColor != null ? IconButton.styleFrom(
        backgroundColor: backgroundColor!,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(responsive.w(55)),
        ),

      ): null,
    );
  }
}
