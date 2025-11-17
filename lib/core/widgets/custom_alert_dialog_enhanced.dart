import 'dart:ui';

import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';

// -------------------------------------------------------------------
// 1. THE CUSTOM DIALOG WIDGET
// -------------------------------------------------------------------

class CustomAlertDialog extends ConsumerWidget {
  
  final String title;
  final IconData? hugeIconTitle;
  final Widget? content;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? titlePadding;
  final EdgeInsetsGeometry? contentPadding;
  final double? width;

  const CustomAlertDialog({
    super.key,
    
    required this.title,
    this.hugeIconTitle,
    required this.content,
    this.actions,
    this.backgroundColor,
    this.titlePadding,
    this.contentPadding,
    this.width,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    final responsive = ref.responsive;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: width ?? responsive.deviceSize.width * 0.9,
        
      ),
      child: AlertDialog(
        alignment: Alignment.center,
        backgroundColor: backgroundColor ?? theme.colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        titlePadding: titlePadding ??  responsive.paddingOnly(top: 24.0, left: 24.0, right: 24.0, bottom: 12.0),
        contentPadding: contentPadding ?? responsive.paddingOnly(left: 24.0, right: 24.0, bottom: 24.0),
        actionsPadding: responsive.paddingOnly(left: 24.0, right: 24.0, bottom: 24.0),
        title: _buildTitleWidget(title, theme, hugeIconTitle),
        content: content,
        actions: actions,
        actionsAlignment: MainAxisAlignment.end,
        // actionsOverflowSpacing: 8.0,
      ),
    );
  }
  Widget _buildTitleWidget( String title, ThemeData theme, IconData? hugeIcon) {
    return Row(
      children: [
        CustomHugeIcon(
          icon: hugeIcon?? HugeIcons.strokeRoundedInformationCircle,
          color: theme.colorScheme.primary,
          size: 28.0,
        ),
        const ResponsiveSpace(width: 16.0),
        Expanded(
          child: CustomAutoSizeText(
           text: title,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            colorText: theme.colorScheme.primary,
          ),
        ),
      ],
    );}
}

// -------------------------------------------------------------------
// 2. HELPER FUNCTION TO DISPLAY THE DIALOG
// -------------------------------------------------------------------

// دالة مساعدة لجعل عملية الاستدعاء أسهل
Future<T?> showCustomDialog<T>({
  required BuildContext context,
  required String title,
  IconData? hugeIconTitle,
  Widget? content,
  List<Widget>? actions,
  bool barrierDismissible = true,
  Color? backgroundColor,
  EdgeInsetsGeometry? titlePadding,
  EdgeInsetsGeometry? contentPadding,
  double? width,
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black.withAlpha(80),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          child: FadeTransition(
            opacity: CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            child: CustomAlertDialog(
              title: title,
              hugeIconTitle: hugeIconTitle,
              content: content,
              actions: actions,
              backgroundColor: backgroundColor,
              titlePadding: titlePadding,
              contentPadding: contentPadding,
              width: width ,
            ),
          ),
        ),
      );
    },
  );
}

// -------------------------------------------------------------------
// 3. PRESET DIALOG STYLES
// -------------------------------------------------------------------



// دالة مساعدة لإنشاء حوار تنبيهي سريع
// Future<T?> showCustomAlert<T>({
//   required BuildContext context,
//   required WidgetRef ref,
//   required String title,
//   required String message,
//    IconData? hugeIcon,
//   String confirmText = 'موافق',
//   String cancelText = 'إلغاء',
//   bool showCancel = true,
//   Color? alertColor,
//   VoidCallback? onConfirm,
//   VoidCallback? onCancel,

// }) {
//   final theme = ref.theme;
//   final responsive = ref.responsive;

//   return showCustomDialog<T>(
//     context: context,
//     titlePadding:  responsive.paddingOnly(top: 20.0, left: 20.0, right: 20.0, bottom: 12.0),
//     contentPadding:  responsive.paddingOnly(left: 20.0, right: 20.0, bottom: 20.0),
//    title: title,
//     content: CustomAutoSizeText(
//       text:  message,
//       style: theme.textTheme.bodyMedium,
//       fontSize: 12.0,
//       overflow: TextOverflow.ellipsis,
//       maxLines: 2,
//       colorText: theme.colorScheme.onSurfaceVariant,
//       fontWeight: FontWeight.w700,
//     ),
//     actions: [
//       CustomButton(
//         onPressed: onConfirm ?? () => Navigator.pop(context),
//         backgroundColor: alertColor ?? theme.colorScheme.primary,
//         width: 100.0,
//         text: confirmText,
//         textColor: theme.colorScheme.onPrimary,
//         height: 30.0,
//       ),
//       if (showCancel)
//         TextButton(
//           onPressed: onCancel ?? () => Navigator.pop(context),
//           child: CustomAutoSizeText(
//             text: cancelText,
//             colorText: theme.colorScheme.onSurface,
//             fontSize: 12.0,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
        
      
//     ],
//   );
  
// }
