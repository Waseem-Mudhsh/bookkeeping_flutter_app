
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/responsive_notifier.dart';
import '../providers/theme_data_provider.dart';

class CustomShowbalince extends ConsumerWidget {
  final String titleBalince;
  final String valueBalince;
  final bool iscreditor;
  final Color? backgroundColor;
  final bool isleft;
  const CustomShowbalince({
    super.key,
    required this.titleBalince,
    required this.valueBalince,
    this.iscreditor = false,
    this.backgroundColor,
    required this.isleft,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    final responsive = ref.watch(responsiveProvider);

    return Padding(
      padding: responsive.paddingSym(h: 8,),
      child: Column(
       
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
       
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
    
        
        children: [
          Container(
            padding: responsive.paddingSym(h: 1, v: 1),
            decoration: BoxDecoration(
              color: iscreditor ? theme.colorScheme.error : Colors.green,
              borderRadius: BorderRadius.circular(responsive.w(4)),
            ),
            child: Icon(
              size: responsive.w(14),
              iscreditor ? Icons.arrow_downward : Icons.arrow_upward,
              color: Colors.white,
            ),
          ),
          ResponsiveSpace(width: responsive.w(8)),
    
          CustomAutoSizeText(
            text: titleBalince,
            style: theme.textTheme.bodyLarge,
            colorText: theme.colorScheme.onSurfaceVariant,
            fontSize: 12,
            
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      ResponsiveSpace(height: 2,),
      CustomAutoSizeText(
            text: valueBalince,
            style: theme.textTheme.bodyLarge,
            colorText: theme.colorScheme.onSurface,
            // fontSize: 16,
            presetFontSizes: [14, 12, 10],
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
    
    
        ],
      ),);
  }
}
