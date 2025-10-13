 import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomPadding extends ConsumerWidget {
  final Widget child;
  final double horizontal;
  
   const CustomPadding({
    super.key,
    required this.child,
    required this.horizontal,
    
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ref.responsive;

    return Padding(
      padding: responsive.paddingSym(
        h: responsive.designWidth > 600 ? horizontal :0,),
      
      child: child,
    );
  }
}


