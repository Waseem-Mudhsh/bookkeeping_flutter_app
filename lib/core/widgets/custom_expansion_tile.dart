import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';



class CustomExpansionTile extends ConsumerStatefulWidget {
  final IconData? leading;
  final String? title;
  final String? subtitle;
  final bool? isExpanded;
  final bool? isBorder;
  final List<Widget>? children;

  const CustomExpansionTile({
    super.key,
    required this.title,
    this.leading,
    this.subtitle,
    this.isExpanded,
    this.isBorder =true,
    required this.children,
  });

  @override
  ConsumerState<CustomExpansionTile> createState() => _CustomExpansionTileState();
  
}

class _CustomExpansionTileState extends ConsumerState<CustomExpansionTile> {
 late bool _isExpanded;
 late bool? _isBorder;
  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded ?? false;
    _isBorder = widget.isBorder?? true;
  }
 

  @override
  Widget build(BuildContext context) {
    final responsive = ref.responsive;
    final theme = ref.theme;
    return ExpansionTile(
      tilePadding: responsive.paddingSym(h: 16, v: 8),
     expansionAnimationStyle: AnimationStyle(
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeInOut,),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      initiallyExpanded: _isExpanded,
      childrenPadding: responsive.paddingSym(h: 16, v: 8),
      shape: _isBorder! ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(4),
      
     
      ) : null,
      
      collapsedShape:  _isBorder! ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)) : null,
      
      backgroundColor: theme.colorScheme.primaryContainer.withValues(alpha: 0.2),
      textColor: theme.colorScheme.onPrimaryContainer,
      collapsedBackgroundColor: theme.colorScheme.surface,
      collapsedTextColor: theme.colorScheme.error,
      trailing: Icon(
        _isExpanded ? Icons.expand_less : Icons.expand_more,
        color: _isExpanded
            ? theme.colorScheme.onPrimaryContainer
            : theme.colorScheme.primary,
      ),
      onExpansionChanged: (value) {
        setState(() {
          _isExpanded = value;
        });
      },
      leading:widget.leading != null ? HugeIcon( icon:widget.leading!, color: _isExpanded ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.primary,) : null,
      title: CustomAutoSizeText(
        text: widget.title!,
        style: theme.textTheme.bodyMedium,
        fontSize: 12,
        fontWeight: FontWeight.w700,
        colorText: _isExpanded ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.primary,
       
      ),
      subtitle: widget.subtitle != null
          ? CustomAutoSizeText(
              text: widget.subtitle!,
              style: theme.textTheme.bodySmall,
              fontSize: 10,
              colorText: _isExpanded ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onSurface.withValues(alpha: 0.7),
            )
          : null,
      children: widget.children ?? [],
    
    );
  }
}
