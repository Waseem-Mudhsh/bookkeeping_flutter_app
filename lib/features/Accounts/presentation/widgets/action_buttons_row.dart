import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/responsive_values.dart';
import '../../../../core/widgets/responsive_space.dart';

// This widget is responsible for the horizontal row of action icons (تصميم مضغوط).
class ActionButton{
  final String? label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isCompact;
  final Color? backgroundColor;
  final Color? iconColor;
  ActionButton( { this.label, required this.icon, required this.onPressed,
   this.isCompact = false, this.backgroundColor, this.iconColor});
}
class ActionButtonsRow extends ConsumerWidget {
  final List<ActionButton> actionButtons;
 

  const ActionButtonsRow({super.key, required this.actionButtons});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ref.responsive;
    final theme = ref.theme;

    return Row(
      // mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: actionButtons.map((actionButton) {
        return _buildActionButton(
          context: context,
          responsive: responsive,
          theme: theme,
          icon: actionButton.icon,
          label: actionButton.label,
          onPressed: actionButton.onPressed,
          isCompact: actionButton.isCompact,
          backgroundColor: actionButton.backgroundColor,
          iconColor: actionButton.iconColor,
        );
      }).toList(),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required ResponsiveValues responsive,
    required ThemeData theme,
    required IconData icon,
     String? label,
    required VoidCallback onPressed,
    bool isCompact = false,
    Color? backgroundColor,
    Color? iconColor,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: theme.colorScheme.primary.withValues(alpha: 0.3),
            highlightColor: theme.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(responsive.w(12)),
            onTap: onPressed,
            child: Container(
              padding: responsive.paddingAll(6),
              decoration: BoxDecoration(
                color:backgroundColor ?? theme.colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(responsive.w(12)),
            
                
              ),
              child: CustomHugeIcon(icon: icon, size:20, color: iconColor ?? theme.colorScheme.primary),),
          ),
        ),
        if (label != null) ...{
          ResponsiveSpace(height: responsive.h(6)),
          CustomAutoSizeText(
           text:  label,
            style: theme.textTheme.labelMedium,
            colorText: theme.colorScheme.primary,
            fontSize: 10,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
          ),
        }
      ],
    );
  }
}