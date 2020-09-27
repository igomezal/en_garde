import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyState extends StatefulWidget {
  final String svg, semanticsLabel, title, subtitle;
  final double heightAsset, widthAsset;

  EmptyState({
    Key key,
    @required this.svg,
    @required this.semanticsLabel,
    this.heightAsset,
    this.widthAsset,
    @required this.title,
    @required this.subtitle,
  }) : super(key: key);

  @override
  _EmptyState createState() => _EmptyState();
}

class _EmptyState extends State<EmptyState> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Align(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          widget.svg,
          allowDrawingOutsideViewBox: true,
          semanticsLabel: widget.semanticsLabel,
          height: widget.heightAsset,
          width: widget.widthAsset,
        ),
        SizedBox(
          height: 15,
        ),
        ListTile(
            title: Center(
              child: Text(widget.title),
            ),
            subtitle: Center(
              child: Text(widget.subtitle, textAlign: TextAlign.center),
            )),
      ],
      mainAxisSize: MainAxisSize.min,
    )));
  }
}
