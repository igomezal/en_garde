import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UserFromFireStore.g.dart';

@JsonSerializable()
class UserFromFireStore {
  String id;
  String _notificationToken;
  String _telephone;
  bool _availability;

  UserFromFireStore({ String notificationToken = '', String telephone = '', bool availability = false }) {
    _notificationToken = notificationToken;
    _telephone = telephone;
    _availability = availability;
  }

  String get notificationToken {
    return _notificationToken ?? '';
  }

  set notificationToken(String value) {
    _notificationToken = value;
  }

  String get telephone {
    return _telephone ?? '';
  }

  set telephone(String value) {
    _telephone = value;
  }

  bool get availability {
    return _availability ?? false;
  }

  set availability(bool value) {
    _availability = value;
  }

  factory UserFromFireStore.fromJson(Map<String, dynamic> json) => _$UserFromFireStoreFromJson(json);

  Map<dynamic, dynamic> toJson() => _$UserFromFireStoreToJson(this);

  factory UserFromFireStore.fromFirestore(DocumentSnapshot documentSnapshot) {
    UserFromFireStore user = UserFromFireStore.fromJson(documentSnapshot.data());
    user.id = documentSnapshot.id;
    return user;
  }
}