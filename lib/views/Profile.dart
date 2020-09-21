import 'package:flutter/material.dart';
import 'package:en_garde/widgets/EditProfile.dart';

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
