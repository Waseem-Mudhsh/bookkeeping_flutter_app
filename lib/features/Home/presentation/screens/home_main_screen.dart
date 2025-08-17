import 'package:bookkeeping_flutter_app/core/base_layout/base_layout_screen.dart';
import 'package:bookkeeping_flutter_app/core/base_layout/build_non_tabbar_layout.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_drawer.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_icon_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/custom_list_services.dart';

class HomeMainScreen extends ConsumerWidget {
  const HomeMainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   
    
    return BaseLayoutScreen(
      
      drawer: CustomDrawer(),
      body: BuildNonTabbarLayout(
        title: 'الرئيسية',
        actions: [
          CustomIconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
        slivers: [
           SliverToBoxAdapter(child: ResponsiveSpace(height: 64)),
        

        // SliverToBoxAdapter(
        //   child: SingleChildScrollView(child: CustomListServices()),
        // ),
        SliverToBoxAdapter(child: 
        Align(child: CustomListServices(),)),
        ]),

      
      
      

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
