import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hijri/hijri_calendar.dart';
// import 'package:hijri/umm_alqura_calendar.dart';
import 'package:hijri_picker/hijri_picker.dart';
import 'package:transfer_app/helper.dart';
import 'package:transfer_app/widgets/titleWidget.dart';

// import 'package:hijri/digits_converter.dart';
// import 'package:hijri/hijri_array.dart';
// import 'package:hijri/hijri_calendar.dart';
class DateConverter extends StatefulWidget {
  static const String id = 'DateConverter';
  // const DateConverter({Key? key}) : super(key: key);

  @override
  _DateConverterState createState() => _DateConverterState();
}

class _DateConverterState extends State<DateConverter> {
  DateTime selectedDate = DateTime.now();
  var selectedDateHijri = new HijriCalendar.now();
  final String hijiri = 'Hijri Date';
  final String gregorian = 'Gregorian Date';
  final convertForm = GlobalKey<FormState>();

  String? from;
  String? to;
  String? fromDate;
  String? toDate;
  bool showResult = false;

  TextEditingController controller = new TextEditingController();

  initState() {
    this.from = hijiri;
    this.to = gregorian;
    super.initState();
    setState(() {});
  }

  selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary:
                  Theme.of(context).primaryColor, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Theme.of(context).accentColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(0),
      lastDate: DateTime(4000),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var dateStr = DateFormat('yyyy-MM-dd').format(selectedDate).toString();
        controller.value = controller.value.copyWith(
          text: dateStr,
          selection: TextSelection.collapsed(offset: dateStr.length),
        );
      });
  }

  selectDateHijri(BuildContext context) async {
    final HijriCalendar? picked = await showHijriDatePicker(
      context: context,
      initialDate: selectedDateHijri,
      lastDate: new HijriCalendar()
        ..hYear = 1500
        ..hMonth = 9
        ..hDay = 25,
      firstDate: new HijriCalendar()
        ..hYear = 1357
        ..hMonth = 12
        ..hDay = 25,
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked != null)
      setState(() {
        selectedDateHijri = picked;
        var dateStr = selectedDateHijri.hYear.toString() +
            "-" +
            selectedDateHijri.hMonth.toString() +
            "-" +
            selectedDateHijri.hDay.toString();
        // var dateStr = DateFormat('yyyy-MM-dd').format(selectedDate).toString();
        controller.value = controller.value.copyWith(
          text: dateStr,
          selection: TextSelection.collapsed(offset: dateStr.length),
        );
      });
  }

  static bool validateHijriRange(String value) {
    if (value == null) return false;
    String pattern =
        r'\b((([1]+[3]+[\d]{2})|([1]+[4]+[\d]{2})|([1]+[5]+[00]{2}))-(\b([1-9]|1[0-2])\b))-(\b([1-9]|[12][0-9]|3[01])\b)\b';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static bool validateGregorianRange(String value) {
    if (value == null) return false;
    String pattern =
        r'\b((([1]+[9]+[\d]{2})|([20]+[\d]{2}))-(\b([1-9]|1[0-2])\b))-(\b([1-9]|[12][0-9]|3[01])\b)\b';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg-1.png"),
            fit: BoxFit.contain,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Column(
          children: [
            TitleWidget("Date Converter"),
            Expanded(
              child: Container(
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
                                    height: 40,
                                    child: Center(
                                        child: Text(this.from.toString())),
                                    decoration:
                                        Helper.fromToDecoration(context),
                                  ),
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
                                    height: 40,
                                    child:
                                        Center(child: Text(this.to.toString())),
                                    decoration:
                                        Helper.fromToDecoration(context),
                                  ),
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
                                bool sameName = false;
                                if (this.from == hijiri) {
                                  if (!validateHijriRange(value.toString())) {
                                    return 'Please Enter Date in valid format & valid range';
                                  } else
                                    return null;
                                } else {
                                  if (!validateGregorianRange(
                                      value.toString())) {
                                    return 'Please Enter Date in valid format & valid range';
                                  } else
                                    return null;
                                }
                                // if (value.toLowerCase() != oldName.toLowerCase()) {
                                //   foodItems.forEach((element) {
                                //     if (element.name.toLowerCase() ==
                                //         value.toLowerCase()) {
                                //       sameName = true;
                                //     }
                                //   });
                                // }
                                // if (value == null) {
                                //   setState(() {
                                //     validName = false;
                                //   });
                                //   return 'please enter a valid name.';
                                // } else if (sameName) {
                                //   setState(() {
                                //     validName = false;
                                //   });
                                //   return 'please enter a new name, this item already exist.';
                                // }
                                // setState(() {
                                //   validName = true;
                                // });
                                // return null;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                prefixIcon: IconButton(
                                  icon: Icon(
                                    Icons.calendar_today,
                                    color: Color(0xFF2F5E4C),
                                  ),
                                  onPressed: () => {
                                    if (this.from == hijiri)
                                      selectDateHijri(context)
                                    else
                                      selectDate(context)
                                  },
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
                                    var date = controller.value.text
                                        .toString()
                                        .trim()
                                        .split('-');
                                    var toDate;
                                    var year = date[0];
                                    var month = date[1];
                                    var day = date[2];

                                    if (this.from == hijiri) {
                                      toDate = DateFormat('yyyy-MM-dd')
                                          .format(
                                              HijriCalendar().hijriToGregorian(
                                            int.parse(year),
                                            int.parse(month),
                                            int.parse(day),
                                          ))
                                          .toString();
                                    } else {
                                      var date = HijriCalendar.fromDate(
                                        DateTime(
                                          int.parse(year),
                                          int.parse(month),
                                          int.parse(day),
                                        ),
                                      );
                                      toDate = date.hYear.toString() +
                                          "-" +
                                          date.hMonth.toString() +
                                          "-" +
                                          date.hDay.toString();
                                    }
                                    setState(() {
                                      this.showResult = true;
                                      this.fromDate =
                                          year + "-" + month + "-" + day;
                                      this.toDate = toDate;
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
                                  fontWeight: FontWeight.w800,
                                ),
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
                              this.from.toString() + ":",
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Color(0xFF2F5E4C),
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  this.fromDate.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFFCCC98D),
                                  ),
                                )),
                            Text(
                              this.to.toString() + ":",
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Color(0xFF2F5E4C),
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  this.toDate.toString(),
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
