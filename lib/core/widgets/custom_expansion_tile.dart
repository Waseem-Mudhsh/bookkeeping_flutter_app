import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/responsive_notifier.dart';
import '../providers/theme_data_provider.dart';

class CustomExpansionTile extends ConsumerStatefulWidget {
  final String? title;
  final String? subtitle;
  final bool? isExpanded;
  final List<Widget>? children;

  const CustomExpansionTile({
    super.key,
    required this.title,
    this.subtitle,
    this.isExpanded,
    required this.children,
  });

  @override
  ConsumerState<CustomExpansionTile> createState() => _CustomExpansionTileState();
  
}

class _CustomExpansionTileState extends ConsumerState<CustomExpansionTile> {
  bool _isExpanded = false;
  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded ?? false;
  }
 

  @override
  Widget build(BuildContext context) {
    final responsive = ref.watch(responsiveProvider);
    final theme = ref.watch(themeDataProvider);
    return ExpansionTile(
      
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      initiallyExpanded: _isExpanded,
      childrenPadding: responsive.paddingSym(h: 16, v: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      backgroundColor: theme.colorScheme.surface,
      textColor: theme.colorScheme.onSurface,
      collapsedBackgroundColor: theme.colorScheme.secondary,
      collapsedTextColor: theme.colorScheme.onSecondary,
      trailing: Icon(
        _isExpanded ? Icons.expand_less : Icons.expand_more,
        color: _isExpanded
            ? theme.colorScheme.secondary
            : theme.colorScheme.onSecondary,
      ),
      onExpansionChanged: (value) {
        setState(() {
          _isExpanded = value;
        });
      },
      title: CustomAutoSizeText(
        text: widget.title!,
        style: theme.textTheme.bodyMedium,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        colorText: _isExpanded
            ? theme.colorScheme.secondary
            : theme.colorScheme.onSecondary,
      ),
      subtitle: widget.subtitle != null
          ? CustomAutoSizeText(
              text: widget.subtitle!,
              style: theme.textTheme.bodySmall,
              fontSize: 10,
              colorText: _isExpanded
                  ? theme.colorScheme.secondary.withValues(alpha: 0.7)
                  : theme.colorScheme.onSecondary.withValues(alpha: 0.7),
            )
          : null,
      children: widget.children ?? [],

    );
  }
}
