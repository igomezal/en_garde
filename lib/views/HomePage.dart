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
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      var test = await Firebase.initializeApp();
      await analytics.logAppOpen();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return Error();
    }

    if (!_initialized) {
      return Loading();
    }

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
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text(_sectionsApp[0])),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text(_sectionsApp[1])),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), title: Text(_sectionsApp[2]))
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) async {
          _onItemTapped(index);
          try {
            await analytics.setCurrentScreen(screenName: _sectionsApp[index]);
          } catch (e) {
            print(e);
          }
        },
      ),
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

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('En Garde!'),
        ),
        body: Center(
          child: Text('Loading...'),
        ));
  }
}

class Error extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('En Garde!'),
        ),
        body: Center(
          child: Text('Error!'),
        ));
  }
}
