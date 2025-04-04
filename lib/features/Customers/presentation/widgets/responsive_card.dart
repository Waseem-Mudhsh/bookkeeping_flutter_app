import 'package:bookkeeping_flutter_app/core/providers/responsive_notifier.dart';
import 'package:bookkeeping_flutter_app/core/providers/theme_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ResponsiveCard extends ConsumerWidget {
  const ResponsiveCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final colorScheme = Theme.of(context).colorScheme;
    final theme = ref.watch(themeDataProvider);
    final responsive = ref.watch(responsiveProvider);
    
    
    // return Card(
    //   color: Theme.of(context).colorScheme.secondary,
    //   elevation: Responsive.responsivePadding(context, 4),
    //   child: Padding(
    //     padding: EdgeInsets.all(Responsive.responsivePadding(context, 16)),
    //     child: Text(
    //       'Responsive Card',
    //       style: TextStyle(
    //         fontSize: Responsive.responsiveFontSize(context, 16),
    //         color: isDark ? Colors.white : Colors.black,
    //       ),
    //     ),
    //   ),
    // );

    return GridView.count(
          crossAxisCount: 2, // Two columns
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          childAspectRatio: 1,
          children: [
            _buildColorTile('Primary', theme.colorScheme.primary, theme.colorScheme.onPrimary,responsive.sp(16)),
            _buildColorTile('Secondary', theme.colorScheme.secondary, theme.colorScheme.onSecondary,responsive.sp(16)),
            _buildColorTile('Surface', theme.colorScheme.surface, theme.colorScheme.onSurface,responsive.sp(16)),
            _buildColorTile('Error', theme.colorScheme.error, theme.colorScheme.onError,responsive.sp(16)),
            _buildColorTile('Secondary Container', theme.colorScheme.secondaryContainer, theme.colorScheme.onSecondaryContainer,responsive.sp(16)),
          ],
        );
  }
}
Widget _buildColorTile(String label, Color background, Color textColor, double fontSize) {
  
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
          color: textColor, // Dynamic border color
          width: 2,
          
        ),
          // boxShadow: [
          //   BoxShadow(color: Colors.black26, blurRadius: 4, spreadRadius: 1),
          // ],
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        child: Text(
          label,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: fontSize),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
  
