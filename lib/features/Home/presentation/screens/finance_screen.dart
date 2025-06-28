import 'package:bookkeeping_flutter_app/core/base_layout/base_layout_screen.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:bookkeeping_flutter_app/features/Currencies/presentation/widgets/currency_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/base_layout/build_tab_bar_layout.dart';
import '../../../../core/providers/responsive_notifier.dart';
import '../../../../core/providers/theme_data_provider.dart';
import '../../../../core/widgets/custom_auto_size_text.dart';
import '../../../../core/widgets/custom_drawer.dart';
import '../../../../core/widgets/custom_horizontal_list_view.dart';
import '../../../../core/widgets/custom_icon_button.dart';
import '../../../Accounts/domain/entities/main_account.dart';
import '../../../Accounts/domain/entities/sub_account.dart';
import '../../../Currencies/presentation/widgets/custom_show_balince.dart';
// Add this import for mainAccountsProvider

class FinanceScreen extends ConsumerWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> tags = ['موردين', 'العملاء', 'مصروفات', 'الضرايب', 'الرواتب'];

    final responsive = ref.watch(responsiveProvider);

    return BaseLayoutScreen(
      drawer: CustomDrawer(),
      body: BuildTabBarLayout(
        toolbarHeight: responsive.h(120),

        initialTabIndex: 0,
        tabs: mainAccounts.map((account) => Tab(text: account.name)).toList(),
        title: 'الحسابات',
        hasLeading: true,
        actions: [
          CustomIconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_circle_left_outlined),
          ),
        ],

        tabViews:
            mainAccounts.map((mainAccount) {
              return SizedBox(
                height: responsive.deviceSize.height,

                child: Padding(
                  padding: responsive.paddingSym(h: 16, v: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      
                      CustomShowBalince(),
                       
                      const ResponsiveSpace(height: 16),

                      Expanded(
                        child: CustomHorizontalListView(
                          nameButtons:
                              subAccounts
                                  .map((sub) => sub.type)
                                  .toSet()
                                  .toList(),
                          contentWidgets: [
                            _buildListSubAccounts(
                              ref,
                              subAccounts
                                  .where((sub) => sub.type == tags[0])
                                  .toList(),
                            ),
                            _buildListSubAccounts(
                              ref,
                              subAccounts
                                  .where((sub) => sub.type == tags[1])
                                  .toList(),
                            ),
                            _buildListSubAccounts(
                              ref,
                              subAccounts
                                  .where((sub) => sub.type == tags[4])
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildListSubAccounts(
    WidgetRef ref,
    List<SubAccountModel> subAccounts,
  ) {
    final theme = ref.watch(themeDataProvider);
    final responsive = ref.watch(responsiveProvider);
    return subAccounts.isEmpty
        ? Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: responsive.paddingOnly(top: 16),
            child: CustomAutoSizeText(
              text: 'لا توجد حسابات فرعية',
              style: theme.textTheme.bodyLarge,
              presetFontSizes: [16, 14, 12],
              textAlign: TextAlign.center,
            ),
          ),
        )
        : ListView.builder(
          itemCount: subAccounts.length,
          itemBuilder: (context, index) {
            final sub = subAccounts[index];
            return Card(
              child: ListTile(
                title: CustomAutoSizeText(
                  text: sub.name,
                  style: theme.textTheme.bodyLarge,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                subtitle: CustomAutoSizeText(
                  text: 'النوع: ${sub.type}',
                  style: theme.textTheme.bodySmall,
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                ),
                trailing: CustomAutoSizeText(
                  text: '${sub.totalBalance.toStringAsFixed(2)} ر.س',
                  style: theme.textTheme.bodyMedium,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                onTap: () {
                  // عرض تفاصيل أو سجل الحركات
                },
              ),
            );
          },
        );

  }
 

  
}
