import 'dart:ui';
import 'package:geolocator/geolocator.dart';
import 'package:analog_clock/analog_clock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drop_shadow/drop_shadow.dart';
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

import '../../mainInitial.dart';
import '../../utils/numbersMulti.dart';
import '../clock/clock_view.dart';
import 'attendenceHistory.dart';

class EmployeAttendenceDay extends StatefulWidget {
   EmployeAttendenceDay({super.key});

  @override
  State<EmployeAttendenceDay> createState() => _EmployeAttendenceDayState();
}

class _EmployeAttendenceDayState extends State<EmployeAttendenceDay> {
  @override
    // textcontrollers for check in editable time //

  final TextEditingController check_in = TextEditingController();

  final TextEditingController justification_in = TextEditingController();

    final TextEditingController check_out = TextEditingController();

  final TextEditingController justification_out = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String pg2 = 'checkin';

  Widget build(BuildContext context) {
    final Provider11 = Provider.of<Provider1>(context, listen: true);
    var data2 ;
    DatabaseReference ref = FirebaseDatabase.instance
        .ref("attendence/${Provider11.formattedMonth}/${Provider11.emp_shift}/${Provider11.formattedDate}/${Provider11.emp_uid}");
    DatabaseReference ref3 = FirebaseDatabase.instance
        .ref("attendence/${Provider11.formattedMonth}/${Provider11.emp_shift}/${Provider11.formattedDate}/${Provider11.emp_uid}/checkin");
    DatabaseReference ref4 = FirebaseDatabase.instance
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
    Future<void> getCurrentLocation() async {
  // Check if location services are enabled
  bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!isLocationServiceEnabled) {
    // Location services are not enabled
    return;
  }

  // Request permission to access location
  LocationPermission permission = await Geolocator.requestPermission();
  if (permission != LocationPermission.always && permission != LocationPermission.whileInUse) {
    // Permission not granted
    return;
  }

  // Get current position
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  double latitude = position.latitude;
  double longitude = position.longitude;

  // Use latitude and longitude as needed
  print('Latitude: $latitude, Longitude: $longitude');
}


