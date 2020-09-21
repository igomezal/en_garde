import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('En Garde!'),
        ),
        body: Center(
          child: Text('Loading...'),
        ));
  }
}

class Error extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('En Garde!'),
        ),
        body: Center(
          child: Text('Error!'),
        ));
  }
}