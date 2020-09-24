import 'package:flutter/material.dart';

class TelephoneAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orangeAccent,
      child: ListTile(
        leading: Icon(
          Icons.priority_high,
          color: Colors.white,
        ),
        title: Text('Please set your telephone number in the profile section.', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
