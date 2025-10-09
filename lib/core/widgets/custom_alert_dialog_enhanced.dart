import 'dart:ui';

import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

// -------------------------------------------------------------------
// 1. THE CUSTOM DIALOG WIDGET
// -------------------------------------------------------------------

class CustomAlertDialog extends ConsumerWidget {
  final Widget titleWidget;
  final Widget content;
  final List<Widget>? actions;
  final bool isDismissible; // للتحكم في الإغلاق بالنقر خارجاً
  final Color? backgroundColor;
  final EdgeInsetsGeometry? contentPadding;
  final double? width;

  const CustomAlertDialog({
    super.key,
    required this.titleWidget,
    required this.content,
    this.actions,
    this.isDismissible = true,
    this.backgroundColor,
    this.contentPadding,
    this.width,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    final responsive = ref.responsive;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: width ??responsive.deviceSize.width * 0.9,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: backgroundColor ?? theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header with gradient background
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            theme.colorScheme.primary,
                            theme.colorScheme.primary.withValues(alpha: 0.8),
                          ],
                        ),
                      ),
                      child: titleWidget,
                    ),

                    // Content
                    Flexible(
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: responsive.deviceSize.height * 0.7,
                          // minHeight: responsive.h(100),
                        ),
                        padding: contentPadding ?? responsive.paddingSym(h: 16, v: 24),
                        child: content,
                      ),
                    ),

                    // Actions
                    if (actions != null)
                      Padding(
                        padding:  responsive.paddingOnly(bottom: 16, right: 16, left: 16),
                        child: OverflowBar(
                          spacing: responsive.w(12),
                          alignment: MainAxisAlignment.end,
                          // buttonPadding: EdgeInsets.zero,
                          children: actions!,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------------
// 2. HELPER FUNCTION TO DISPLAY THE DIALOG
// -------------------------------------------------------------------

// دالة مساعدة لجعل عملية الاستدعاء أسهل
Future<T?> showCustomDialog<T>({
  required BuildContext context,
  required Widget titleWidget,
  required Widget content,
  List<Widget>? actions,
  bool barrierDismissible = true,
  Color? backgroundColor,
  EdgeInsetsGeometry? contentPadding,
  double? width,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return CustomAlertDialog(
        titleWidget: titleWidget,
        content: content,
        actions: actions,
        isDismissible: barrierDismissible,
        backgroundColor: backgroundColor,
        contentPadding: contentPadding,
        width: width,
      );
    },
  );
}

// -------------------------------------------------------------------
// 3. PRESET DIALOG STYLES
// -------------------------------------------------------------------



// دالة مساعدة لإنشاء حوار تنبيهي سريع
Future<T?> showCustomAlert<T>({
  required BuildContext context,
  required WidgetRef ref,
  required String title,
  required String message,
   IconData? hugeIcon,
  String confirmText = 'موافق',
  String cancelText = 'إلغاء',
  bool showCancel = true,
  Color? alertColor,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,

}) {
  final theme = ref.theme;
  final responsive = ref.responsive;

  return showCustomDialog<T>(
    context: context,
    titleWidget: Row(
      
      children: [
        Container(
          padding: responsive.paddingSym(h: 8, v: 8),
          decoration: BoxDecoration(
            color: alertColor?.withValues(alpha: 0.5) ?? theme.colorScheme.primary.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: CustomHugeIcon(
            icon: hugeIcon ?? HugeIcons.strokeRoundedInformationCircle,
            color: theme.colorScheme.onPrimary,
            size: 24,
          ),
        ),
        const ResponsiveSpace(width: 12),
        Expanded(
          child: CustomAutoSizeText(
           text: title,
            fontSize: 14,
              fontWeight: FontWeight.bold,
            colorText: theme.colorScheme.onPrimary,
          ),
        ),
      ],
    ),
    content: CustomAutoSizeText(
      text:  message,
      style: theme.textTheme.bodyMedium,
      fontSize: 12,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      colorText: theme.colorScheme.onSurfaceVariant,
      fontWeight: FontWeight.w700,
    ),
    actions: [
      if (showCancel)
        CustomButton(
          onPressed: onCancel ?? () => Navigator.pop(context),
          backgroundColor: theme.colorScheme.surfaceContainerLowest,
          width: 100,
          text: cancelText,
          textColor: theme.colorScheme.onSurface,
          height: 40,
        ),
        
      CustomButton(
        onPressed: onConfirm ?? () => Navigator.pop(context),
       
          backgroundColor: alertColor ?? theme.colorScheme.primary,
         width: 100,
         text: confirmText,
         textColor: theme.colorScheme.onPrimary,
         height: 40,
        
        
      ),
    ],
  );
}
