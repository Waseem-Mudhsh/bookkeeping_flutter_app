import 'package:bookkeeping_flutter_app/core/utils/responsive_values.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_text_form_field.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class CustomHorizontalListView extends ConsumerStatefulWidget {
  final List<String> nameButtons;
  final List<Widget> contentWidgets;
  final ThemeData theme;
  final ResponsiveValues responsive;

  const CustomHorizontalListView({
    super.key,
    required this.nameButtons,
    required this.contentWidgets,
    required this.theme,
    required this.responsive,
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

  void _addNewButton(String name) {
    setState(() {
      buttons.add(name);
      contents.add(
        CustomAutoSizeText(text: '📌 محتوى $name',textAlign: TextAlign.center,),
      );
      selectedIndex = buttons.length - 1;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: CustomAutoSizeText(text: 'تمت إضافة "$name"',
      colorText: Colors.white,)),
    );
  }

  void _showAddDialog() {
    
    String newName = '';
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title:  CustomAutoSizeText(text: 'إضافة تصنيف جديد',
        style: widget.theme.textTheme.bodyMedium,
        fontWeight: FontWeight.bold,
         colorText: widget.theme.colorScheme.secondary,),
        content: CustomTextField(
          
        controller: TextEditingController(),
        label: 'اسم التصنيف',
        hint: 'أدخل اسم التصنيف الجديد',
        keyboardType: TextInputType.text,
          onChanged: (val) => newName = val,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const CustomAutoSizeText(text: 'إلغاء'),
          ),
          CustomButton(
            backgroundColor: widget.theme.colorScheme.secondary,
            textColor: widget.theme.colorScheme.onSecondary,
            onPressed: () {
              if (newName.trim().isNotEmpty) {
                _addNewButton(newName.trim());
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: CustomAutoSizeText(text: 'الرجاء إدخال اسم صالح',
                  colorText: Colors.white,)),
                );
              }
            },
            text: 'إضافة',
          ),
        ],
      ),
      animationStyle: AnimationStyle(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final theme = ref.watch(themeDataProvider);
    

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
    
      children: [
        
        // الأزرار العلوية
        // ScrollConfiguration(
        //   behavior: const ScrollBehavior().copyWith(physics: NeverScrollableScrollPhysics()),
        //   child: Wrap(
        //     spacing: 8,
        //     runSpacing: 8,
        //     children: [
        //       ...List.generate(buttons.length, (index) {
        //         final isSelected = index == selectedIndex;
        //         return ChoiceChip(
        //           showCheckmark: false,
        //           label: Text(buttons[index]),
        //           selected: isSelected,
        //           onSelected: (_) {
        //             setState(() {
        //               selectedIndex = index;
        //             });
        //           },
        //           selectedColor: theme.colorScheme.secondary,
        //           backgroundColor: theme.colorScheme.surface,
        //           labelStyle: theme.textTheme.bodyMedium!.copyWith(
        //             color: isSelected
        //                 ? theme.colorScheme.onSecondary
        //                 : theme.colorScheme.onSurface,
        //             fontWeight:
        //                 isSelected ? FontWeight.bold : FontWeight.normal,
        //           ),
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(4),
        //             side: BorderSide(
        //               color: isSelected
        //                   ? theme.colorScheme.secondary
        //                   : theme.colorScheme.onSurface.withValues(alpha: 0.5),
        //               width: 0.5,
        //             ),
        //           ),
        //         );
        //       }),
          
        //       // زر الإضافة
        //       // ActionChip(
        //       //   avatar: Icon(Icons.add, size: 24, color: theme.colorScheme.secondary,), 
        //       //   label: CustomAutoSizeText(text: 'إضافة', colorText: theme.colorScheme.secondary,),
        //       //   onPressed: _showAddDialog,
        //       //   backgroundColor: theme.colorScheme.surface,
                
        //       //   shape: RoundedRectangleBorder(
        //       //     borderRadius: BorderRadius.circular(4),
        //       //     side: BorderSide(
        //       //       color: theme.colorScheme.secondary.withValues(alpha: 0.5),
        //       //       width: 0.5,
        //       //     ),
        //       //   ),
                
        //       // ),
        //     ],
        //   ),
        // ),
        ResponsiveSpace(
          height: 40, // ارتفاع ثابت لصف الأزرار
          child: ListView.builder(
            
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: buttons.length + 1, // +1 لزر الإضافة
            itemBuilder: (context, index) {
              if (index == buttons.length) {
                // زر الإضافة
                return ChoiceChip(
                  label: const Icon(Icons.add),
                  selected: false,
                  onSelected: (_) => _showAddDialog(),
                  selectedColor: widget.theme.colorScheme.secondary,
                  backgroundColor: widget.theme.colorScheme.surface,
                  labelStyle: widget.theme.textTheme.bodyMedium!.copyWith(
                    color: widget.theme.colorScheme.secondary,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: BorderSide(
                      color: widget.theme.colorScheme.secondary
                          .withValues(alpha: 0.5),
                      width: 0.5,
                    ),
                  ),
                );
              }
              
              final isSelected = index == selectedIndex;
              return ChoiceChip(
                showCheckmark: false,
                label: CustomAutoSizeText(text:buttons[index],
                style: widget.theme.textTheme.bodyMedium,
                fontSize: 12,
                colorText: isSelected? widget.theme.colorScheme.onSecondary
                      : widget.theme.colorScheme.onSurface,
                fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                selected: isSelected,
                onSelected: (_) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                selectedColor: widget.theme.colorScheme.secondary,
                backgroundColor: widget.theme.colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(
                    color: isSelected
                        ? widget.theme.colorScheme.secondary
                        : widget.theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    width: 0.5,
                  ),
                ),
              );
            },
          ),
        ),
    
      
    
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
}
