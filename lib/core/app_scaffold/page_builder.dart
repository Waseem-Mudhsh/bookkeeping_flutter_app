// import 'package:bookkeeping_flutter_app/core/app_scaffold/build_tab_view.dart';
// import 'package:flutter/material.dart';

// import '../custom_slivers/custom_sliver_app_bar.dart' ;

// /// واجهة لإنشاء الصفحات بطريقة موحدة
// class PageBuilder extends StatelessWidget {
  
//   final bool? hasTabBar;
//   final int? lenghtTabController;
//   final CustomSliverAppBar? customSliverAppBar;
//   final List<Widget>? sliversHeader;
//   final List<Widget> sliverBady;
//   final Widget? floatingActionButton;
//   final Widget? drawer;
//   final Widget? bottomNavigationBar;
//   final Widget? bottomSheet;
  
    
//   const PageBuilder( {
//     super.key,
//     required this.hasTabBar,
//     this.lenghtTabController,
//     this.customSliverAppBar,
//     this.sliversHeader,
//     required this.sliverBady,
//     this.floatingActionButton,
//     this.drawer,    
//     this.bottomNavigationBar,
//     this.bottomSheet,
//   });
  
//   @override
//   Widget build(BuildContext context) {
    
//     if (hasTabBar! && lenghtTabController != null) {
//       return DefaultTabController(
//         length: lenghtTabController!,
//          child: BuildTabView(
//           hasTabBar:hasTabBar ,
//            customSliverAppBar: customSliverAppBar,
//            sliversHeader: sliversHeader,
//            sliverBady: sliverBady,
           
            
//          )
//          );
//     }else{
//       return BuildTabView(
//           hasTabBar:hasTabBar ,
//            customSliverAppBar: customSliverAppBar,
//            sliversHeader: sliversHeader,
//            sliverBady: sliverBady,
          
            
//          );
//     }
      
    
  
//   }
 
 

// }
