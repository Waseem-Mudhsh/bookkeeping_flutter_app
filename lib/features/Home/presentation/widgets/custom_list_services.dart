import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/responsive_notifier.dart';
import '../../../../core/providers/theme_data_provider.dart';
import '../../../../core/utils/route_names.dart';
import '../../../../core/widgets/responsive_space.dart';

class CustomListServices extends ConsumerWidget {
  const CustomListServices({super.key});
  List<Map<String, dynamic>> get services => [
    {
      'name': 'Finance',
      'icon': Icons.account_balance_wallet,
    },
    {
      'name': 'Expenses',
      'icon': Icons.attach_money,
    },
    {
      'name': 'Income',
      'icon': Icons.money,
    },
    {
      'name': 'Budget',
      'icon': Icons.pie_chart,
    },
    {
      'name': 'Reports',
      'icon': Icons.bar_chart,
    },
    {
      'name': 'Settings',
      'icon': Icons.settings,
    }

      ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ref.watch(responsiveProvider);
    final theme = ref.watch(themeDataProvider);
    return Padding(
      padding: responsive.paddingSym(h: 16),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Number of columns
          crossAxisSpacing: responsive.w(10), // Spacing between columns
          mainAxisSpacing: responsive.w(10), // Spacing between rows
          childAspectRatio: 1.0, // Aspect ratio of each item
        ),
        itemCount: services.length, // Number of items
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RouteNames.finance.screen,
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: theme.colorScheme.onSurface.withValues( alpha: 0.5,),
                  width: 0.5,
                ),
              ),
               
              child: _buildServiceItem(services[index]['name'],services[index]['icon'], ref),
            ),
          );
        },
      ),
    );
  }
}
  Widget _buildServiceItem(String service,IconData nemeIcon, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    final responsive = ref.watch(responsiveProvider);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            nemeIcon,
            color: theme.colorScheme.primary,
            size: responsive.w(24),
          ),
          ResponsiveSpace(height: 8),
          CustomAutoSizeText(
            text: service,
            style: theme.textTheme.bodyMedium,
            presetFontSizes: [14, 12, 10],
            maxLines: 2,
            textAlign: TextAlign.center,

            fontWeight: FontWeight.w500,
            colorText: theme.colorScheme.onPrimaryContainer,
          ),
        ],
      ),
    );
  }

