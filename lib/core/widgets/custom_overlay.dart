import 'package:bookkeeping_flutter_app/core/utils/responsive_values.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';

class CustomOverlay {
  static OverlayEntry? _overlayEntry;
  
  // عرض Overlay مخصصة
  static void show({
    required BuildContext context,
    required Widget child,
    Duration? autoHideDuration,
    Color? backgroundColor,
    double? opacity,
    bool dismissible = true,
    VoidCallback? onDismiss,
  }) {
    // إغلاق أي Overlay موجودة مسبقًا
    _hide();
    
    // إنشاء Overlay جديدة
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // طبقة خلفية شبه شفافة
          if (dismissible)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  _hide();
                  onDismiss?.call();
                },
                child: Container(
                  color: (backgroundColor ?? Colors.black)
                      .withValues(alpha: opacity ?? 0.5),
                ),
              ),
            ),
          
          // المحتوى الرئيسي
          Center(
            child: Material(
              color: Colors.transparent,
              child: child,
            ),
          ),
        ],
      ),
    );
    
    // إضافة Overlay إلى الشاشة
    Overlay.of(context).insert(_overlayEntry!);
    
    // إغلاق تلقائي إذا تم تحديد مدة
    if (autoHideDuration != null) {
      Future.delayed(autoHideDuration, () {
        _hide();
        onDismiss?.call();
      });
    }
  }
  
  // إخفاء Overlay
  static void _hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
  
  // إخفاء Overlay من الخارج
  static void dismiss() {
    _hide();
  }
  
  // التحقق مما إذا كانت Overlay معروضة
  static bool isShowing() {
    return _overlayEntry != null;
  }
}
//مثال 1: عرض نافذة تحميل
// عرض نافذة التحميل
void showLoading(BuildContext context) {
  CustomOverlay.show(
    context: context,
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      strokeWidth: 4,
    ),
    backgroundColor: Colors.black,
    opacity: 0.7,
    dismissible: false,
  );
}

// إخفاء نافذة التحميل
void hideLoading() {
  CustomOverlay.dismiss();
}
//مثال 2: عرض رسالة مؤقتة
void showTemporaryMessage(BuildContext context, String message) {
  CustomOverlay.show(
    context: context,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        message,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
    autoHideDuration: Duration(seconds: 3),
  );
}

//مثال 3: عرض نافذة التاكيد
  void showConfirmationDialog({
   required BuildContext context,
  required String title,
  required Widget content,
  required VoidCallback onConfirm,
  required ThemeData theme,
  required ResponsiveValues responsive,
  String? confirmButtonText,
  String? cancelButtonText,
  Color? confirmButtonColor,
  Color? cancelButtonTextColor,
  Color? confirmButtonTextColor
}) {
  CustomOverlay.show(
    context: context,
    child: Container(
      width: responsive.deviceSize.width * 0.9,
      padding: responsive.paddingSym(h: 16, v: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomAutoSizeText(text:title,
           style: theme.textTheme.titleMedium,
            fontWeight: FontWeight.bold,),
          ResponsiveSpace(height: 16),
          content,
          ResponsiveSpace(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  CustomOverlay.dismiss();
                },
                child:CustomAutoSizeText( text:cancelButtonText ?? 'إلغاء',
           colorText: cancelButtonTextColor ?? theme.colorScheme.onSurface,
         ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: confirmButtonColor ?? theme.colorScheme.error,
                ),
                onPressed: () {
                  CustomOverlay.dismiss();
                  onConfirm();
                },
                child: CustomAutoSizeText(text: confirmButtonText ?? 'تأكيد',
         colorText: confirmButtonTextColor ?? theme.colorScheme.onError,
         ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// Future<void> showConfirmationDialog({
//   required BuildContext context,
//   required String title,
//   required Widget content,
//   required VoidCallback onConfirm,
//   required ThemeData theme,
//   required ResponsiveValues responsive,
//   String? confirmButtonText,
//   String? cancelButtonText,
//   Color? confirmButtonColor,
//   Color? cancelButtonTextColor,
//   Color? confirmButtonTextColor
// }) async {
  
//   await showDialog(
//     context: context,
//     builder: (context) { 
      
//    return AlertDialog(
//      title: CustomAutoSizeText(text: title, style: theme.textTheme.bodyMedium),
//      content: content,
//      actions: [
//        TextButton(
//          onPressed: () => Navigator.of(context).pop(), // إغلاق الـ Dialog
//          child: CustomAutoSizeText( text:cancelButtonText ?? 'إلغاء',
//            colorText: cancelButtonTextColor ?? theme.colorScheme.onSurface,
//          ),
//        ),
//        ElevatedButton(
//          style: ElevatedButton.styleFrom(
//            backgroundColor:confirmButtonColor ?? theme.colorScheme.error,
           
   
//          ),
//          onPressed: () {
//            Navigator.of(context).pop(); // إغلاق الـ Dialog
//            onConfirm();
//          },
//          child: CustomAutoSizeText(text: confirmButtonText ?? 'تأكيد',
//          colorText: confirmButtonTextColor ?? theme.colorScheme.onError,
//          ),
//        ),
//      ],
//    );
//     }
    
//   );
// }

//مثال 4: عرض قائمة منبثقة مخصصة
void showCustomMenu({
  required BuildContext context,
  required GlobalKey widgetKey,
  required List<String> items,
  required Function(int) onItemSelected,
}) {
  final renderBox = widgetKey.currentContext!.findRenderObject() as RenderBox;
  final offset = renderBox.localToGlobal(Offset.zero);

  CustomOverlay.show(
    context: context,
    child: Positioned(
      left: offset.dx,
      top: offset.dy + renderBox.size.height,
      child: Material(
        elevation: 4,
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(items.length, (index) {
              return ListTile(
                title: Text(items[index]),
                onTap: () {
                  CustomOverlay.dismiss();
                  onItemSelected(index);
                },
              );
            }),
          ),
        ),
      ),
    ),
  );
}