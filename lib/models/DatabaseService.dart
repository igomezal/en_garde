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

  Stream<Map<String, List<String>>> streamOnDuty() {
    return _db.collection('dutyDays').snapshots().map((collection) {
      Map<String, List<String>> myMap = Map<String, List<String>>();
      collection.docs.forEach((element) {
        myMap.putIfAbsent(
            element.id, () => convertTest(element.data()['users'] ?? []));
      });
      return myMap;
    });
  }

  List<String> convertTest(List users) {
    return users.map((user) => user.toString()).toList();
  }

  void changeAvailability(String id, bool availability) {
    _db.doc('users/$id').update({'availability': availability});
  }

  void changeTelephone(String id, String telephone) {
    _db.doc('users/$id').update({'telephone': telephone});
  }

  factory DatabaseService() {
    return _service;
  }

  DatabaseService._internal();
}
