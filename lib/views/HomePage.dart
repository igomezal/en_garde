import 'dart:collection';
import 'package:en_garde/models/DatabaseService.dart';
import 'package:en_garde/models/UserFromFireStore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:en_garde/views/Dashboard.dart';
import 'package:en_garde/views/Profile.dart';
import 'package:en_garde/views/Notifications.dart';
import 'package:en_garde/icons/en_garde_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.analytics, this.observer})
      : super(key: key);
  final String title;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _HomePageState createState() => _HomePageState(analytics, observer);
}

class _HomePageState extends State<HomePage> {
  _HomePageState(this.analytics, this.observer);

  final FirebaseAuth auth = FirebaseAuth.instance;
  final db = DatabaseService();
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  final UnmodifiableListView<String> _sectionsApp =
      UnmodifiableListView(['Dashboard', 'Profile', 'Notifications']);
  final int _notificationIndex = 2;
  final List<Widget> _notificationActions = [
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

  int _selectedIndex = 0;
  List<Widget> _actions = [];
  User _authenticated = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    applicationOpened();
    auth.authStateChanges().listen((user) {
      if (user == null) {
        print('No user authenticated');
        setState(() {
          _authenticated = null;
        });
      } else {
        print('User authenticated');
        setState(() {
          _authenticated = user;
        });
      }
    });
    super.initState();
  }

  void applicationOpened() async {
    try {
      await analytics.logAppOpen();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: _actions,
      ),
      body: SafeArea(
        child: _authenticated != null
            ? StreamProvider<UserFromFireStore>(
                create: (_) => Provider.of<DatabaseService>(context, listen: false).streamUser(_authenticated.uid),
                child: IndexedStack(
                  index: _selectedIndex,
                  children: [
                    Dashboard(),
                    Profile(),
                    Notifications(),
                  ],
                ),
              )
            : AuthPage(),
      ),
      bottomNavigationBar: _authenticated != null
          ? BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), title: Text(_sectionsApp[0])),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    title: Text(_sectionsApp[1])),
                BottomNavigationBarItem(
                    icon: Icon(Icons.notifications),
                    title: Text(_sectionsApp[2]))
              ],
              currentIndex: _selectedIndex,
              onTap: (int index) async {
                if (_selectedIndex != index) {
                  _onItemTapped(index);
                  try {
                    await analytics.setCurrentScreen(
                        screenName: _sectionsApp[index]);
                  } catch (e) {
                    print(e);
                  }
                }
              },
            )
          : null,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == _notificationIndex) {
        _actions = _notificationActions;
      } else {
        _actions = [];
      }
    });
  }
}

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: RaisedButton.icon(
      color: Colors.blue,
      textColor: Colors.white,
      icon: Icon(EnGarde.google),
      label: const Text('SIGN IN WITH GOOGLE'),
      onPressed: signInWithGoogle,
    ));
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
