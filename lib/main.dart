import 'package:en_garde/models/EnGardeModel.dart';
import 'package:flutter/material.dart';
import 'package:en_garde/views/Dashboard.dart';
import 'package:en_garde/views/Profile.dart';
import 'package:en_garde/views/Notifications.dart';
import 'package:provider/provider.dart';

import 'icons/en_garde_icons.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => EnGardeModel()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'En Garde!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'En Garde!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  List<Widget> _actions = [];
  static const int _notificationIndex = 2;
  List<Widget> _notificationActions = [
    IconButton(
      icon: Icon(EnGarde.mail_read),
      tooltip: 'Mark all notifications as read',
      onPressed: () {},
    ),
    IconButton(
      icon: Icon(Icons.clear_all),
      tooltip: 'Clear all notifications',
      onPressed: () {},
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(index == _notificationIndex) {
        _actions = _notificationActions;
      } else {
        _actions = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: _actions,
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            Dashboard(),
            Profile(),
            Notifications(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text('Dashboard')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text('Profile')),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), title: Text('Notifications'))
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
