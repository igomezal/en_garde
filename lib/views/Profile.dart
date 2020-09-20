import 'package:en_garde_flutter/widgets/EditProfile.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [EditProfile()],
      ),
    );
  }
}
