import 'package:flutter/material.dart';
import 'package:transfer_app/screens/buttonWithIcon.dart';
import 'package:transfer_app/screens/currancyConverter.dart';
import 'package:transfer_app/screens/dateConverter.dart';
import 'package:transfer_app/screens/timeConverter.dart';
// import 'pacakges:instant/instant.dart';
import 'package:timezone/standalone.dart' as tz;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> setup() async {
    await tz.initializeTimeZone('data/latest_all.tzf');
    var detroit = tz.getLocation('America/Detroit');
    var now = tz.TZDateTime.now(detroit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg-2.png"),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
          gradient: LinearGradient(
            colors: [
              Color(0xffF8FFFC),
              Color(0xffF8FFFC).withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonWithIcon(() {
              setup();
              Navigator.of(context).pushNamed(DateConverter.id);
            }, Icons.date_range, 'Date Converter'),
            SizedBox(
              height: 20,
            ),
            ButtonWithIcon(() {
              Navigator.of(context).pushNamed(TimeConverter.id);
            }, Icons.timeline, 'Time Converter'),
            SizedBox(
              height: 20,
            ),
            ButtonWithIcon(() {
              Navigator.of(context).pushNamed(CurrancyConverter.id);
            }, Icons.money, 'Currency Converter'),
          ],
        ),
      ),
    );
  }
}
