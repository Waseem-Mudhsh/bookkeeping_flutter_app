import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


/// ويدجت 'Scaffold' تكيفي شامل يتبع إرشادات Material Design 3
/// ويدعم جميع الخصائص الأساسية لـ Scaffold.
class AdaptiveScaffold extends StatelessWidget {
  // --- الخصائص الأساسية ---
  
  final Widget body;

  // --- خصائص التنقل التكيفي ---
  final List<NavigationDestination>? destinations;
  final int? selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  // --- خصائص Scaffold الإضافية (الجديدة) ---
  
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? drawer;
  final Widget? endDrawer; // (ممتاز للفلاتر)
  final Widget? bottomSheet;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final Widget? widgetBottomNavigationBar;

  // --- نقاط التوقف (Breakpoints) ---
  final double tabletBreakpoint;
  final double desktopBreakpoint;

  const AdaptiveScaffold({
    super.key,
    // أساسي
    
    required this.body,
    // للتنقل
     this.destinations,
     this.selectedIndex,
     this.onDestinationSelected,
    // إضافي (جديد)
    
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.drawer,
    this.endDrawer,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.widgetBottomNavigationBar,
    // نقاط التوقف
    this.tabletBreakpoint = 600.0,
    this.desktopBreakpoint = 1200.0,
  }) : 
        // --- (1) إضافة تحقق منطقي ---
        // إذا وفرت واحدة من خصائص التنقل، يجب أن توفرها كلها
        assert(
          (destinations == null && selectedIndex == null && onDestinationSelected == null) ||
          (destinations != null && selectedIndex != null && onDestinationSelected != null),
          'إذا قمت بتوفير "destinations"، يجب عليك أيضاً توفير "selectedIndex" و "onDestinationSelected".'
        );

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    final Orientation orientation = MediaQuery.of(context).orientation;
    // --- (2) التحقق من وجود تنقل ---
    final bool hasNavigation = destinations != null &&
        selectedIndex != null &&
        onDestinationSelected != null;
    return LayoutBuilder(
      builder: (context, constraints) {
        // --- 1. حالة الكمبيوتر (Expanded Layout) ---
        if (constraints.maxWidth >= desktopBreakpoint) {
          return Scaffold(
            backgroundColor: backgroundColor,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            
            drawer: drawer, // <-- تمرير
            endDrawer: endDrawer, // <-- تمرير
            floatingActionButton: floatingActionButton, // <-- تمرير
            floatingActionButtonLocation:
                floatingActionButtonLocation, // <-- تمرير
            body: SafeArea(
              top: orientation == Orientation.portrait ? false : true,
              child: Padding(
                padding: EdgeInsets.only(bottom: bottomPadding + 8),
                child: hasNavigation ? Row(
                  children: [
                     NavigationRail(
                      destinations:
                          destinations!.map((dest) {
                            return NavigationRailDestination(
                              icon: dest.icon,
                              selectedIcon: dest.selectedIcon,
                              label: Text(dest.label),
                            );
                          }).toList(),
                      selectedIndex: selectedIndex,
                      onDestinationSelected: onDestinationSelected,
                      extended: true,
                      minExtendedWidth: constraints.maxWidth * 0.25,
                    ),
                    const VerticalDivider(thickness: 1, width: 1),
                    Expanded(child: body),
                  ],
                ) : body,
              ),
            ),
            bottomSheet: bottomSheet,
            bottomNavigationBar:  widgetBottomNavigationBar
          );
        }

        // --- 2. حالة التابلت (Medium Layout) ---
        if (constraints.maxWidth >= tabletBreakpoint) {
          return Scaffold(
            
            drawer: drawer, // <-- تمرير
            endDrawer: endDrawer, // <-- تمرير
            floatingActionButton: floatingActionButton, // <-- تمرير
            floatingActionButtonLocation:
                floatingActionButtonLocation, // <-- تمرير
            body: SafeArea(
              top: orientation == Orientation.portrait ? false : true,
              child: Padding(
                padding: EdgeInsets.only(bottom: bottomPadding + 8),
                child: hasNavigation ? Row(
                  children: [
                    // شريط التنقل الرئيسي (جانبي)
                    NavigationRail(
                      destinations:
                          destinations!.map((dest) {
                            return NavigationRailDestination(
                              icon: dest.icon,
                              selectedIcon: dest.selectedIcon,
                              label: Text(dest.label),
                            );
                          }).toList(),
                      selectedIndex: selectedIndex,
                      onDestinationSelected: onDestinationSelected,
                      extended: true,
                      minExtendedWidth: constraints.maxWidth * 0.25,
                    ),
                    const VerticalDivider(thickness: 1, width: 1),
                    Expanded(child: body),
                  ],
                ) : body,
              ),
            ),
            bottomSheet: bottomSheet,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            // شريط التنقل الرئيسي (سفلي)
            bottomNavigationBar:  widgetBottomNavigationBar
          );
        }

        // --- 3. حالة الهاتف (Compact Layout) ---
        return Scaffold(
          
          backgroundColor: backgroundColor,
          drawer: drawer, // <-- تمرير
          endDrawer: endDrawer, // <-- تمرير
          floatingActionButton: floatingActionButton, // <-- تمرير
          floatingActionButtonLocation:
              floatingActionButtonLocation, // <-- تمرير
          body: _buildBody(context,body),
          bottomSheet: bottomSheet,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          // شريط التنقل الرئيسي (سفلي)
          bottomNavigationBar: hasNavigation ? NavigationBar(
            destinations: destinations!,
            selectedIndex: selectedIndex!,
            onDestinationSelected: onDestinationSelected,
          ) : widgetBottomNavigationBar
        );
      },
    );
  }
  Widget _buildBody(BuildContext context, Widget body) {
    return Consumer(
            builder: (context, ref, child) {
              final responsive = ref.responsive;
              return SafeArea(
                top:
                    responsive.orientation == Orientation.portrait
                        ? false
                        : true,
                child: body,
              );
            },
          );
  }
}
