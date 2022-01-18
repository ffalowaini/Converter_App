import 'package:flutter/material.dart';

class Helper extends StatelessWidget {
  const Helper({Key? key}) : super(key: key);

  static BoxDecoration fromToDecoration(ctx) {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      // border: Border.all(width: 1, color: Color(0xFFCCC98D)),
      color: Theme.of(ctx).accentColor.withOpacity(0.3),
      // boxShadow: [
      //   BoxShadow(
      //     color: Colors.grey.withOpacity(0.5),
      //     spreadRadius: 1,
      //     blurRadius: 7,
      //     offset: Offset(0, 1), // changes position of shadow
      //   ),
      // ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
