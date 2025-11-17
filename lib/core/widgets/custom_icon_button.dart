// ignore: file_names
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class CustomIconButton extends ConsumerWidget {
  final VoidCallback onPressed;
  final IconData hugeIcon;
  final double? size;
  final double? iconSize;
  final Color? colorIcon;
  

  
  final Color? backgroundColor;
  final String? tooltip;

  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.hugeIcon,
    this.size,
    this.iconSize,
    this.colorIcon,
    this.backgroundColor,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
   

    return Material(
      color: Colors.transparent,
      child: Ink(
       
        
        decoration:  ShapeDecoration(color: backgroundColor ?? Colors.transparent, shape: CircleBorder()),
        child: IconButton(
          
          tooltip: tooltip,
          iconSize:  ref.responsive.w(iconSize ?? 16),
          icon: CustomHugeIcon(icon: hugeIcon, color: colorIcon ?? ref.theme.colorScheme.primary,),
          color: colorIcon ?? ref.theme.colorScheme.primary,
          onPressed: onPressed,
           ),
      ),
    );
  }
}
