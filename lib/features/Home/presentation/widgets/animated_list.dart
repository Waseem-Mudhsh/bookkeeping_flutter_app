// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class AnimatedListDemo extends StatefulWidget {
  const AnimatedListDemo({super.key});
  static String routeName = 'misc/animated_list';

  @override
  State<AnimatedListDemo> createState() => _AnimatedListDemoState();
}

class _AnimatedListDemoState extends State<AnimatedListDemo> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final listData = [
    UserModel(0, 'Govind', 'Dixit'),
    UserModel(1, 'Greta', 'Stoll'),
    UserModel(2, 'Monty', 'Carlo'),
    UserModel(3, 'Petey', 'Cruiser'),
    UserModel(4, 'Barry', 'Cade'),
  ];
  final initialListSize = 5;

  void addUser() {
    setState(() {
      var index = listData.length;
      listData.add(UserModel(++_maxIdValue, 'New', 'Person'));
      _listKey.currentState!.insertItem(
        index,
        duration: const Duration(milliseconds: 300),
      );
    });
  }

  void deleteUser(int id) {
    setState(() {
      final index = listData.indexWhere((u) => u.id == id);
      var user = listData.removeAt(index);
      _listKey.currentState!.removeItem(index, (context, animation) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: const Interval(0.5, 1.0),
          ),
          child: SizeTransition(
            sizeFactor: CurvedAnimation(
              parent: animation,
              curve: const Interval(0.0, 1.0),
            ),
            axisAlignment: 0.0,
            child: _buildItem(user),
          ),
        );
      }, duration: const Duration(milliseconds: 600));
    });
  }

  Widget _buildItem(UserModel user) {
    return ListTile(
      key: ValueKey<UserModel>(user),
      title: Text(user.firstName),
      subtitle: Text(user.lastName),
      leading: const CircleAvatar(child: Icon(Icons.person)),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => deleteUser(user.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedList'),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: addUser),
        ],
      ),
      body: SafeArea(
        child: Column(
          
          
          children: [
           
            Expanded(
              child: AnimatedList(
                key: _listKey,
                initialItemCount: 5,
                itemBuilder: (context, index, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: _buildItem(listData[index]),
                  );
                },
              ),
            ),
            const SizedBox( height:20),
            const Text('List with staggered animations'),
            const SizedBox( height:20),
             SizedBox(
                height: 300,
                width: double.infinity,
              child: StaggeredAnimation())
          ],
        ),
      ),
    );
  }
}

class UserModel {
  UserModel(this.id, this.firstName, this.lastName);

  final int id;
  final String firstName;
  final String lastName;
}

int _maxIdValue = 4;

class StaggeredAnimation extends StatefulWidget {
  const StaggeredAnimation({super.key});

  @override
  StaggeredAnimationState createState() => StaggeredAnimationState();
}

class StaggeredAnimationState extends State<StaggeredAnimation> 
    with SingleTickerProviderStateMixin {
    
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _controller.forward();
  }
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Animation 1 - يبدأ أولاً
        SlideTransition(
          position: Tween<Offset>(
            begin: Offset(-1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(curve: Interval(0.2, 0.8),
          parent: _controller)),
          child: Container(color: Colors.red, height: 100),
        ),

        // Animation 2 - يبدأ بعد الأول
        FadeTransition(
          opacity: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
            parent: _controller,
            curve: Interval(0.3, 0.5), // من 30% إلى 80%
          )),
          child: Container(color: Colors.blue, height: 100),
        ),
        
        ElevatedButton(
          onPressed: () => _controller.reverse( ),
          child: Text('Start Animation'),
        ),
      ],
    );
  }
}