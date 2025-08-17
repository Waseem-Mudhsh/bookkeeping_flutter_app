import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';

class CustomDropdownSheet<T> extends StatelessWidget{
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

  Widget build(BuildContext context) {
  
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