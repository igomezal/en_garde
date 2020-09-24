import 'package:flutter/material.dart';
import 'package:en_garde/widgets/Availability.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [AvailabilityWidget()],
        )
    );
  }
}