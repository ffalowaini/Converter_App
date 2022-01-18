import 'package:flutter/material.dart';
import 'package:transfer_app/widgets/titleWidget.dart';

class CurrancyConverter extends StatefulWidget {
  static const String id = 'Currancy-Converter';

  const CurrancyConverter({Key? key}) : super(key: key);

  @override
  _CurrancyConverterState createState() => _CurrancyConverterState();
}

class _CurrancyConverterState extends State<CurrancyConverter> {
  final convertForm = GlobalKey<FormState>();

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
            TitleWidget("Currancy Converter"),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Coming Soon...',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      //     Column(
                      //       children: [
                      //         SizedBox(
                      //           height: 40,
                      //         ),
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //           children: [
                      //             Column(
                      //               mainAxisAlignment: MainAxisAlignment.start,
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 Text('From'),
                      //                 Container(
                      //                   width: 150,
                      //                   height: 40,
                      //                   child: Center(
                      //                       child: Text(this.from.toString())),
                      //                   decoration:
                      //                       Helper.fromToDecoration(context),
                      //                 ),
                      //               ],
                      //             ),
                      //             InkWell(
                      //               onTap: () {
                      //                 setState(() {
                      //                   this.showResult = false;
                      //                   controller.clear();
                      //                   var temp = this.from;
                      //                   this.from = this.to;
                      //                   this.to = temp;
                      //                 });
                      //               },
                      //               child: Image.asset(
                      //                 'assets/icons/convert_icon.png',
                      //                 height: 30,
                      //                 fit: BoxFit.contain,
                      //               ),
                      //             ),
                      //             Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 Text('To'),
                      //                 Container(
                      //                   width: 150,
                      //                   height: 40,
                      //                   child:
                      //                       Center(child: Text(this.to.toString())),
                      //                   decoration:
                      //                       Helper.fromToDecoration(context),
                      //                 ),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //         SizedBox(
                      //           height: 20,
                      //         ),
                      //         Container(
                      //           width: 300,
                      //           child: TextFormField(
                      //             controller: controller,
                      //             keyboardType: TextInputType.datetime,
                      //             validator: (value) {
                      //               bool sameName = false;
                      //               if (this.from == hijiri) {
                      //                 if (!validateHijriRange(value.toString())) {
                      //                   return 'Please Enter Date in valid format & valid range';
                      //                 } else
                      //                   return null;
                      //               } else {
                      //                 if (!validateGregorianRange(
                      //                     value.toString())) {
                      //                   return 'Please Enter Date in valid format & valid range';
                      //                 } else
                      //                   return null;
                      //               }
                      //               // if (value.toLowerCase() != oldName.toLowerCase()) {
                      //               //   foodItems.forEach((element) {
                      //               //     if (element.name.toLowerCase() ==
                      //               //         value.toLowerCase()) {
                      //               //       sameName = true;
                      //               //     }
                      //               //   });
                      //               // }
                      //               // if (value == null) {
                      //               //   setState(() {
                      //               //     validName = false;
                      //               //   });
                      //               //   return 'please enter a valid name.';
                      //               // } else if (sameName) {
                      //               //   setState(() {
                      //               //     validName = false;
                      //               //   });
                      //               //   return 'please enter a new name, this item already exist.';
                      //               // }
                      //               // setState(() {
                      //               //   validName = true;
                      //               // });
                      //               // return null;
                      //             },
                      //             decoration: InputDecoration(
                      //               border: OutlineInputBorder(
                      //                 borderSide: BorderSide.none,
                      //                 borderRadius: BorderRadius.circular(30),
                      //               ),
                      //               prefixIcon: IconButton(
                      //                 icon: Icon(
                      //                   Icons.calendar_today,
                      //                   color: Color(0xFF2F5E4C),
                      //                 ),
                      //                 onPressed: () => {
                      //                   if (this.from == hijiri)
                      //                     selectDateHijri(context)
                      //                   else
                      //                     selectDate(context)
                      //                 },
                      //               ),
                      //               fillColor: Theme.of(context)
                      //                   .accentColor
                      //                   .withOpacity(0.3),
                      //               filled: true,

