import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class CustomHorizontalListView extends ConsumerStatefulWidget {
  final List<String> nameButtons;
  final List<Widget> contentWidgets;
  

  const CustomHorizontalListView({
    super.key,
    required this.nameButtons,
    required this.contentWidgets,
    
  });

  @override
  ConsumerState<CustomHorizontalListView> createState() =>
      _CustomHorizontalListViewState();
}

class _CustomHorizontalListViewState
    extends ConsumerState<CustomHorizontalListView> {
  late List<String> buttons;
  late List<Widget> contents;
  int selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  

  @override
  void initState() {
    super.initState();
    buttons = List.from(widget.nameButtons);
    contents =List<Widget>.of(widget.contentWidgets);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // void _addNewButton(String name) {
  //   setState(() {
  //     buttons.add(name);
  //     contents.add(
  //       CustomAutoSizeText(text: '📌 محتوى $name',textAlign: TextAlign.center,),
  //     );
  //     selectedIndex = buttons.length - 1;
  //   });

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: CustomAutoSizeText(text: 'تمت إضافة "$name"',
  //     colorText: Colors.white,)),
  //   );
  // }

  

  @override
  Widget build(BuildContext context) {
    final theme = ref.theme;
    final responsive = ref.responsive;
    
    

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
    
      children: [
        // Horizontal List of Buttons
        ResponsiveSpace(
          height: 40, // ارتفاع ثابت لصف الأزرار
          child: ListView.builder(
            
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: buttons.length, // +1 لزر الإضافة
            itemBuilder: (context, index) {
              // if (index == buttons.length) {
              //   // زر الإضافة
              //   return Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 2.0),
              //     child: ChoiceChip(
              //       label:  Icon(Icons.add, size: 20, color: widget.theme.colorScheme.secondary,),
              //       selected: false,
              //       onSelected: (_) => _showAddDialog(),
              //       selectedColor: widget.theme.colorScheme.secondary,
              //       backgroundColor: widget.theme.colorScheme.surface,
              //       labelStyle: widget.theme.textTheme.bodyMedium!.copyWith(
              //         color: widget.theme.colorScheme.secondary,
              //       ),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(4),
              //         side: BorderSide(
              //           color: widget.theme.colorScheme.secondary
              //               .withValues(alpha: 0.5),
              //           width: 0.5,
              //         ),
              //       ),
              //     ),
              //   );
              // }
              
              final isSelected = index == selectedIndex;
              return Padding(
                padding: responsive.paddingOnly(left: 6),
                child: ChoiceChip(
                  showCheckmark: false,
                  label: CustomAutoSizeText(text:buttons[index],
                  style: theme.textTheme.bodyMedium,
                  fontSize: 12,
                  // colorText: isSelected? widget.theme.colorScheme.onPrimaryContainer
                  //       : widget.theme.colorScheme.onSurface,
                  fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                 
                  
                ),
              );
            },
          ),
        ),
        const ResponsiveSpace(height: 8),
    
      
    
        // محتوى العنصر المختار
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: SizedBox(
            key: ValueKey<int>(selectedIndex),
            width: double.infinity,
            child: Align(
              alignment: Alignment.topRight,
              child: contents[selectedIndex]),
          ),
        ),
      ],
    );
  }
  // void _showAddDialog() {
    
  //   String newName = '';
  //   showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       title:  CustomAutoSizeText(text: 'إضافة تصنيف جديد',
  //       style: widget.theme.textTheme.bodyMedium,
  //       fontWeight: FontWeight.bold,
  //        colorText: widget.theme.colorScheme.secondary,),
  //       content: CustomTextField(
          
  //       controller: TextEditingController(),
  //       label: 'اسم التصنيف',
  //       hint: 'أدخل اسم التصنيف الجديد',
  //       keyboardType: TextInputType.text,
  //         onChanged: (val) => newName = val,
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const CustomAutoSizeText(text: 'إلغاء'),
  //         ),
  //         CustomButton(
  //           backgroundColor: widget.theme.colorScheme.secondary,
  //           textColor: widget.theme.colorScheme.onSecondary,
  //           onPressed: () {
  //             if (newName.trim().isNotEmpty) {
  //               _addNewButton(newName.trim());
  //               Navigator.pop(context);
  //             } else {
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 const SnackBar(content: CustomAutoSizeText(text: 'الرجاء إدخال اسم صالح',
  //                 colorText: Colors.white,)),
  //               );
  //             }
  //           },
  //           text: 'إضافة',
  //         ),
  //       ],
  //     ),
  //     animationStyle: AnimationStyle(
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeInOut,
  //     ),
  //   );
  // }
}
