import 'package:flutter/material.dart';

class ButtonWithIcon extends StatefulWidget {
  VoidCallback onPress;
  IconData icon;
  String text;

  ButtonWithIcon(
    this.onPress,
    this.icon,
    this.text,
  );

  @override
  _ButtonWithIconState createState() => _ButtonWithIconState();
}

class _ButtonWithIconState extends State<ButtonWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // height: 170,
        width: MediaQuery.of(context).size.width - 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          //border: Border.all(width: 1),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: FlatButton(
          textColor: Colors.white,
          color: Color(0xFF2F5E4C),
          onPressed: widget.onPress,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child:
                    // Image.asset(
                    //   widget.icon,
                    //   height: 55,
                    //   fit: BoxFit.contain,
                    // ),
                    Icon(
                  widget.icon,
                  color: Color(0xFFCCC98D),
                ),
              ),
              Center(
                child: Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFCCC98D)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
