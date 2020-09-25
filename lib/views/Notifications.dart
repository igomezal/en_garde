import 'package:flutter/material.dart';

class Notification {
  bool read;
  String title;
  String body;
  String timestamp;

  Notification(
      {this.read = false,
      this.title = '',
      this.body = '',
      this.timestamp = '2020'});
}

class Notifications extends StatefulWidget {
  @override
  _Notifications createState() => _Notifications();
}

class _Notifications extends State<StatefulWidget> {
  final List<Notification> _listItems = [
    Notification(
        title: 'New notification',
        body:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent egestas fringilla auctor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.'),
    Notification(
        title: 'New notification',
        body:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent egestas fringilla auctor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.'),
    Notification(
        title: 'New notification',
        body:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent egestas fringilla auctor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.'),
    Notification(
        title: 'New notification',
        body:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent egestas fringilla auctor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.')
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
            itemCount: _listItems.length,
            separatorBuilder: (context, int index) => Divider(
                  height: 0.0,
                ),
            itemBuilder: (BuildContext context, int index) {
              final notification = _listItems[index];
              return Dismissible(
                key: Key(notification.hashCode.toString()),
                onDismissed: (direction) {
                  setState(() {
                    _listItems.removeAt(index);
                  });
                },
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  dense: true,
                  leading: !notification.read
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.fiber_new)])
                      : null,
                  trailing: Text(notification.timestamp),
                  title: Text(notification.title),
                  subtitle: Text(
                    notification.body,
                    textAlign: TextAlign.justify,
                  ),
                ),
                background: Container(color: Colors.red),
              );
            }));
  }
}
