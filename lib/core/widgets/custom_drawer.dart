// import 'package:bookkeeping_flutter_app/utils/add_text_style.dart';
import 'package:flutter/material.dart';

import 'theme_switcher.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Drawer(
      backgroundColor: colorScheme.primary,
      
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: colorScheme.secondary,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'القائمة الجانبية',
                 style: TextStyle(
                   color: colorScheme.onSecondary,
                 ),
                  
                ),
                Spacer(),
                ThemeSwitcher(),
              ],
            ),
          ),
          ListTile(
            iconColor: colorScheme.onPrimary,
            textColor: colorScheme.onPrimary,
            leading: Icon(Icons.home,),
            title: Text('الرئيسية',
            ),
            onTap: () {
              // إغلاق الـ Drawer والانتقال إلى الشاشة الرئيسية
              Navigator.pop(context);
            },
          ),
          ListTile(
            iconColor: colorScheme.onPrimary,
            textColor: colorScheme.onPrimary,
            leading: Icon(Icons.settings),
            title: Text('الإعدادات'),
            onTap: () {
              // إغلاق الـ Drawer والانتقال إلى شاشة الإعدادات
              Navigator.pop(context);
            },
          ),
          ListTile(
            iconColor: colorScheme.onPrimary,
            textColor: colorScheme.onPrimary,
            
            
            leading: Icon(Icons.help),
            title: Text('المساعدة'),
            onTap: () {
              // إغلاق الـ Drawer والانتقال إلى شاشة المساعدة
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}