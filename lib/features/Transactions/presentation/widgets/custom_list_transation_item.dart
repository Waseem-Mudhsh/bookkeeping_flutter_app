import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/widgets/custom_auto_size_text.dart';

class CustomListTransationItem extends ConsumerWidget {
  const CustomListTransationItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ref.responsive;
    final theme = ref.theme;
    

    return Container(
      padding: responsive.paddingSym(h: 12, v: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(responsive.w(12)),
        border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.5),
        width: 0.5
        ),
       
      ),
      child: Row(
        
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          _buildLeading(ref),
          ResponsiveSpace(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTitleTransaction(ref),
                ResponsiveSpace(height: 6),
                _buildSubTitleTransaction(ref),
              ],
            ),
          ),
          _buildTrailingTransaction( ref),
        ],
      ),
    );
  }
  Widget _buildLeading( WidgetRef ref) {
    final theme = ref.theme;
    return CircleAvatar(
      backgroundColor:  theme.colorScheme.primary.withValues(alpha: 0.1),
      child: CustomHugeIcon(icon: HugeIcons.strokeRoundedStore01,
      color: theme.colorScheme.primary,
      size: 20,),
    );
  }
  Widget _buildTitleTransaction(WidgetRef ref) {
    final theme = ref.theme;
   
    return CustomAutoSizeText(
      text: 'اسم المتجر',
      fontWeight: FontWeight.bold,
      colorText: theme.colorScheme.onSurface,
      style: theme.textTheme.bodyMedium,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      fontSize: 12,
    );
  }
  Widget _buildSubTitleTransaction(WidgetRef ref) {
    final theme = ref.theme;
    return CustomAutoSizeText(
      text: 'وصف الاغراض التي وصف الاغراض التي تم شرائها من المتجر',
      fontWeight: FontWeight.w600,
      colorText: theme.colorScheme.onSurface,
      style: theme.textTheme.bodySmall,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      fontSize: 10,
    );
  }

  Widget _buildTrailingTransaction( WidgetRef ref) {
    final theme = ref.theme;
    return Column(
      
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomAutoSizeText(
          text: ' 250000.00 ر.ي',
          fontWeight: FontWeight.bold,
          colorText: theme.colorScheme.error,
              
          style: theme.textTheme.bodyMedium,
          fontSize: 12,
        ),
        ResponsiveSpace(height: 6),
        CustomAutoSizeText(
          text:
              '2024/6/15',
          colorText: theme.colorScheme.onSurface.withValues(alpha: 0.5),

          fontSize: 10,
        ),
      ],
    );
  }
}