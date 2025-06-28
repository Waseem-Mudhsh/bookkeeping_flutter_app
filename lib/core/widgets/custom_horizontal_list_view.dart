import 'package:bookkeeping_flutter_app/core/providers/theme_data_provider.dart'
    show themeDataProvider;
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_text_form_field.dart';
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

  @override
  void initState() {
    super.initState();
    buttons = List.from(widget.nameButtons);
    contents = List.from(widget.contentWidgets);
  }

  void _addNewButton(String name) {
    setState(() {
      buttons.add(name);
      contents.add(
        CustomAutoSizeText(text: '📌 محتوى $name',),
      );
      selectedIndex = buttons.length - 1;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: CustomAutoSizeText(text: 'تمت إضافة "$name"',
      colorText: Colors.white,)),
    );
  }

  void _showAddDialog() {
    final theme = ref.watch(themeDataProvider);
    String newName = '';
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title:  CustomAutoSizeText(text: 'إضافة عنصر جديد',
        style: theme.textTheme.bodyMedium,
        fontWeight: FontWeight.bold,
         colorText: theme.colorScheme.primary,),
        content: CustomTextField(
          
        controller: TextEditingController(),
        label: 'اسم العنصر',
        hint: 'أدخل اسم العنصر الجديد',
        keyboardType: TextInputType.text,
          onChanged: (val) => newName = val,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const CustomAutoSizeText(text: 'إلغاء'),
          ),
          CustomButton(
            backgroundColor: theme.colorScheme.primary,
            textColor: theme.colorScheme.onPrimary,
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
    final theme = ref.watch(themeDataProvider);
    

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // الأزرار العلوية
        Align(
          alignment: Alignment.topRight,
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ...List.generate(buttons.length, (index) {
                  final isSelected = index == selectedIndex;
                  return ChoiceChip(
                    showCheckmark: false,
                    label: Text(buttons[index]),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    selectedColor: theme.colorScheme.tertiary,
                    backgroundColor: theme.colorScheme.surface,
                    labelStyle: theme.textTheme.bodyMedium!.copyWith(
                      color: isSelected
                          ? theme.colorScheme.onTertiary
                          : theme.colorScheme.onSurface,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  );
                }),
            
                // زر الإضافة
                ActionChip(
                  label: const Icon(Icons.add, size: 24, color: Colors.white),
                  onPressed: _showAddDialog,
                  backgroundColor: theme.colorScheme.tertiary,
                  elevation: 2,
                ),
              ],
            ),
          ),
        ),

        const ResponsiveSpace(height: 16),

        // محتوى العنصر المختار
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: SizedBox(
              key: ValueKey<int>(selectedIndex),
              width: double.infinity,
              child: contents[selectedIndex],
            ),
          ),
        ),
      ],
    );
  }
}
