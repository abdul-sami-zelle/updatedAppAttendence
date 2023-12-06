import 'package:analog_clock/analog_clock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zelleclients/provider/provider1.dart';
import 'package:zelleclients/utils/multiText.dart';
import 'package:zelleclients/utils/neonButton.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import '../../utils/numbersMulti.dart';
import '../clock/clock_view.dart';
import 'package:http/http.dart' as http;



class EmployeAttendenceNight extends StatefulWidget {
  const EmployeAttendenceNight({super.key});

  @override
  State<EmployeAttendenceNight> createState() => _EmployeAttendenceNightState();
}

class _EmployeAttendenceNightState extends State<EmployeAttendenceNight> {
  @override
  Widget build(BuildContext context) {
    final Provider11 = Provider.of<Provider1>(context, listen: true);
    var data2 ;
    fetch()async{
      final url = 'https://portal.hellodoctor.com.pk/restapi/RestController.php?view=employee_prescription_cc';
final token = 'crescentcare@2023';

final response = await http.get(
  Uri.parse(url),
  headers: {'Authorization': 'Bearer $token'},
);


if (response.statusCode == 200) {
 print(response.body);
} else {
  print("error");
}
    }
    DatabaseReference ref3 = FirebaseDatabase.instance
        .ref("attendence/${Provider11.formattedMonth}/${Provider11.emp_shift}/${Provider11.pformattedDate}/${Provider11.emp_uid}/checkin");
    DatabaseReference ref3a = FirebaseDatabase.instance
        .ref("attendence/${Provider11.formattedMonth}/${Provider11.emp_shift}/${Provider11.formattedDate}/${Provider11.emp_uid}/checkin");
    DatabaseReference ref4 = FirebaseDatabase.instance
        .ref("attendence/${Provider11.formattedMonth}/${Provider11.emp_shift}/${Provider11.pformattedDate}/${Provider11.emp_uid}/checkout");
        DatabaseReference ref4a = FirebaseDatabase.instance
        .ref("attendence/${Provider11.formattedMonth}/${Provider11.emp_shift}/${Provider11.formattedDate}/${Provider11.emp_uid}/checkout");
    DatabaseReference ref1 = FirebaseDatabase.instance
        .ref("inout/${Provider11.formattedMonth}/${Provider11.emp_shift}/${Provider11.formattedDate}/${Provider11.emp_uid}");
    DatabaseReference starCountRef = FirebaseDatabase.instance
        .ref('inout/${Provider11.formattedMonth}/${Provider11.emp_shift}/${Provider11.formattedDate}/${Provider11.emp_uid}');
  
    

    DatabaseReference update = FirebaseDatabase.instance
        .ref("attendence_update/${Provider11.formattedMonth}/${Provider11.emp_shift}/${Provider11.formattedDate}/${Provider11.emp_uid}");

    ref4.onValue.listen((DatabaseEvent event) {
       setState(() {
         data2 = event.snapshot.value.toString();
       });
      
    });   
    return  SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xff1B1B1B),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 70.h,
                    ),
                    Container(child: ClockView()),
                    SizedBox(
                      height: 35.h,
                    ),
                 Provider11.checkout_last==null?Container(
                        height: 150.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(65),
                            color: Provider11.atndncBtnState == "enable"
                                ? Color.fromARGB(255, 44, 223, 50)
                                : Provider11.atndncBtnState == "unenable"
                                    ? Color.fromARGB(255, 177, 15, 3)
                                    : Colors.grey
                            // color: Color(0xffb929be)
                            ),
                        child: Padding(
                          padding: const EdgeInsets.all(17),
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(55),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(0, 5),
                                    blurRadius: 15,
                                    spreadRadius: 2),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: Provider11.atndncBtnState != 'un'
                                  ? () {
                                      if (Provider11.atndncBtnState == "enable") {
                                            DatabaseReference ref = FirebaseDatabase.instance
        .ref("attendence/${Provider11.formattedMonth}/${Provider11.emp_shift}/${Provider11.formattedDate}/${Provider11.emp_uid}");
                                        ref.set({
                                          "checkin": DateFormat('HH:mm:ss')
                                              .format(DateTime.now()),
                                        });
                                      
              
                                        Provider11.atndncBtnState = "un";
                                      } else {
                                            DatabaseReference ref = FirebaseDatabase.instance
        .ref("attendence/${Provider11.formattedMonth}/${Provider11.emp_shift}/${Provider11.pformattedDate}/${Provider11.emp_uid}");
                                        ref.update({
                                          "checkout": DateFormat('HH:mm:ss')
                                              .format(DateTime.now()),                   
                                        });
                                        Provider11.checkout_last="notnull";
                                      }
                                      // Provider11.checkInCheckOut();
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff1B1B1B),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(55),
                                ),
                                minimumSize: Size(120.w, 120.h),
                                elevation: 7,
                                // Change the value to adjust the shadow size
                                shadowColor: Colors
                                    .black, // Change the color of the shadow
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20.h, horizontal: 15.w),
                                child: Column(
                                  children: [
                                    Image.asset("assets/power.png",
                                        height: 60.h,
                                        width: 60.w,
                                        color: Provider11.atndncBtnState ==
                                                "enable"
                                            ? Color.fromARGB(255, 44, 223, 50)
                                            : Provider11.atndncBtnState == "un"
                                                ? Colors.grey
                                                : Color.fromARGB(
                                                    255, 177, 15, 3)),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Multi(
                                        color: Provider11.atndncBtnState ==
                                                "enable"
                                            ? Color.fromARGB(255, 44, 223, 50)
                                            : Provider11.atndncBtnState == "un"
                                                ? Colors.grey
                                                : Color.fromARGB(255, 177, 15, 3),
                                        subtitle:
                                            Provider11.atndncBtnState == "enable"
                                                ? 'check in'
                                                : 'check out',
                                        weight: FontWeight.bold,
                                        size: 10)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    :Column(
                      children: [
                        Container(
                           height: 150.h,
                           width: 150.w,
                           decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/submitted.png",),
                              fit:BoxFit.contain,
                              )
                           ),
                        ),
                        Container(
                          width: 200.w,
                          child: Multi(color: Colors.white, subtitle: "Your Response Has Been Recorded", weight: FontWeight.bold, size: 14))
                      ],
                    ),
                  
                   
                    MyWidget(),
                    SizedBox(
                      height: 50.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 45.h,
                                width: 45.w,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/timein.png"),
                                      fit: BoxFit.contain),
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              StreamBuilder(
                                stream:TimeOfDay.now().hour>=15?ref3a.onValue: ref3.onValue,
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    // Handle the stream data here
                                    return MultiNumber(
                                        color: Colors.white,
                                        subtitle:
                                            "${snapshot.data!.snapshot.value}",
                                        weight: FontWeight.bold,
                                        size: 18);
                                  } else if (snapshot.hasError) {
                                    // Handle any errors that occur
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    // Show a loading indicator while waiting for data
                                    return MultiNumber(
                                        color: Colors.white,
                                        subtitle: "00:00:00",
                                        weight: FontWeight.bold,
                                        size: 18);
                                  }
                                },
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Text(
                                "check in",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        color: Colors.grey, fontSize: 12.sp),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          Column(
                            children: [
                              Container(
                                height: 45.h,
                                width: 45.w,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/timeout.png"),
                                      fit: BoxFit.contain),
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              StreamBuilder(
                                stream:TimeOfDay.now().hour>=15?ref4a.onValue: ref4.onValue,
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    // Handle the stream data here
                                    return MultiNumber(
                                        color: Colors.white,
                                        subtitle:
                                            "${snapshot.data!.snapshot.value}",
                                        weight: FontWeight.bold,
                                        size: 18);
                                  } else if (snapshot.hasError) {
                                    // Handle any errors that occur
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    // Show a loading indicator while waiting for data
                                    return MultiNumber(
                                        color: Colors.white,
                                        subtitle: "00:00:00",
                                        weight: FontWeight.bold,
                                        size: 18);
                                  }
                                },
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Text(
                                "check out",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        color: Colors.grey, fontSize: 12.sp),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          fetch();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          elevation: 0, // Remove the built-in shadow
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: Size(30.h, 30.w),
                        ),
                        child: Container(
                          height: 30.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/menu.png"))),
                        ),
                      ),
                       ElevatedButton(
                        onPressed: () {
                          
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          elevation: 0, // Remove the built-in shadow
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: Size(30.h, 30.w),
                        ),
                        child: Container(
                          height: 30.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/edit.png"))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xff1B1B1B),
                            borderRadius: BorderRadius.circular(20.r)),
                        width: double.infinity,
                        height: 50.h,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xffb929be),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.r),
                                        bottomLeft: Radius.circular(20.r),
                                      )),
                                  child: Container(
                                      child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Image.asset(
                                      "assets/inout.png",
                                      color: Colors.white,
                                      height: 30.h,
                                      width: 30.w,
                                    ),
                                  )),
                                )),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  color: Color(0xff009ae2),
                                  child: Container(
                                      child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Image.asset(
                                      "assets/home.png",
                                      color: Colors.white,
                                      height: 30.h,
                                      width: 30.w,
                                    ),
                                  )),
                                )),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xffb929be),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20.r),
                                        bottomRight: Radius.circular(20.r),
                                      )),
                                  child: GestureDetector(
                                    onTap:(){
                                      Provider11.checkOutDate();
                                    },
                                    child: Container(
                                        child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Image.asset(
                                        "assets/history.png",
                                        color: Colors.white,
                                        height: 30.h,
                                        width: 30.w,
                                      ),
                                    )),
                                  ),
                                )),
                          ],
                        ))),
              )
            ],
          )),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Provider11 = Provider.of<Provider1>(context, listen: true);
    return StreamBuilder<bool>(
      stream: Provider11.checkTargetTimeStreamNight(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // Handle the error
          return Container();
        } else if (!snapshot.hasData) {
          // Show a loading spinner while waiting for data
          return Container();
        } else if (snapshot.data!) {
          // The target time is later than the current time, show some data
          return Container();
        } else {
          // The target time is earlier than the current time, show some other data
          return Container();
        }
      },
    );
  }
}






