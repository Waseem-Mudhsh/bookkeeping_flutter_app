import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../custom_slivers/custom_sliver_app_bar.dart';

class BuildNonTabbarLayout extends ConsumerWidget{
  final CustomSliverAppBar? header;
  final List<Widget>? sliversHeader;
  final List<Widget> slivers;
  
  const BuildNonTabbarLayout(
      {super.key,
      this.sliversHeader,
      this.header,
      required this.slivers
      
      });
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
     // Access the responsive
    return 
      NestedScrollView(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        floatHeaderSlivers: true,
        
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
           SliverOverlapAbsorber(
             handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: header
            ),
            ...sliversHeader ?? [],
          ];
      
        
        },
        body: CustomScrollView(
           controller: PrimaryScrollController.of(context),
          slivers:[
            // لمنع تداخل المحتوى مع AppBar
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          ...slivers,
            
          ] 
        ),
      );
  }
}
