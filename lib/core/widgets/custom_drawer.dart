// import 'package:bookkeeping_flutter_app/utils/add_text_style.dart';

import 'package:flutter/material.dart';

import 'theme_switcher.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    
    
    return Drawer(
      // width: responsive.deviceSize.width * 0.50,
      // backgroundColor: theme.colorScheme.surface,
      
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            // decoration: BoxDecoration(
            //   color: theme.colorScheme.secondary,
            // ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
            
              children: [
                Text(
                 'القائمة الجانبية',
                //  style: TextStyle(
                //    color: theme.colorScheme.onSecondary,
                //  ),
                  
                ),
                
                ThemeSwitcher(),
              ],
            ),
          ),
          ListTile(
            // iconColor: theme.colorScheme.onSurface,
            // textColor: theme.colorScheme.onSurface,
            leading: Icon(Icons.home,),
            title: Text('الرئيسية',
            ),
            onTap: () {
              // إغلاق الـ Drawer والانتقال إلى الشاشة الرئيسية
              Navigator.pop(context);
            },
          ),
          ListTile(
            // iconColor: theme.colorScheme.onSurface,
            // textColor: theme.colorScheme.onSurface,
            leading: Icon(Icons.settings),
            title: Text('الإعدادات'),
            onTap: () {
              // إغلاق الـ Drawer والانتقال إلى شاشة الإعدادات
              Navigator.pop(context);
            },
          ),
          ListTile(
            // iconColor: theme.colorScheme.onSurface,
            // textColor: theme.colorScheme.onSurface,
            
            
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