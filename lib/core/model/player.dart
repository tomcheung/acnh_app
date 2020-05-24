import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'player.g.dart';

@JsonSerializable()
class Player implements User {
  String playerName;
  String islandName;
  String pinCode;
  String fbToken;
  String userId;

  Player({
    this.playerName,
    this.islandName,
    this.pinCode,
    this.fbToken,
    this.userId,
  });

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}
