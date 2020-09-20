import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 255,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(Icons.fiber_new),
            trailing: Icon(Icons.delete),
            title: Text('Notification'),
          );
        });
  }
}
