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
  String _telephone = '';

  @override
  initState() {
    super.initState();
    _telephone = Provider.of<UserFromFireStore>(context, listen: false).telephone;
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
                          print(phone);
                      return IntlPhoneField(
                        initialValue: phone != null ? phone['national_number'] : '',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Telephone',
                          errorText: _notValid
                              ? 'Provide a valid telephone number.'
                              : null,
                        ),
                        onChanged: (telephone) async {
                          _telephone = telephone.completeNumber;
                          try {
                            await PhoneNumber().parse(telephone.completeNumber);
                            _changeNotValid(false);
                          } on PlatformException catch (e) {
                            _changeNotValid(true);
                            print(e);
                          }
                        },
                        onSubmitted: (_) {
                          _submitTelephone(user.uid, _telephone);
                        },
                        initialCountryCode: getRegionCode(
                            regionMapNumbers.data, phone != null ? phone['country_code'] : '34'),
                      );
                    });
                  },
                ),
              ),
              ButtonBar(
                children: [
                  RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: const Text('SUBMIT'),
                    onPressed: () {
                      _submitTelephone(user.uid, _telephone);
                    },
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

  void _changeNotValid(bool notValid) {
    setState(() {
      _notValid = notValid;
    });
  }

  void _submitTelephone(String userId, String telephone) {
    if(!_notValid) {
      Provider.of<DatabaseService>(context, listen: false).changeTelephone(userId, telephone);
      FocusScope.of(context).unfocus();

      final snackBar = SnackBar(content: Text('Telephone updated correctly!'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
}