                      //               contentPadding: EdgeInsets.symmetric(
                      //                   vertical: 10.0, horizontal: 10.0),
                      //               // enabledBorder: OutlineInputBorder(
                      //               //     borderSide: BorderSide(
                      //               //         color: Color(0xFFCCC98D), width: 1.0)),
                      //               // focusedBorder: OutlineInputBorder(
                      //               //   borderSide: BorderSide(
                      //               //       color: Color(0xFFCCC98D), width: 3.0),
                      //               // ),
                      //             ),
                      //           ),
                      //         ),
                      //         SizedBox(
                      //           height: 20,
                      //         ),
                      //         Container(
                      //           width: 300,
                      //           height: 40,
                      //           child: TextButton(
                      //             style: ButtonStyle(
                      //                 backgroundColor: MaterialStateProperty.all(
                      //                     Color(0xFF2F5E4C))),
                      //             onPressed: () {
                      //               if (convertForm.currentState!.validate()) {
                      //                 try {
                      //                   var date = controller.value.text
                      //                       .toString()
                      //                       .trim()
                      //                       .split('-');
                      //                   var toDate;
                      //                   var year = date[0];
                      //                   var month = date[1];
                      //                   var day = date[2];

                      //                   if (this.from == hijiri) {
                      //                     toDate = DateFormat('yyyy-MM-dd')
                      //                         .format(
                      //                             HijriCalendar().hijriToGregorian(
                      //                           int.parse(year),
                      //                           int.parse(month),
                      //                           int.parse(day),
                      //                         ))
                      //                         .toString();
                      //                   } else {
                      //                     var date = HijriCalendar.fromDate(
                      //                       DateTime(
                      //                         int.parse(year),
                      //                         int.parse(month),
                      //                         int.parse(day),
                      //                       ),
                      //                     );
                      //                     toDate = date.hYear.toString() +
                      //                         "-" +
                      //                         date.hMonth.toString() +
                      //                         "-" +
                      //                         date.hDay.toString();
                      //                   }
                      //                   setState(() {
                      //                     this.showResult = true;
                      //                     this.fromDate =
                      //                         year + "-" + month + "-" + day;
                      //                     this.toDate = toDate;
                      //                   });
                      //                 } catch (e) {
                      //                   showDialog(
                      //                     context: context,
                      //                     builder: (ctx) => AlertDialog(
                      //                       title: Text('An error occurred!'),
                      //                       content: Text(e.toString()),
                      //                     ),
                      //                   );
                      //                 }
                      //               }
                      //             },
                      //             child: Text(
                      //               'Convert',
                      //               style: TextStyle(
                      //                   color: Color(0xFFCCC98D),
                      //                   fontWeight: FontWeight.bold),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //     Visibility(
                      //       visible: showResult,
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         children: [
                      //           Text(
                      //             this.from.toString() + ":",
                      //             style: TextStyle(
                      //                 fontSize: 24,
                      //                 color: Color(0xFF2F5E4C),
                      //                 fontWeight: FontWeight.bold),
                      //           ),
                      //           Container(
                      //               padding: EdgeInsets.only(left: 30),
                      //               child: Text(
                      //                 this.fromDate.toString(),
                      //                 style: TextStyle(
                      //                   fontSize: 18,
                      //                   color: Color(0xFFCCC98D),
                      //                 ),
                      //               )),
                      //           Text(
                      //             this.to.toString() + ":",
                      //             style: TextStyle(
                      //                 fontSize: 24,
                      //                 color: Color(0xFF2F5E4C),
                      //                 fontWeight: FontWeight.bold),
                      //           ),
                      //           Container(
                      //               padding: EdgeInsets.only(left: 30),
                      //               child: Text(
                      //                 this.toDate.toString(),
                      //                 style: TextStyle(
                      //                   fontSize: 18,
                      //                   color: Color(0xFFCCC98D),
                      //                 ),
                      //               ))
                      //         ],
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       height: 30,
                      //     ),
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
