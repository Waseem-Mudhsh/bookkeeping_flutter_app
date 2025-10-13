
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/responsive_notifier.dart';

class BaseLayoutScreen extends ConsumerWidget {
 
  
  final Widget? floatingActionButton;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  
  final String? routeName;
  final Widget body;

  const BaseLayoutScreen({
    super.key,
    this.floatingActionButton,
    this.drawer,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    
    this.routeName,
    required this.body, 
  }) ;
 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final responsive = ref.responsive;

    return Scaffold(
      backgroundColor: backgroundColor ,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      floatingActionButton: floatingActionButton,
      drawer: drawer,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,

      body: SafeArea(
        top: responsive.orientation == Orientation.portrait ? true : false,
        child: body,
            
              
      ),
    );
  }

  
}
