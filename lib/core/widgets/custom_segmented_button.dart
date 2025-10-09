import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomSegmentedButton extends ConsumerStatefulWidget {
  final List<String> nameButtons;
  final List<Widget> contentButtons;
  

  const CustomSegmentedButton({
    super.key,
    required this.nameButtons,
    required this.contentButtons,
    
  });

  @override
  ConsumerState<CustomSegmentedButton> createState() =>
      _CustomSegmentedButtonState();
}

class _CustomSegmentedButtonState extends ConsumerState<CustomSegmentedButton> {
  late List<String> buttons;
  late List<Widget> contents;
  int selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    buttons = List.from(widget.nameButtons);
    contents = List<Widget>.of(widget.contentButtons);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
        Center(
          child: SegmentedButton(
            showSelectedIcon: false,
            expandedInsets: EdgeInsets.only(
              left: responsive.w(16),
              right: responsive.w(16),
            ),
            style: SegmentedButton.styleFrom(
              
              side: BorderSide(
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                width: 0.5,
              ),
             
            ),
            segments:
                buttons.asMap().entries.map((entry) {
                  final index = entry.key;
                  final button = entry.value;
                  return ButtonSegment(
                    value: index,
                    label: CustomAutoSizeText(
                      text: button,
                      style: theme.textTheme.bodyMedium, 
                      fontSize:12,
                    ),
                  );
                }).toList(),
            selected: {selectedIndex},
            onSelectionChanged: (newSelection) {
              _updateSelected(newSelection);
            },
          ),
        ),

        // محتوى العنصر المختار
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: SizedBox(
            key: ValueKey<int>(selectedIndex),
            width: double.infinity,
            child: Align(
              alignment: Alignment.topRight,
              child: contents[selectedIndex],
            ),
          ),
        ),
      ],
    );
  }

  void _updateSelected(Set<int> newSelection) {
    setState(() {
      selectedIndex = newSelection.first;
    });
  }
}
