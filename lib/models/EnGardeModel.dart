import 'package:flutter/material.dart';

class EnGardeModel extends ChangeNotifier {
  bool _onDuty = true;
  bool get onDuty => _onDuty;

  void changeOnDuty(bool onDuty) {
    _onDuty = onDuty;
    notifyListeners();
  }
}