import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:phone_number/phone_number.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  bool _notValid = false;

  _changeNotValid(bool notValid) {
    setState(() {
      _notValid = notValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        const ListTile(
          title: Text(
            'Edit your telephone number:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const ListTile(
          leading: Icon(
            Icons.person,
            color: Colors.blue,
          ),
          title: Text('Iván Gómez Alonso'),
        ),
        const ListTile(
          leading: Icon(Icons.mail, color: Colors.blue),
          title: Text('yvangomezalonso@gmail.com'),
        ),
        Container(
          padding: EdgeInsets.all(8),
          child: IntlPhoneField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Telephone',
              errorText: _notValid ? 'Provide a valid telephone number.' : null,
            ),
            onChanged: (telephone) async {
              _notValid = true;
              try {
                await PhoneNumber().parse(telephone.completeNumber);
                _changeNotValid(false);
              } on PlatformException catch (e) {
                _changeNotValid(true);
                print(e);
              }
              print(telephone.completeNumber);
            },
            initialCountryCode: 'ES',
          ),
        ),
        ButtonBar(
          children: [
            OutlineButton(
              color: Colors.black,
              textColor: Colors.black,
              child: const Text('RESET'),
              onPressed: () {},
            ),
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text('SUBMIT'),
              onPressed: () {},
            )
          ],
        )
      ]),
    );
  }
}
