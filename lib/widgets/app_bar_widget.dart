import 'package:bookkeeping_flutter_app/utils/responsive.dart';
import 'package:flutter/material.dart';

import '../views/custom_drawer.dart';
import 'tsk-progress-card.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
      
  //     body: CustomScrollView(
  //       slivers: <Widget>[
  //         SliverAppBar(
  //           floating: true,
  //           snap: true,
  //           pinned: true,
  //           flexibleSpace: FlexibleSpaceBar(
  //             background: Container(
  //               decoration: BoxDecoration(
  //                 gradient: LinearGradient(
  //                   begin: Alignment.topCenter,
  //                   end: Alignment.bottomCenter,
  //                   colors: [
  //                     Colors.deepPurple.shade200,
  //                     Colors.deepPurple.shade800,
  //                   ],
  //                 ),
  //               ),
  //               padding: EdgeInsets.only(top: 20,bottom:20 ),
  //               child: TaskProgressCard(),
                
  //             ),
              
             
  //             // title: Text('Bookkeeping App'),
  //           ),
  //           expandedHeight: Responsive.responsiveWidth(context, 400),
            

  //           backgroundColor: Colors.deepPurple,
  //           title: Text('Bookkeeping App Sliver AppBar'),
  //           leading: Icon(Icons.menu),

  //           actions: [
  //             IconButton(
  //               icon: Icon(Icons.search),
  //               onPressed: () {
  //                 // Add search functionality
  //               },
  //             ),
  //             IconButton(
  //               icon: Icon(Icons.notifications),
  //               onPressed: () {
  //                 // Add notification functionality
  //               },
  //             ),
  //           ],
  //         ),
  //         // SliverToBoxAdapter(child: Container(height: 600, color: Colors.red)),
  //         SliverToBoxAdapter(
  //           child: Container(height: 300, color: Colors.green),
  //         ),
  //         SliverToBoxAdapter(child: Container(height: 200, color: Colors.blue)),
  //         SliverToBoxAdapter(child: Container(height: 400, color: Colors.purple)),
  //       ],
        
  //     ),
      
  //   );
  // }



  Widget build(BuildContext context) {
    return 
       Directionality(
         textDirection: TextDirection.rtl,
         child: Scaffold(
         
          drawer: CustomDrawer(),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                floating: false,
                snap: false,
                pinned: true, // تثبيت العنصر عند التمرير لأعلى
                leading: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  }) ,
                title: Text('Bookkeeping App Sliver AppBar'),
                actions: [
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      // Add search functionality
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      // Add notification functionality
                    },
                  ),
                ]
              ),
              // SliverPersistentHeader لتثبيت SliverToBoxAdapter
              SliverPersistentHeader(
                floating: false,
                pinned: true, // تثبيت العنصر عند التمرير لأعلى
                
                delegate: _SliverAppBarDelegate(
                  minHeight: 300.0, // الارتفاع الأدنى عند التمرير لأسفل
                  maxHeight: 300.0, // الارتفاع الأقصى عند التمرير لأعلى
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TaskProgressCard(),
                      SizedBox(
                        height: 100,
                        child: Row(
                          children: [
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              // Add search functionality
                            },
                        
                          ),
                          IconButton(
                            icon: Icon(Icons.notifications),
                            onPressed: () {
                              // Add notification functionality
                            },
                          ),
                        ]),
                      )
                    ],
         
                  ),
                ),
              ),
              // قائمة العناصر
              SliverPersistentHeader(
                 floating: false,
                pinned: true, // تثبيت العنصر عند التمرير لأعلى
                
                delegate: _SliverAppBarDelegate(
                  minHeight: 100.0, // الارتفاع الأدنى عند التمرير لأسفل
                  maxHeight: 100.0, // الارتفاع الأقصى عند التمرير لأعلى
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      
                      SizedBox(
                        height: 100,
                        child: Row(
                          children: [
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              // Add search functionality
                            },
                        
                          ),
                          IconButton(
                            icon: Icon(Icons.notifications),
                            onPressed: () {
                              // Add notification functionality
                            },
                          ),
                        ]),
                      )
                    ],
         
                  ),
                ),
                ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ListTile(
                      title: Text('Item $index'),
                    );
                  },
                  childCount: 20,
                ),
              ),
            ],
          ),
               ),
       );
    
  }
}

// Delegate لتخصيص SliverPersistentHeader
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
