import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatefulWidget {
  String title;

  TitleWidget(
    this.title,
  );
  @override
  _TitleWidgetState createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 70),
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 32,
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}
