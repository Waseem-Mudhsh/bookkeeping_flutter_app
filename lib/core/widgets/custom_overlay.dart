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
//   void showConfirmationDialog({
//   required BuildContext context,
//   required String title,
//   required Widget content,
//   required VoidCallback onConfirm,
// }) {
//   CustomOverlay.show(
//     context: context,
//     child: Container(
//       width: MediaQuery.of(context).size.width * 0.8,
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           SizedBox(height: 16),
//           content,
//           SizedBox(height: 24),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               TextButton(
//                 onPressed: () {
//                   CustomOverlay.dismiss();
//                 },
//                 child: Text('إلغاء'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   CustomOverlay.dismiss();
//                   onConfirm();
//                 },
//                 child: Text('تأكيد'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }
void showConfirmationDialog({
  required BuildContext context,
  required String title,
  required Widget content,
  required VoidCallback onConfirm,
}) {
  final overlayState = Overlay.of(context, rootOverlay: true);
  final navigator = Navigator.of(context, rootNavigator: true);
  OverlayEntry? overlayEntry;

   overlayEntry = OverlayEntry(
    builder: (context) => Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () => overlayEntry?.remove(),
            child: Container(color: Colors.black54),
          ),
        ),
        Center(
          child: Material(
            color: Colors.transparent,
            child: IntrinsicWidth(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                ),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(title, 
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 16),
                      // استخدم Builder هنا لضمان وجود context صحيح للDropdown
                      Builder(
                        builder: (innerContext) => content,
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () => overlayEntry?.remove(),
                            child: Text('إلغاء'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              overlayEntry?.remove();
                              onConfirm();
                            },
                            child: Text('تأكيد'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  overlayState.insert(overlayEntry);
}

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