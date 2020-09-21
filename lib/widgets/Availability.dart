import 'package:en_garde/models/EnGardeModel.dart';
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
          Consumer<EnGardeModel>(builder: (context, enGarde, child) {
            return SwitchListTile(
              title: const Text('Availability'),
              value: enGarde.availability,
              onChanged: enGarde.onDuty ? (bool value) {
                enGarde.changeAvailability(value);
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
