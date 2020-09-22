import 'package:en_garde/models/DatabaseService.dart';
import 'package:en_garde/models/UserFromFireStore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:phone_number/phone_number.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  bool _notValid = false;
  Map<String, int> _allSupportedRegions;

  _changeNotValid(bool notValid) {
    setState(() {
      _notValid = notValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, int>>(
      future: PhoneNumber().allSupportedRegions(),
      builder: (context, regionMapNumbers) {
        return Consumer2<User, UserFromFireStore>(
            builder: (context, user, userFromFireStore, child) {
          return Card(
            child: Column(children: [
              const ListTile(
                title: Text(
                  'Edit your telephone number:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                title: Text(user?.displayName ?? ''),
              ),
              ListTile(
                leading: Icon(Icons.mail, color: Colors.blue),
                title: Text(user?.email ?? ''),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: FutureProvider<Map<String, dynamic>>(
                  create: (_) =>
                      PhoneNumber().parse(userFromFireStore.telephone),
                  builder: (context, child) {
                    return Consumer<Map<String, dynamic>>(
                        builder: (context, phone, child) {
                      return IntlPhoneField(
                        initialValue: phone['national_number'],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Telephone',
                          errorText: _notValid
                              ? 'Provide a valid telephone number.'
                              : null,
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
                        initialCountryCode: getRegionCode(
                            regionMapNumbers.data, phone['country_code']),
                      );
                    });
                  },
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
        });
      },
    );
  }

  String getRegionCode(Map<String, int> regionMapNumbers, String regionNumber) {
    return regionMapNumbers.keys.firstWhere(
        (k) => regionMapNumbers[k].toString() == regionNumber,
        orElse: () => null);
  }
}
