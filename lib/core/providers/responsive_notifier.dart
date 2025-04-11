import 'package:bookkeeping_flutter_app/core/providers/media_query_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/responsive_values.dart';




// 📌 `Notifier` لإدارة القيم المتجاوبة
class ResponsiveNotifier extends Notifier<ResponsiveValues> {
  @override
  ResponsiveValues build() {
    // final size = MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.first).size;
    // final size = ref.watch(deviceSizeProvider);
    
    final mediaQuery = ref.watch(mediaQueryProvider);
    final size = mediaQuery.size;
    final orientation = mediaQuery.orientation;

    print('Size: ${size.width} x ${size.height}');
    print('Orientation: $orientation');
    
    
    return ResponsiveValues(
      deviceSize: size,
      orientation: orientation,
    );
  }
}
// 📌 مزود `NotifierProvider` للكائن المتجاوب
final responsiveProvider = NotifierProvider<ResponsiveNotifier, ResponsiveValues>(() => ResponsiveNotifier());
