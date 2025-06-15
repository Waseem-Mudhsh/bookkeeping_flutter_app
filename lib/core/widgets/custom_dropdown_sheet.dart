import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomDropdownSheet<T> extends ConsumerWidget{
 final List<T> items;
  final T selectedItem;
  final Widget Function(T item) selectedItemBuilder;
  final Widget Function(T item) itemBuilder;
  final ValueChanged<T> onSelected;
  const CustomDropdownSheet({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.selectedItemBuilder,
    required this.itemBuilder,
    required this.onSelected,
  });
   void _showDropdownSheet(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      builder: (_) {
        return ListView(
          children: items.map((item) {
            return InkWell(
              onTap: () {
                Navigator.pop(context);
                onSelected(item);
              },
              child: itemBuilder(item), // custom full widget
            );
          }).toList(),
        );
      },
    );
  }
  

  @override
  // Widget build(BuildContext context, WidgetRef ref) {
  //   final responsive = ref.watch(responsiveProvider);
  //  return OutlinedButton(
  //     onPressed: () => _showDropdownSheet(context),
  //     style: OutlinedButton.styleFrom(padding: responsive.paddingSym(h: 16, v: 16)),
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         selectedItemBuilder(selectedItem), // custom selected item UI
  //        ResponsiveSpace(width: 4), 
  //         const Icon(Icons.arrow_drop_down),
  //       ],
  //     ),
  //   );
  // }
  Widget build(BuildContext context, WidgetRef ref) {
  
    return InkWell(
      onTap: () => _showDropdownSheet(context),
      
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          selectedItemBuilder(selectedItem), // custom selected item UI
         ResponsiveSpace(width: 4), 
          const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }
}