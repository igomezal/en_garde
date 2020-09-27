import 'package:en_garde/models/NotificationStored.dart';
import 'package:en_garde/models/NotificationsDatabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class Notifications extends StatelessWidget {
  final emptyInbox = 'assets/EmptyInbox.svg';

  @override
  Widget build(BuildContext context) {
    return Consumer<List<NotificationStored>>(
        builder: (context, notifications, child) {
      final List<NotificationStored> notificationsReversed =
          notifications.reversed.toList();
      return notifications.length > 0
          ? Expanded(
              child: ListView.separated(
                  itemCount: notificationsReversed.length,
                  separatorBuilder: (context, int index) => Divider(
                        height: 0.0,
                      ),
                  itemBuilder: (BuildContext context, int index) {
                    final notification = notificationsReversed[index];
                    return Dismissible(
                      key: Key(notification.hashCode.toString()),
                      onDismissed: (direction) {
                        NotificationsDatabase()
                            .deleteNotification(notification.id);
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10),
                        trailing: Text(timeago.format(
                            DateTime.fromMillisecondsSinceEpoch(
                                int.parse(notification.timestamp)))),
                        title: Text(notification.title),
                        subtitle: Text(
                          notification.body,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      background: Container(
                          padding: EdgeInsets.all(10),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Delete',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ))),
                          color: Colors.red),
                      secondaryBackground: Container(
                          padding: EdgeInsets.all(10),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text('Delete',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ))),
                          color: Colors.red),
                    );
                  }))
          : Expanded(
              child: Align(
                  child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  emptyInbox,
                  allowDrawingOutsideViewBox: true,
                  semanticsLabel: 'No notifications',
                ),
                SizedBox(
                  height: 15,
                ),
                ListTile(
                    title: Center(
                      child: Text('You don\'t have new notifications'),
                    ),
                    subtitle: Center(
                      child: Text('Any new notification should appear here'),
                    )),
              ],
              mainAxisSize: MainAxisSize.min,
            )));
    });
  }
}
