import 'package:flutter/material.dart';

class EnGardeModel extends ChangeNotifier {
  bool _onDuty = true;
  bool _availability = false;

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