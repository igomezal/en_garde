import 'package:en_garde/models/DatabaseService.dart';
import 'package:en_garde/models/EnGardeModel.dart';
import 'package:en_garde/models/NotificationStored.dart';
import 'package:en_garde/models/NotificationsDatabase.dart';
import 'package:en_garde/views/BasicStates.dart';
import 'package:en_garde/views/HomePage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => EnGardeModel()),
      StreamProvider<User>(
          create: (_) => FirebaseAuth.instance.authStateChanges()),
      StreamProvider<List<NotificationStored>>(
          create: (_) => NotificationsDatabase().notifications, initialData: []),
      Provider(create: (_) => DatabaseService()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  void dispose() {
    NotificationsDatabase().closeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          return MaterialApp(
            title: 'En Garde!',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            navigatorObservers: [observer],
            home: snapshot.hasError
                ? Error()
                : snapshot.connectionState == ConnectionState.done
                    ? HomePage(
                        title: 'En Garde!',
                        analytics: analytics,
                        observer: observer,
                      )
                    : Loading(),
          );
        });
  }
}
