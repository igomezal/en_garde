import 'package:en_garde/models/DatabaseService.dart';
import 'package:en_garde/models/EnGardeModel.dart';
import 'package:en_garde/models/UserFromFireStore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvailabilityWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ListTile(
            title: Text(
              'Set availability',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Consumer<EnGardeModel>(builder: (context, enGarde, child) {
            return ListTile(
              title: Text(enGarde.onDuty
                  ? 'You are on-duty'
                  : 'You are not on-duty'),
            );
          }),
          Consumer2<UserFromFireStore, EnGardeModel>(builder: (context, user, enGarde, child) {
            return SwitchListTile(
              title: const Text('Availability'),
              value: user?.availability ?? false,
              onChanged: enGarde.onDuty ? (bool availability) {
                Provider.of<DatabaseService>(context, listen: false).changeAvailability(user.id, availability);
              } : null,
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
      ),
    );
  }
}
