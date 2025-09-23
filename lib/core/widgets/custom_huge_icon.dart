import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomHugeIcon extends ConsumerWidget {
  final IconData icon;
  final double? size;
  final Color? color;
 

  const CustomHugeIcon({
    super.key,
    required this.icon,
    this.size,
    this.color,
    
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme =ref.theme;
    final responsive = ref.responsive;
    return HugeIcon(
      icon: icon,
      size: responsive.h(size ?? 24),
      color: color ?? theme.colorScheme.primary, 
     
    );
  }
}