import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 30),
            child: Align(
              alignment: Alignment.topLeft,
              child: Icon(Icons.settings)),
          ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/graph.png'),
            backgroundColor: Colors.yellow,
            radius: 50,
          ),
          SizedBox(height: 10),
          Text(
            'Antonio Perex',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text('134,679 XP'),
          SizedBox(height: 20),
          Container(
            width: 300,
            height: 60,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10.0,
                  offset: Offset(4.0, 4.0),
                  spreadRadius: 1.0,
                ),
              ],
            ),
            child: TabBar(
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.label,
              controller: _tabController,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.blue,
              tabs: <Widget>[Text('BADGES'), Text('FRIENDS'), Text('SCORES')],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0, right: 30, left: 30),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10.0,
                      offset: Offset(4.0, 4.0),
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                 // أو أي ارتفاع مناسب
                child: TabBarView(
                  dragStartBehavior: DragStartBehavior.down,
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(child: _buildTabViewContent()),
                    SingleChildScrollView(child: _buildTabViewContent()),
                    SingleChildScrollView(child: _buildTabViewContent()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabViewContent() {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
       
        
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/sar.png'),
            ),
            title: Text('Perfectionist'),
            subtitle: Text('Finish all lectures of a chapter'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/usa.png'),
            ),
            title: Text('Achiever'),
            subtitle: Text('Complete all excercise'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/yemen.png'),
            ),
            title: Text('Scholar'),
            subtitle: Text('Study two courses'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/sar.png'),
            ),
            title: Text('Champion'),
            subtitle: Text('Finish #1 on the score board'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/sar.png'),
            ),
            title: Text('Focused'),
            subtitle: Text('Study everyday for 30 days'),
          ),
        ],
      ),
    );
  }
}
