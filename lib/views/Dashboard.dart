import 'package:flutter/material.dart';
import 'package:en_garde_flutter/widgets/Availability.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [AvailabilityWidget()],
    );
  }
}