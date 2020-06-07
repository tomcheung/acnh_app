// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) {
  return Player(
    playerName: json['playerName'] as String,
    islandName: json['islandName'] as String,
    pinCode: json['pinCode'] as String,
    fbToken: json['fbToken'] as String,
    userId: json['userId'] as String,
    friendCode: json['friendCode'] as String,
  );
}

Map<String, dynamic> _$PlayerToJson(Player instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('playerName', instance.playerName);
  writeNotNull('islandName', instance.islandName);
  writeNotNull('pinCode', instance.pinCode);
  writeNotNull('fbToken', instance.fbToken);
  writeNotNull('userId', instance.userId);
  writeNotNull('friendCode', instance.friendCode);
  return val;
}
