import 'package:cloud_firestore/cloud_firestore.dart';

import 'UserFromFireStore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final DatabaseService _service = DatabaseService._internal();

  Stream<UserFromFireStore> streamUser(String id) {
    return _db
        .doc('users/$id')
        .snapshots()
        .map((snap) => UserFromFireStore.fromFirestore(snap));
  }

  void changeAvailability(String id, bool availability) {
    _db.doc('users/$id').update({'availability': availability});
  }

  factory DatabaseService() {
    return _service;
  }

  DatabaseService._internal();
}
