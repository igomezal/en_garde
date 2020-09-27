import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:en_garde/models/NotificationStored.dart';

class NotificationsDatabase {
  static final NotificationsDatabase _singleton = NotificationsDatabase._internal();

  NotificationsDatabase._internal() {
    _initializeNotificationsDatabase();
  }

  factory NotificationsDatabase() {
    return _singleton;
  }

  final _notificationsController = StreamController<List<NotificationStored>>.broadcast();
  StreamSink<List<NotificationStored>> get _inNotifications => _notificationsController.sink;
  Stream<List<NotificationStored>> get notifications => _notificationsController.stream;

  Future<Database> _database;

  void _initializeNotificationsDatabase() async {
    _database = openDatabase(
      join(await getDatabasesPath(), 'notifications_database.db'),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE notifications(id INTEGER PRIMARY KEY, title TEXT, body TEXT, timestamp TEXT)");
      },
      version: 1,
    );

    getNotifications();
  }

  void addNotification(NotificationStored notification) async {
    final Database db = await _database;
    await db.insert('notifications', notification.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

    getNotifications();
  }

  void deleteNotification(int id) async {
    final Database db = await _database;
    await db.delete('notifications', where: 'id = ?', whereArgs: [id]);

    getNotifications();
  }

  void clearNotifications() async {
    final Database db = await _database;
    db.delete('notifications');

    getNotifications();
  }

  void getNotifications() async {
    // Get a reference to the database.
    final Database db = await _database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('notifications');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    List<NotificationStored> notifications = List.generate(maps.length, (i) {
      return NotificationStored(
        id: maps[i]['id'],
        title: maps[i]['title'],
        body: maps[i]['body'],
        timestamp: maps[i]['timestamp'],
      );
    });

    _inNotifications.add(notifications);
  }

  void closeStream() {
    _notificationsController.close();
  }
}