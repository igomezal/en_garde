import 'package:en_garde/models/DatabaseService.dart';
import 'package:en_garde/models/UserFromFireStore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AvailabilityWidget extends StatefulWidget {
  @override
  _AvailabilityWidget createState() => _AvailabilityWidget();
}

class _AvailabilityWidget extends State<AvailabilityWidget> {
  List<String> todayOnDuty;

  @override
  void initState() {
    super.initState();
    Provider.of<DatabaseService>(context, listen: false)
        .streamOnDuty()
        .listen((onDutyDays) {
      var now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd');
      var formattedDate = formatter.format(now);
      if (onDutyDays.containsKey(formattedDate)) {
        setState(() {
          todayOnDuty = onDutyDays[formattedDate];
        });
      } else {
        setState(() {
          todayOnDuty = [];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Consumer<User>(builder: (context, user, child) {
        var onDuty = todayOnDuty?.contains(user.uid) ?? false;
        return Column(
          children: [
            const ListTile(
              title: Text(
                'Set availability',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: Text(onDuty ? 'You are on-duty' : 'You are not on-duty'),
            ),
            Consumer<UserFromFireStore>(
                builder: (context, user, child) {
                  return SwitchListTile(
                    title: const Text('Availability'),
                    value: user?.availability ?? false,
                    onChanged:
                    (user?.telephone?.isNotEmpty ?? false) && onDuty
                        ? (bool availability) {
                      Provider.of<DatabaseService>(context, listen: false)
                          .changeAvailability(user.id, availability);
                    }
                        : null,
                  );
                }),
            ExpansionTile(
              title: const Text('Hint'),
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: const Text(
                      'You can change your availability when you are on duty, this way when there is an incoming call whoever is available at that moment will have more priority (to receive the call) than someone who is not available.',
                      textAlign: TextAlign.justify,
                    ))
              ],
            )
          ],
        );
      }));
  }
}
