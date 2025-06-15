import 'package:bookkeeping_flutter_app/core/base_layout/base_layout_screen.dart';
import 'package:bookkeeping_flutter_app/core/custom_slivers/custom_sliver_app_bar.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_drawer.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_icon_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:bookkeeping_flutter_app/features/Currencies/presentation/widgets/currency_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/responsive_notifier.dart';
import '../../../../core/providers/theme_data_provider.dart'
    show themeDataProvider;
import '../../../Customers/presentation/screens/customer_actions.dart';
import '../widgets/custom_list_services.dart';

class HomeMainScreen extends ConsumerWidget {
  const HomeMainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ref.watch(responsiveProvider);
    // final customersAsync = ref.watch(customerViewModelProvider);
    final theme = ref.watch(themeDataProvider);
    final actions = CustomerActions(ref: ref, context: context);
    return BaseLayoutScreen(
      backgroundColor: theme.colorScheme.secondary,
      drawer: CustomDrawer(),
      header: CustomSliverAppBar(
        hasLeading: true,
        pinned: true,
        title: CustomAutoSizeText(
          text: 'مرحبا وسيم ...',
          style: theme.textTheme.bodyLarge,
          colorText: theme.colorScheme.primary,
          fontSize: 14,

          fontWeight: FontWeight.w500,
        ),
        actions: [
          CustomIconbutton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      scrollPhysics: const ClampingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(child: ResponsiveSpace(height: 16)),
        SliverToBoxAdapter(
          child: SizedBox(
            height: responsive.h(180), // replace with your desired height
            child: NotificationListener<ScrollNotification>(
              child: ListView.builder(
                // Or ClampingScrollPhysics()
                scrollDirection: Axis.horizontal,
                itemCount: 4, // replace with your actual data length
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: responsive.deviceSize.width , // replace with your desired width
                    child: Padding(
                      padding: responsive.paddingSym(h: 16),
                      child: CurrencyListTile(),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(child: ResponsiveSpace(height: 16)),

        // SliverToBoxAdapter(
        //   child: SingleChildScrollView(child: CustomListServices()),
        // ),
        SliverFillRemaining(child: CustomListServices()),

       
      ],

      floatingActionButton: FloatingActionButton(
        onPressed: actions.showAddCustomerSheet,
        child: const Icon(Icons.add),
      ),
    );
  }
}
