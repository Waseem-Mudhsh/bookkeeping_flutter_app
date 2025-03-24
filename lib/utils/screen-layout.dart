import 'package:flutter/material.dart';

class ScreenLayout extends StatelessWidget {
  final Widget header;
  final Widget body;

  const ScreenLayout({super.key, required this.header, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.red,),
      extendBodyBehindAppBar: true,
      // // Header Section (App Bar, Buttons, etc.)
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          200,
        ), // Default app bar height

        child: Container(
          color: Colors.yellow,
          
          child: header),
      ),

      // Body Section (Main Content)
      body: SingleChildScrollView(
        child: SafeArea(child: body)),
    );
  }
}
