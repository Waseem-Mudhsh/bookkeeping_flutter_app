import 'package:bookkeeping_flutter_app/core/utils/responsive_values.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomSegmentedButton extends ConsumerStatefulWidget {
  final List<String> nameButtons;
  final List<Widget> contentButtons;
  final ThemeData theme;
  final ResponsiveValues responsive;

  const CustomSegmentedButton({
    super.key,
    required this.nameButtons,
    required this.contentButtons,
    required this.theme,
    required this.responsive,
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
    // final theme = ref.watch(themeDataProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,

      children: [
        // Horizontal List of Buttons
        Center(
          child: SegmentedButton(
            showSelectedIcon: false,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color?>((
                Set<WidgetState> states,
              ) {
                if (states.contains(WidgetState.selected)) {
                  return widget.theme.colorScheme.tertiary;
                }
                return widget.theme.colorScheme.tertiary.withValues(
                  alpha: 0.01,
                );
              }),
              side: WidgetStateProperty.resolveWith<BorderSide?>((
                Set<WidgetState> states,
              ) {
                if (states.contains(WidgetState.selected)) {
                  return BorderSide(
                    color: widget.theme.colorScheme.tertiary,
                    width: 2,
                  );
                }
                return BorderSide(
                  color: widget.theme.colorScheme.tertiary.withValues(
                    alpha: 0.2,
                  ),
                  width: 1,
                );
              }),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              padding: WidgetStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
              overlayColor: WidgetStateProperty.all<Color>(
                widget.theme.colorScheme.tertiary.withValues(alpha: 0.01),
              ),
            ),
            segments:
                buttons.asMap().entries.map((entry) {
                  final index = entry.key;
                  final button = entry.value;
                  final isSelected = index == selectedIndex;
                  return ButtonSegment(
                    value: index,
                    label: CustomAutoSizeText(
                      text: button,
                      style: widget.theme.textTheme.bodyMedium,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize:12,
                      colorText:
                          isSelected
                              ? widget.theme.colorScheme.onTertiary
                              : widget.theme.colorScheme.onSurface.withValues(
                                alpha: 0.3,
                              ),
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
          duration: const Duration(milliseconds: 400),
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
