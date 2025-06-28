import 'package:bookkeeping_flutter_app/core/base_layout/base_layout_screen.dart';
import 'package:bookkeeping_flutter_app/core/base_layout/build_non_tabbar_layout.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_drawer.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_icon_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:bookkeeping_flutter_app/features/Currencies/presentation/widgets/currency_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/responsive_notifier.dart';
import '../widgets/custom_list_services.dart';

class HomeMainScreen extends ConsumerWidget {
  const HomeMainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ref.watch(responsiveProvider);
    // final customersAsync = ref.watch(customerViewModelProvider);
    
    return BaseLayoutScreen(
      
      drawer: CustomDrawer(),
      body: BuildNonTabbarLayout(
        title: 'الرئيسية',
        actions: [
          CustomIconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
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
        SliverToBoxAdapter(child: CustomListServices()),
        ]),

      
      
      

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
