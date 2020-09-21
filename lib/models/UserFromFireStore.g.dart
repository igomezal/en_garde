// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserFromFireStore.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFromFireStore _$UserFromFireStoreFromJson(Map<String, dynamic> json) {
  return UserFromFireStore(
    notificationToken: json['notificationToken'] as String,
    telephone: json['telephone'] as String,
    availability: json['availability'] as bool,
  )..id = json['id'] as String;
}

Map<String, dynamic> _$UserFromFireStoreToJson(UserFromFireStore instance) =>
    <String, dynamic>{
      'id': instance.id,
      'notificationToken': instance.notificationToken,
      'telephone': instance.telephone,
      'availability': instance.availability,
    };
