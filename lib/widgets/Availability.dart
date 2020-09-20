import 'package:flutter/material.dart';

class AvailabilityWidget extends StatefulWidget {
  @override
  _AvailabilityState createState() => _AvailabilityState();
}

class _AvailabilityState extends State<AvailabilityWidget> {
  bool _availabilityStatus = false;

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
          const ListTile(
            title: Text('You are not on-duty'),
          ),
          SwitchListTile(
            title: const Text('Availability'),
            value: _availabilityStatus,
            onChanged: _onAvailabilityChanged,
          ),
          ExpansionTile(
            title: Text('Hint'),
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

  _onAvailabilityChanged(bool value) {
    setState(() {
      _availabilityStatus = value;
    });
  }
}
