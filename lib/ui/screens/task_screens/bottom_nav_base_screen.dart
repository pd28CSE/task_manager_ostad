import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './new_task_list_screen.dart';
import './progress_task_list_screen.dart';
import './cancel_task_list_screen.dart';
import './completed_task_list_screen.dart';

class BottomNavBaseScreen extends StatefulWidget {
  const BottomNavBaseScreen({super.key});

  @override
  State<BottomNavBaseScreen> createState() => _BottomNavBaseScreenState();
}

class _BottomNavBaseScreenState extends State<BottomNavBaseScreen> {
  late int _currentScreenIndex;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _currentScreenIndex = 0;
    _screens = <Widget>[
      NewTaskListScreen(onChangeScreen: changeScreen),
      const ProgressTaskListScreen(),
      const CancleTaskListScreen(),
      const CompletedTaskListScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentScreenIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.green,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (index) {
          _currentScreenIndex = index;
          setState(() {});
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.listCheck),
            label: 'New',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.circleHalfStroke),
            label: 'In Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cancel),
            label: 'Cancel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_all_outlined),
            label: 'Completed',
          ),
        ],
      ),
    );
  }

  void changeScreen(int index) {
    if (index == _currentScreenIndex) {
      return;
    }
    _currentScreenIndex = index;
    setState(() {});
  }
}
