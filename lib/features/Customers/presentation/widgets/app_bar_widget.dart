import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/custom_button.dart';

import '../../../../core/widgets/custom_drawer.dart';
import 'responsive_card.dart';
import 'tsk_progress_card.dart';

class AppBarWidget extends ConsumerWidget {
  const AppBarWidget({super.key});

  

  @override
  //  Scaffold(
  //         body: SafeArea(
  //           child: Padding(
  //             padding: EdgeInsets.all(
  //               Responsive.responsivePadding(context, 16)),
  //             child: body,
  //           ),
  //         ),
  //       ),
  Widget build(BuildContext context,WidgetRef ref) {
    
    return Scaffold(
      drawer: CustomDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor:Theme.of(context).colorScheme.secondary,
            foregroundColor: Theme.of(context).colorScheme.onSecondary,
            floating: false,
            snap: false,
            pinned: true, // تثبيت العنصر عند التمرير لأعلى
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
            title: Text(
              'Bookkeeping App Sliver AppBar',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

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
            ],
          ),

          // SliverPersistentHeader لتثبيت SliverToBoxAdapter
          SliverPersistentHeader(
            floating: false,
            pinned: false, // تثبيت العنصر عند التمرير لأعلى

            delegate: _SliverAppBarDelegate(
              minHeight: 300, // الارتفاع الأدنى عند التمرير لأسفل
              maxHeight: 400, // الارتفاع الأقصى عند التمرير لأعلى
              child: TaskProgressCard(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(
                16,
              ),
              child: SizedBox(
                height: 400,
                child: ResponsiveCard(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(
                16,
              ),
              child: SizedBox(
                height: 400,
                child: CustomButton(
                  text: "Click Me",
                  textColor: Colors.white,
                  backgroundColor: Colors.blue,
                  onTap: () => {},
                ),
              ),
            ),
          ),

          // قائمة العناصر
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return ListTile(title: Text('Item $index'));
            }, childCount: 20),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Colors.green,
          ),
        ],
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
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
