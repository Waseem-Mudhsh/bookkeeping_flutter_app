// import 'package:bookkeeping_flutter_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:bookkeeping_flutter_app/utils/screen-layout.dart';

import '../widgets/tsk-progress-card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      header: Directionality(
        textDirection: TextDirection.rtl,
        child: AppBar(
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(150),
            child: Container(
              color: const Color.fromARGB(255, 153, 10, 10),
              height: 150,
              width: MediaQuery.of(context).size.width, 
              child: TaskProgressCard(), 
             ), ),

          elevation: 0,
        
          backgroundColor: Colors.transparent,
          leading: Icon(Icons.menu),
          
         title: Text('أحمد'),
         titleTextStyle: TextStyle(color: Colors.black, fontSize: 20,
         fontWeight: FontWeight.bold,
         ),
         centerTitle: false,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Add search functionality
              },
            ),
          ],
            ),
          ),
        
      body: Container(
        color: Colors.white10,
        child: Column(
          children: [
            Container(
              color: CustomColor.kLightOrange,
              child: Text('Hello World'),
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 10,
                    
             
              itemBuilder: (context, index) {
                    
                return ListTile(
                  title: Text('Item $index'),
                  leading: Icon(Icons.list),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Add tap functionality
                  },
                );
              },
            ),
            
            _buildBottomActionsContainer(context)
          ],
        ),
      ),
    );
  }

  }
  Widget _buildBottomActionsContainer(BuildContext context) {
    return Container(
      color: CustomColor.kBackground1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('top button'),
          Container(
            color: const Color.fromARGB(255, 108, 111, 114),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Action Button 1'),
                Text('Action Button 2'),
              ],
            ),
          ),
        ],
      ),
    );
  }


class CustomColor {
  static const Color kBackground1 = Color(0XFF011C4C);
  static const Color kBackground2 = Color(0XFF03336C);
  static const Color kOrange = Color(0xFFE72225);
  static const Color kLightOrange = Color(0xFFEA6114);
  static const Color kNavyBlue = Color(0XFF112142);
}