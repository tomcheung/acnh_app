import 'package:flutter/foundation.dart';

class ProfilePageState extends ChangeNotifier {
  bool _isEdit = false;

  bool get isEdit => _isEdit;

  String playerName;
  String islandName;

  ProfilePageState({
    this.playerName = '',
    this.islandName = '',
  });

  void toggleEditMode() {
    _isEdit = !_isEdit;
    notifyListeners();
  }
}
