
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CustomShowBoxBalince extends ConsumerWidget {
  
  final String valueBalince;
  final bool iscreditor;
  final Color? backgroundColor;
  final bool isleft;
  const CustomShowBoxBalince({
    super.key,
    
    required this.valueBalince,
    this.iscreditor = false,
    this.backgroundColor,
    required this.isleft,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    final responsive = ref.responsive;

    return Padding(
      padding: responsive.paddingOnly( right: 8),
      child: Row(
             
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
          
              
              children: [
      Container(
        padding: responsive.paddingSym(h: 4, v: 4),
        decoration: BoxDecoration(
          color: iscreditor ? theme.colorScheme.error :Colors.green,
          borderRadius: BorderRadius.circular(responsive.w(4)),
        ),
        child: Icon(
          size: responsive.w(14),
          iscreditor ? Icons.arrow_downward : Icons.arrow_upward,
          color: Colors.white,
        ),
      ),
      ResponsiveSpace(width: responsive.w(8)),
          
       Expanded(
         child: CustomAutoSizeText(
          text: valueBalince,
          style: theme.textTheme.bodyLarge,
          colorText: theme.colorScheme.onSurface,
          fontSize: 14,
          // presetFontSizes: [14, 12],
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
                   ),
       ),
              ],
            ),);
  }
}
