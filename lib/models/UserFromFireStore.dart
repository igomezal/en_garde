import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UserFromFireStore.g.dart';

@JsonSerializable()
class UserFromFireStore {
  String id;
  String notificationToken;
  String telephone;
  bool availability;

  UserFromFireStore({ this.notificationToken, this.telephone = '', this.availability});

  factory UserFromFireStore.fromJson(Map<String, dynamic> json) => _$UserFromFireStoreFromJson(json);

  Map<dynamic, dynamic> toJson() => _$UserFromFireStoreToJson(this);

  factory UserFromFireStore.fromFirestore(DocumentSnapshot documentSnapshot) {
    UserFromFireStore user = UserFromFireStore.fromJson(documentSnapshot.data());
    user.id = documentSnapshot.id;
    return user;
  }
}