import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
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
      home: MyHomePage(title: 'Dashboard'),
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Dashboard(),
          Text('Page 2'),
          Text('Page 3'),
        ],
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

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [AvailabilityWidget()],
    );
  }
}

class AvailabilityWidget extends StatefulWidget {
  @override
  _AvailabilityState createState() => _AvailabilityState();
}

class _AvailabilityState extends State<AvailabilityWidget> {
  bool _availabilityStatus = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ListTile(
            title: Text('Set availability'),
            subtitle: Text('You are not on-duty'),
          ),
          SwitchListTile(
            title: const Text('Availability'),
            value: _availabilityStatus,
            onChanged: _onAvailabilityChanged,
          ),
          ExpansionTile(
            title: Text('Hint'),
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: const Text(
                    'You can change your availability when you are on duty, this way when there is an incoming call whoever is available at that moment will have more priority (to receive the call) than someone who is not available.',
                    textAlign: TextAlign.justify,
                  ))
            ],
          )
        ],
      ),
    );
  }

  _onAvailabilityChanged(bool value) {
    setState(() {
      _availabilityStatus = value;
    });
  }
}
