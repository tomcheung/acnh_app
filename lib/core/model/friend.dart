import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'friend.g.dart';

@JsonSerializable()
class Friend implements User {
  String playerName;
  String islandName;
  String pinCode;
  String userId;

  Friend({
    this.playerName,
    this.islandName,
    this.pinCode,
    this.userId,
  });

  factory Friend.fromJson(Map<String, dynamic> json) => _$FriendFromJson(json);

  Map<String, dynamic> toJson() => _$FriendToJson(this);
}
