import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/responsive_notifier.dart';
import '../../../../core/providers/theme_data_provider.dart';
import '../../../../core/widgets/custom_show_box_balince.dart';
import '../../../../core/widgets/responsive_space.dart';
import '../../domain/entities/currency.dart';
import '../providers/currency_provider.dart';

class CurrencyListTile extends ConsumerStatefulWidget {
  const CurrencyListTile({super.key});

  @override
  ConsumerState<CurrencyListTile> createState() => _CurrencyListTileState();
}

class _CurrencyListTileState extends ConsumerState<CurrencyListTile> {
  late List<Currency> currencies = [];
  late Currency currencySelected;
  @override
  void initState() {
    super.initState();
    currencies = ref.read(currencyListProvider);
    currencySelected = currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ref.watch(responsiveProvider);
    final theme = ref.watch(themeDataProvider);

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      color: theme.colorScheme.surface,
      elevation: 5,
      child: Padding(
        padding: responsive.paddingSym(h: 16, v: 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomAutoSizeText(
                  text: 'العملاء ',
                  style: theme.textTheme.bodyMedium,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  colorText: theme.colorScheme.primary,
                ),
                Expanded(child: const ResponsiveSpace(width: 16)),
                Container(
                  padding: responsive.paddingSym(h: 16, v: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(width: 1, color: Colors.grey.shade300),

                    color: theme.colorScheme.primary,
                  ),

                  child: InkWell(
                    onTap: () => showDropdownSheet(context, ref),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomAutoSizeText(
                          style: theme.textTheme.bodySmall,
                          fontWeight: FontWeight.w700,
                          text: currencySelected.name,
                          fontSize: 14,

                          colorText: theme.colorScheme.onPrimary,
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(child: ResponsiveSpace(width: responsive.w(16))),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAutoSizeText(
                      text: 'عدد العملاء',
                      fontSize: 10,
                      style: theme.textTheme.bodySmall,
                      fontWeight: FontWeight.w500,
                      colorText: theme.colorScheme.onSurfaceVariant,
                    ),
                    CustomAutoSizeText(
                      text: '120',
                      fontSize: 12,
                      style: theme.textTheme.bodyMedium,
                      fontWeight: FontWeight.bold,
                      colorText: theme.colorScheme.primary,
                    ),
                  ],
                ),
              ],
            ),
            //  const ResponsiveSpace(height: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomAutoSizeText(
                  text: currencySelected.balanceDue!.toStringAsFixed(2),
                  style: theme.textTheme.bodyMedium,
                  presetFontSizes: [18, 16, 14],
                  colorText: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
                const ResponsiveSpace(width: 2),
                CustomAutoSizeText(
                  text: currencySelected.code,
                  style: theme.textTheme.bodyMedium,
                  fontSize: 12,
                  colorText: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            // const ResponsiveSpace(height: 2),
            Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
            // const ResponsiveSpace(height: 2),
            buildBalinceDue(),
          ],
        ),
      ),
    );
  }

  Widget buildBalinceDue() {
    return ResponsiveSpace(
      
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // CustomDropdown(),
            Expanded(
              child: CustomShowBoxBalince(
                // titleBalince: ' عليك :',
                valueBalince: '100000000000000',
                iscreditor: true,
                isleft: false,
              ),
            ),
            VerticalDivider(),
            // ResponsiveSpace(width: responsive.w(8)),
            Expanded(
              child: CustomShowBoxBalince(
               
                valueBalince: '100000000000000',
                iscreditor: false,
                isleft: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDropdownSheet(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    showModalBottomSheet(
      backgroundColor: theme.colorScheme.surface,
      useSafeArea: true,
      context: context,
      builder: (_) {
        return ListView(
          children:
              currencies.map((item) {
                return InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      currencySelected = item;
                    });
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          item.flagUrl != null
                              ? Image.asset(
                                item.flagUrl!,
                                fit: BoxFit.none,
                              ).image
                              : null,

                      backgroundColor: Colors.grey.shade200,
                    ),
                    title: CustomAutoSizeText(
                      text: item.name,
                      style: theme.textTheme.bodyMedium,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      colorText: theme.colorScheme.primary,
                    ),
                    subtitle: CustomAutoSizeText(
                      text: item.code,
                      style: theme.textTheme.bodyMedium,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      colorText: theme.colorScheme.primary,
                    ),
                    trailing: CustomAutoSizeText(
                      text: item.balanceDue!.toStringAsFixed(2),
                      style: theme.textTheme.bodyMedium,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      colorText: theme.colorScheme.primary,
                    ),
                  ), // custom full widget
                );
              }).toList(),
        );
      },
    );
  }
}
