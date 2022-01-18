import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:transfer_app/helper.dart';
import 'package:transfer_app/widgets/titleWidget.dart';
import 'package:intl/intl.dart';

class TimeConverter extends StatefulWidget {
  static const String id = 'Time-Converter';

  const TimeConverter({Key? key}) : super(key: key);

  @override
  _TimeConverterState createState() => _TimeConverterState();
}

class _TimeConverterState extends State<TimeConverter> {
  final convertForm = GlobalKey<FormState>();
  String? from;
  String? to;
  String? fromTime;
  String? toTime;
  TextEditingController controller = new TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool showResult = false;

  List<String> timeZoneList = [
    "Asia/Riyadh",
    "Europe/Minsk",
    "Africa/Nairobi",
    "America/New_York"
  ];

  List<dynamic> timeZoneOffsetList = [
    {
      "zone": "Asia/Riyadh",
      "offset": 3,
    },
    {
      "zone": "Europe/Minsk",
      "offset": 3,
    },
    {
      "zone": "Africa/Nairobi",
      "offset": 12,
    },
    {
      "zone": "America/New_York",
      "offset": -5,
    },
  ];

  selectTime(BuildContext context) async {
    final TimeOfDay? picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        });

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;
        var newTime = selectedTime.toString().substring(
            selectedTime.toString().indexOf("(") + 1,
            selectedTime.toString().indexOf(")"));
        controller.value = controller.value.copyWith(
          text: newTime,
          selection: TextSelection.collapsed(offset: newTime.length),
        );
      });
  }

  static bool validateTimeFormat(String value) {
    if (value == null) return false;
    //(^((1[0-2]|0?[1-9]):([0-5][0-9]) {0,12}([AaPp][Mm]))$ // 12 hours format
    String pattern = r'^((0[0-9])|1[0-9]|2[0-3]):[0-5][0-9]$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg-1.png"),
            fit: BoxFit.contain,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Column(
          children: [
            TitleWidget("Time Converter"),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg-2.png"),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  //border: Border.all(width: 1),
                  // color: Color(0xff2F5E4C),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffF8FFFC),
                      Color(0xffF8FFFC).withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Form(
                  key: convertForm,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Center(
                      //   child: Text(
                      //     'Coming Soon...',
                      //     style: TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 28,
                      //         color: Theme.of(context).primaryColor),
                      //   ),
                      // ),
                      Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('From'),
                                  Container(
                                    width: 150,
                                    decoration:
                                        Helper.fromToDecoration(context),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 7),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField(
                                        validator: (value) {
                                          if (value == null)
                                            return "Please Select From Timezone";
                                          return null;
                                        },
                                        hint: Text(
                                          "Select Timezone",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        value: this.from,
                                        dropdownColor:
                                            Theme.of(context).accentColor,
                                        items: timeZoneList.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(
                                              items,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          print(value);
                                          setState(() {
                                            this.showResult = false;
                                            this.from = value.toString();
                                          });
                                        },
                                        isExpanded: true,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    this.showResult = false;
                                    controller.clear();
                                    var temp = this.from;
                                    this.from = this.to;
                                    this.to = temp;
                                  });
                                },
                                child: Image.asset(
                                  'assets/icons/convert_icon.png',
                                  height: 30,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('To'),
                                  Container(
                                    width: 150,
                                    decoration:
                                        Helper.fromToDecoration(context),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 7),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField(
                                        validator: (value) {
                                          if (value == null)
                                            return "Please Select To Timezone";
                                          return null;
                                        },
                                        hint: Text(
                                          "Select Timezone",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        value: this.to,
                                        dropdownColor:
                                            Theme.of(context).accentColor,
                                        items: timeZoneList.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(
                                              items,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          print(value);
                                          setState(() {
                                            this.showResult = false;
                                            this.to = value.toString();
                                          });
                                        },
                                        isExpanded: true,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 300,
                            child: TextFormField(
                              controller: controller,
                              keyboardType: TextInputType.datetime,
                              validator: (value) {
                                // bool sameName = false;
                                // if (this.from == hijiri) {
                                if (!validateTimeFormat(
                                    value.toString().trim())) {
                                  return 'Please Enter Time in valid format';
                                } else
                                  return null;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                prefixIcon: IconButton(
                                  icon: Icon(
                                    Icons.timer,
                                    color: Color(0xFF2F5E4C),
                                  ),
                                  onPressed: () => {selectTime(context)},
                                ),
                                fillColor: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.3),
                                filled: true,

                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                // enabledBorder: OutlineInputBorder(
                                //     borderSide: BorderSide(
                                //         color: Color(0xFFCCC98D), width: 1.0)),
                                // focusedBorder: OutlineInputBorder(
                                //   borderSide: BorderSide(
                                //       color: Color(0xFFCCC98D), width: 3.0),
                                // ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 300,
                            height: 40,
                            child: TextButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      25,
                                    ),
                                    side: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 3,
                                    ),
                                  ),
                                ),
                                // backgroundColor: MaterialStateProperty.all(
                                //   Color(0xFF2F5E4C),
                                // ),
                              ),
                              onPressed: () {
                                if (convertForm.currentState!.validate()) {
                                  try {
                                    var time = controller.value.text
                                        .toString()
                                        .trim()
                                        .toLowerCase();
                                    if (time.contains('m')) {
                                    } else {
                                      var timeList = time.split(":");
                                      var hour = timeList[0];
                                      var min = timeList[1];
                                      var fromTime = DateTime(2000, 1, 1,
                                          int.parse(hour), int.parse(min));

                                      // var timeOfDay = TimeOfDay(
                                      //     hour: int.parse(hour),
                                      //     minute: int.parse(min));

                                      var fromOffset = timeZoneOffsetList
                                          .firstWhere((element) =>
                                              element["zone"] ==
                                              this.from)["offset"];
                                      var toOffset = timeZoneOffsetList
                                          .firstWhere((element) =>
                                              element["zone"] ==
                                              this.to)["offset"];
                                      var toTime = fromTime.add(Duration(
                                        hours: fromOffset +
                                            toOffset +
                                            int.parse(hour),
                                        minutes: 0,
                                      ));
                                      this.toTime = DateFormat('kk:mm:a')
                                          .format(toTime)
                                          .toString();
                                      this.fromTime = DateFormat('kk:mm:a')
                                          .format(fromTime)
                                          .toString();

                                      // var newHour = fromOffset +
                                      //     toOffset +
                                      //     int.parse(hour);
                                      // print(fromOffset);
                                      // print(toOffset);
                                      // print(newHour);
                                      // print(fromTime.toString());
                                    }
                                    //     .split('-');
                                    // var toDate;
                                    // var year = date[0];
                                    // var month = date[1];
                                    // var day = date[2];

                                    //     if (this.from == hijiri) {
                                    //       toDate = DateFormat('yyyy-MM-dd')
                                    //           .format(
                                    //               HijriCalendar().hijriToGregorian(
                                    //             int.parse(year),
                                    //             int.parse(month),
                                    //             int.parse(day),
                                    //           ))
                                    //           .toString();
                                    //     } else {
                                    //       var date = HijriCalendar.fromDate(
                                    //         DateTime(
                                    //           int.parse(year),
                                    //           int.parse(month),
                                    //           int.parse(day),
                                    //         ),
                                    //       );
                                    //       toDate = date.hYear.toString() +
                                    //           "-" +
                                    //           date.hMonth.toString() +
                                    //           "-" +
                                    //           date.hDay.toString();
                                    //     }
                                    setState(() {
                                      this.showResult = true;
                                      // this.fromDate =
                                      //     year + "-" + month + "-" + day;
                                      // this.toDate = toDate;
                                    });
                                  } catch (e) {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: Text('An error occurred!'),
                                        content: Text(e.toString()),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Text(
                                'Convert',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: showResult,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              this.from.toString() + " Timezone:",
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Color(0xFF2F5E4C),
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  this.fromTime.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFFCCC98D),
                                  ),
                                )),
                            Text(
                              this.to.toString() + " Timezone:",
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Color(0xFF2F5E4C),
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  this.toTime.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFFCCC98D),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
