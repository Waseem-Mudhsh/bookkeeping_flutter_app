import 'package:bookkeeping_flutter_app/core/app_scaffold/app_scroll_view.dart';
import 'package:flutter/material.dart';

/// واجهة لإنشاء الصفحات بطريقة موحدة
class PageBuilder {
  static Widget build( {
    
    required List<Widget> slivers,
    Widget? floatingActionButton,
    Widget? drawer,
    
  }) {
    return AppScrollView(
      slivers: [
        
        ...slivers,
      ],
      floatingActionButton: floatingActionButton,
      drawer: drawer,
      
    );
  }
}