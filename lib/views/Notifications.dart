import 'package:en_garde/models/NotificationStored.dart';
import 'package:en_garde/models/NotificationsDatabase.dart';
import 'package:en_garde/widgets/EmptyState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class Notifications extends StatelessWidget {
  final emptyInbox = 'assets/EmptyInbox.svg';
  final throwMoney = 'assets/ThrowMoney.svg';

  @override
  Widget build(BuildContext context) {
    var platform = Theme.of(context).platform;
    return platform != TargetPlatform.iOS
        ? Consumer<List<NotificationStored>>(
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
                : EmptyState(
                    svg: emptyInbox,
                    semanticsLabel: 'No notifications',
                    title: 'You don\'t have new notifications',
                    subtitle: 'Any new notification should appear here',
                  );
          })
        : EmptyState(
            svg: throwMoney,
            semanticsLabel: 'Throw to a bin',
            heightAsset: 100,
            widthAsset: 100,
            title: 'This feature is not implemented on iOS',
            subtitle:
                'I am not gonna throw 99\$ to Apple developer program each year',
          );
  }
}
