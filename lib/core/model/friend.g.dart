// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Friend _$FriendFromJson(Map<String, dynamic> json) {
  return Friend(
    playerName: json['playerName'] as String,
    islandName: json['islandName'] as String,
    pinCode: json['pinCode'] as String,
    userId: json['userId'] as String,
  );
}

Map<String, dynamic> _$FriendToJson(Friend instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('playerName', instance.playerName);
  writeNotNull('islandName', instance.islandName);
  writeNotNull('pinCode', instance.pinCode);
  writeNotNull('userId', instance.userId);
  return val;
}