    editTime(){
       showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child:StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
             
              height: 450.h,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 5.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: pg2=="checkin"? Color(0xffb929be):Colors.grey,
                          ),
                          onPressed:pg2=="checkout"? (){
                            setState(() => pg2 = 'checkin');
                          }:null, 
                          child: Multi(
                            color:Colors.white, 
                            subtitle: "Check in", 
                            weight: FontWeight.bold,
                            size: 10),
                            ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: pg2=="checkout"? Color(0xffb929be):Colors.grey,
                          ),
                          onPressed:pg2=="checkin"? (){
                             setState(() => pg2 = 'checkout');
                          }:null, 
                          child: Multi(
                            color: Color(0xffb929be), 
                            subtitle: "Check out", 
                            weight: FontWeight.bold,
                            size: 10),
                            )
                      ],
                    ),
                    SizedBox(height: 5.h,),
                   pg2=='checkin'? Container(
                      
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Multi(
                                    color: Color(0xffb929be),
                                    subtitle: "Check in Time",
                                    weight: FontWeight.normal,
                                    size: 15),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: GradientBoxBorder(
                                        gradient: LinearGradient(
                                            colors: [Color(0xff009ae2), Color(0xffb929be)]),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(10.r)),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 5.h, bottom: 5.h, right: 12.w, left: 12.w),
                                    child: TextFormField(
                                      controller: check_in,
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
                            return 'Text is empty';
                                          }
                                          return null;
                                        },
                                      style: TextStyle(
                                          color: Color(0xffb929be),
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.normal),
                                      decoration: InputDecoration(
                                        hintText: "08:00:00 AM",
                                        hintStyle: TextStyle(
                                            color: Color(0xff009ae2),
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.normal),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0, color: Colors.transparent),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0, color: Colors.transparent),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.h,),
                                Multi(
                                    color: Color(0xffb929be),
                                    subtitle: "Justification",
                                    weight: FontWeight.normal,
                                    size: 15),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: GradientBoxBorder(
                                        gradient: LinearGradient(
                                            colors: [Color(0xff009ae2), Color(0xffb929be)]),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(10.r)),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 5.h, bottom: 5.h, right: 12.w, left: 12.w),
                                    child: TextFormField(
                                      controller: justification_in,
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
                            return 'Text is empty';
                                          }
                                          return null;
                                        },
                                      keyboardType: TextInputType.multiline,
                            maxLines: 10,
                                      style: TextStyle(
                                          color: Color(0xffb929be),
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.normal),
                                      decoration: InputDecoration(
                                        hintText: "Justify your reason...",
                                        hintStyle: TextStyle(
                                            color: Color(0xff009ae2),
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.normal),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0, color: Colors.transparent),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0, color: Colors.transparent),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                     SizedBox(
                                  width: 120.w,
                                  child: ElevatedButton(
                                  style:  ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xffb929be)
                                  ),
                                    onPressed: () {
                                       if (_formKey.currentState!.validate()) {
                                          update.update({
                                            "checkin":"${check_in.text}",
                                            "justification_in":"${justification_in.text}"
                                            });
                                          ref.update({
                                              "checkin":"${check_in.text}",
                                            });
                                           }
                                          Navigator.of(context).pop();
                                    },
                                    child: Multi(
                                      color: Colors.white, 
                                      subtitle: "Save", 
                                      weight: FontWeight.bold,
                                      size: 12)
                                  ),
                                ),
                                 SizedBox(
                                  width: 120.w,
                                  child: ElevatedButton(
                                  style:  ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xffb929be)
                                  ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Multi(
                                      color: Colors.white, 
                                      subtitle: "Cancel", 
                                      weight: FontWeight.bold,
                                      size: 12)
                                  ),
                                )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ):Container(
                      
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child:Form (
                           key: _formKey,
                          child: SingleChildScrollView(
                           
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Multi(
                                    color: Color(0xffb929be),
                                    subtitle: "Check out Time",
                                    weight: FontWeight.normal,
                                    size: 15),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: GradientBoxBorder(
                                        gradient: LinearGradient(
                                            colors: [Color(0xff009ae2), Color(0xffb929be)]),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(10.r)),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 5.h, bottom: 5.h, right: 12.w, left: 12.w),
                                    child: TextFormField(
                                      controller: check_out,
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
                            return 'Text is empty';
                                          }
                                          return null;
                                        },
                                      style: TextStyle(
                                          color: Color(0xffb929be),
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.normal),
                                      decoration: InputDecoration(
                                        hintText: "08:00:00 AM",
                                        hintStyle: TextStyle(
                                            color: Color(0xff009ae2),
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.normal),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0, color: Colors.transparent),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0, color: Colors.transparent),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.h,),
                                Multi(
                                    color: Color(0xffb929be),
                                    subtitle: "Justification",
                                    weight: FontWeight.normal,
                                    size: 15),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: GradientBoxBorder(
                                        gradient: LinearGradient(
                                            colors: [Color(0xff009ae2), Color(0xffb929be)]),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(10.r)),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 5.h, bottom: 5.h, right: 12.w, left: 12.w),
                                    child: TextFormField(
                                      controller: justification_out,
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
                            return 'Text is empty';
                                          }
                                          return null;
                                        },
                                      keyboardType: TextInputType.multiline,
                            maxLines: 10,
                                      style: TextStyle(
                                          color: Color(0xffb929be),
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.normal),
                                      decoration: InputDecoration(
                                        hintText: "Justify your reason...",
                                        hintStyle: TextStyle(
                                            color: Color(0xff009ae2),
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.normal),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0, color: Colors.transparent),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0, color: Colors.transparent),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                     SizedBox(
                                  width: 120.w,
                                  child: ElevatedButton(
                                  style:  ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xffb929be)
                                  ),
                                    onPressed: () {
                                       if (_formKey.currentState!.validate()) {
                                           update.update({
                                            "checkout":"${check_out.text}",
                                            "justification_out":"${justification_out.text}"
                                            });
                                            ref.update({
                                              "checkout":"${check_out.text}",
                                            });
                                          Navigator.of(context).pop();
                                           }
                                    },
                                    child: Multi(
                                      color: Colors.white, 
                                      subtitle: "Save", 
                                      weight: FontWeight.bold,
                                      size: 12)
                                  ),
                                ),
                                 SizedBox(
                                  width: 120.w,
                                  child: ElevatedButton(
                                  style:  ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xffb929be)
                                  ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Multi(
                                      color: Colors.white, 
                                      subtitle: "Cancel", 
                                      weight: FontWeight.bold,
                                      size: 12)
                                  ),
                                )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),);}
            ),
          );
        });
    }

    return SafeArea(
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
                 Provider11.checkout_last==null? Stack(
                   children: [
                     Align(
                      alignment: Alignment.center,
                       child: Container(
                               
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
                                                ref.set({
                                                  "checkin": DateFormat('HH:mm:ss')
                                                      .format(DateTime.now()),
                                                });
                                              
                                     
                                                Provider11.atndncBtnState = "un";
                                              } else {
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
                              ),
                     ),
                          Provider11.disableBreakButton==true?  Align(
                              alignment: Alignment.center,
                              child: DropShadow(
                                borderRadius: 0,
                                blurRadius: 5,
                                child: Container(
                                 height: 150.h,
                                width: 150.w,
                              ))
                            ):Container(),
                           Provider11.disableBreakButton==true? Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding:EdgeInsets.only(
                                  top: 40.h
                                ),
                                child: Container(
                                  height: 100.h,
                                  width: 100.w,
                                  // decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.circular(5.r),
                                  //   color: Colors.white,
                                  // ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 40.h,
                                        width: 40.w,
                                        child: spinkit2),
                                      Multi(color: Color.fromARGB(255, 255, 255, 255), subtitle: "You Are in Break", weight: FontWeight.bold, size: 16)
                                    ],
                                  ),
                                ),
                              ),
                            ):Container()
                      // Align(
                      //   alignment: Alignment.center,
                      //   child: ClipRect(
                      //    child: new BackdropFilter(
                      //      filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      //      child: new Container(
                      //        width: 200.0,
                      //        height: 200.0,
                      //        decoration: new BoxDecoration(
                      //            borderRadius: BorderRadius.circular(20.0),
                      //            color: Colors.grey.shade200.withOpacity(0.5)),
                      //        child: Center(child: Text("Censored",style: TextStyle(fontSize: 30),)),
                      //      ),
                      //    ),
                      //                      ),
                      // )
                   ],
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
                                stream: ref3.onValue,
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
                                stream: ref4.onValue,
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
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          elevation: 0, // Remove the built-in shadow
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: Size(30.h, 30.w),
                        ),
                        child:Container(
                          height: 50.h,
                          // width: 30.w,
                         child: Column(
                          children: [
                            Image.asset("assets/back.png",color: Colors.white,height: 30.h,width: 30.w,),
                            // SizedBox(height: 1.h,),
                            Multi(color: Colors.white, subtitle: "Back", weight: FontWeight.w600, size: 10)
                          ],
                         ),
                        )
                      ),
                       ElevatedButton(
                        onPressed: () {
                           editTime();
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
            ((Provider11.checkout_last==null )&&(Provider11.checkin_last!=null))?  Positioned(
                bottom: 90.h,
                left: MediaQuery.of(context).size.width/4,
                right: MediaQuery.of(context).size.width/4,
                child:Provider11.disableBreakButton==true? Container(
                                height: 40.h,
                                width: MediaQuery.of(context).size.width/2,
                                decoration: BoxDecoration(color: Color.fromARGB(0, 34, 32, 32)),
                                child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Color(0xff009ae2),
                                          Color(0xff009ae2)
                                        ]),
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: Color.fromRGBO(
                                                  0, 0, 0, 0.57), 
                                              blurRadius: 5) 
                                        ]),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.transparent,
                                          onSurface: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                       
                                        ),
                                        onPressed: () async{
             // Provider11.addBreakDataBase();
            await Provider11.enableBreakButton();
            await Provider11.offBreakButton();
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: 5,
                                            bottom: 5,
                                          ),
                                          child: Text("off break"),
                                        ))),
                              ):Container(
                                height: 40.h,
                                width: MediaQuery.of(context).size.width/2,
                                decoration: BoxDecoration(color: Color.fromARGB(0, 34, 32, 32)),
                                child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Color(0xff009ae2),
                                          Color(0xff009ae2)
                                        ]),
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: Color.fromRGBO(
                                                  0, 0, 0, 0.57), 
                                              blurRadius: 5) 
                                        ]),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.transparent,
                                          onSurface: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                       
                                        ),
                                        onPressed: () async{
             await Provider11.enableBreakButton();                            
             await Provider11.addBreakDataBase();
                                                  
                                                 
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: 5,
                                            bottom: 5,
                                          ),
                                          child: Text("Take Break"),
                                        ))),
                              )):Container(),
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
                                      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AtendenceHistoryDay()));
                                    },
                                    child: Container(
                                        child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Image.asset(
                                        "assets/history.png",
                                        color: Colors.white,
                                        height: 20.h,
                                        width: 20.w,
                                      ),
                                    )),
                                  ),
                                )),
                          ],
                        ))),
              ),
           Provider11.showCheckInCheckOut==false?Align(
                alignment: Alignment.center,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20.w),
                      child: Container(
                        height: 155.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 32, 35, 50),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 20.h,),
                            Image.asset("assets/noLocation.png",height: 50.h,width: 50.w,),
                            SizedBox(height: 10.h,),
                            Multi(color: Colors.white, subtitle: "You're Outside of the Office Premises.", weight: FontWeight.bold, size: 12),
                            SizedBox(height: 10.h,),
                            Container(
                                height: 30.h,
                                width: 90.w,
                                decoration: BoxDecoration(color: Color.fromARGB(0, 34, 32, 32)),
                                child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Color(0xff009ae2),
                                          Color(0xff009ae2)
                                        ]),
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: Color.fromRGBO(
                                                  0, 0, 0, 0.57), 
                                              blurRadius: 5) 
                                        ]),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.transparent,
                                          onSurface: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                       
                                        ),
                                        onPressed: () async{
                                          Navigator.of(context).pop();                                                
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: 5,
                                            bottom: 5,
                                          ),
                                          child: Text("Go Back"),
                                        ))),
                              ),
                            SizedBox(height: 20.h,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ):Container()
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
      stream: Provider11.checkTargetTimeStream(),
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






final spinkit2 = SpinKitDoubleBounce(
 color:Color.fromARGB(255, 255, 255, 255) ,

);
    