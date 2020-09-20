import 'package:flutter/material.dart';

class EnGardeModel extends ChangeNotifier {
  bool _availability = false;
  bool _onDuty = true;

  bool get availability => _availability;
  bool get onDuty => _onDuty;

  void changeAvailability(bool availability) {
    _availability = availability;
    notifyListeners();
  }

  void changeOnDuty(bool onDuty) {
    _onDuty = onDuty;
    notifyListeners();
  }
}