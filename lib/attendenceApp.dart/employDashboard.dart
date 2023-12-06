import 'dart:async';

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
import 'package:zelleclients/attendenceApp.dart/attendenceData.dart';
import 'package:zelleclients/attendenceApp.dart/companyName.dart';
import 'package:zelleclients/attendenceApp.dart/day/employAttendenceDay.dart';
import 'package:zelleclients/attendenceApp.dart/performance.dart';
import 'package:zelleclients/attendenceApp.dart/profile.dart';
import 'package:zelleclients/attendenceApp.dart/reports.dart';
import 'package:zelleclients/popups/internetPopup.dart';
import 'package:zelleclients/provider/provider1.dart';
import 'package:zelleclients/utils/multiText.dart';
import 'package:zelleclients/utils/neonButton.dart';
import '../mainInitial.dart';
import '../utils/empDashboardCircle.dart';
import '../utils/forgotLink.dart';
import '../utils/heading2.dart';
import 'dart:math' as math;

import 'atndnceOverview.dart';
import 'night/employAttendenceNight.dart';

class EmployeDashBoard extends StatelessWidget {

  EmployeDashBoard({super.key,});

  @override
  Widget build(BuildContext context) {
    final Provider11 = Provider.of<Provider1>(context);
    DateTime parseDateTime(String date, String time) {
      final components = date.split('-');
      final day = int.parse(components[0]);
      final month = int.parse(components[1]);
      final year = int.parse(components[2]);

      final timeComponents = time.split(':');
      final hour = int.parse(timeComponents[0]);
      final minute = int.parse(timeComponents[1]);
      final second = int.parse(timeComponents[2]);

      return DateTime(year, month, day, hour, minute, second);
    }

void fetchDataForUID(String uid) {
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref("attendence");

  databaseRef.child('${Provider11.formattedMonth}/${Provider11.emp_shift}').once().then((DatabaseEvent event) {
    DataSnapshot snapshot = event.snapshot;
    if (snapshot.value != null) {
      Map<dynamic, dynamic> mayData = snapshot.value as Map<dynamic, dynamic>;

      // Loop through each date
      Provider11.inout.clear();
      mayData.forEach((dateKey, dateValue) {
        dateValue.forEach((a,b){
          if (Provider11.emp_uid==a) {
            Provider11.inout.add(check_in_out(date: dateKey, check_in: b['checkin'], check_out: b['checkout']));
          }
        });
        Provider11.inout.sort((a, b) => b.date!.compareTo(a.date.toString()));
      }
      
      );
    }
  });
}
see(){
 print(Provider11.inout);
}
                  saveUserLoggedInState(bool isLoggedIn) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', isLoggedIn);
    }
 void logoutUser() async {
          try {
            await FirebaseAuth.instance.signOut();
            // Save the user's authentication state
            await saveUserLoggedInState(false);
             Navigator.push(
            context, MaterialPageRoute(builder: (context) => CompanyName()));
          } on FirebaseAuthException catch (e) {
            print('Failed to sign out: $e');
          }
        }
        

    return SafeArea(
      child:
          //  Scaffold(
          //   backgroundColor: Color(0xff1B1B1B),
          //   body:
          //    Stack(
          //     children: [
          //       Center(
          //         child: Row(
          //           children: [
          //              Padding(
          //               padding: const EdgeInsets.only(bottom: 70),
          //               child: Container(
          //                 height: 450.h,
          //                 width: 250.w,
          //                 decoration: BoxDecoration(
          //                   gradient: LinearGradient(colors: [
          //                     Color(0xff009ae2),
          //                     Color(0xffb929be),
          //                     Color(0xff4E2EBB),
          //                   ]),
          //                   borderRadius: BorderRadius.only(topRight: Radius.circular(2000.r),bottomRight: Radius.circular(2000.r))
          //                 ),

          //                 ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       Positioned(
          //         top: 85.h,
          //         left: 85.w,
          //       child: Container(
          //         height: 140.h,
          //         width: 140.w,
          //         decoration: BoxDecoration(
          //           boxShadow: [
          //             BoxShadow(
          //               offset: Offset(4,4),
          //               color: Colors.white,
          //               blurRadius: 10,
          //               // blurStyle: BlurStyle.outer
          //             )
          //           ],
          //           color: Colors.white,
          //           shape: BoxShape.circle
          //         ),
          //       )),
          //       Positioned(
          //         top: 230.h,
          //         left: 150.w,
          //       child: Container(
          //         height: 140.h,
          //         width: 140.w,
          //         decoration: BoxDecoration(
          //           color: Colors.amber,
          //           shape: BoxShape.circle
          //         ),
          //       )),
          //       Positioned(
          //         bottom: 130.h,
          //         left: 85.w,
          //       child: Container(
          //         height: 140.h,
          //         width: 140.w,
          //         decoration: BoxDecoration(
          //           color: Colors.amber,
          //           shape: BoxShape.circle
          //         ),
          //       )),
          //     ],
          //   ),
          // ),
          Scaffold(
        backgroundColor: Color(0xff1B1B1B),
        body: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final width = 320.w;
                final width2 = 350.w;
                return SizedBox(
                  width: width,
                  height: constraints.maxHeight,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: 20.h,
                        left: 10.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Multi(
                                color: Colors.white,
                                subtitle: "${Provider11.emp_name}",
                                weight: FontWeight.bold,
                                size: 24),
                            Multi(
                                color: Color(0xff009ae2),
                                subtitle: "${Provider11.emp_designation}",
                                weight: FontWeight.bold,
                                size:Provider11.emp_designation!.length>22? 18:23),
                          ],
                        ),
                      ),
                      // background 1st
                      Positioned(
                        top: 50.h,
                        left: -width *.5,
                        bottom: 50.h,
                        right: 120.w,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: const GradientBoxBorder(
                              gradient: LinearGradient(
                                  colors: [Color(0xff009ae2), Color(0xffb929be)]),
                              width: 3,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: 90.w, left: 120.w, top: 90.h, bottom: 90.h),
                            child: Container(
                              height: 30.h,
                              width: 30.w,
                              decoration: BoxDecoration(
                                color: Color(0xff1B1B1B),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(-0.5, -0.5),
                                    blurRadius: 10,
                                    color: Color(0xff009ae2),
                                  )
                                ],
                                shape: BoxShape.circle,
                                border: const GradientBoxBorder(
                                  gradient: LinearGradient(colors: [
                                    Color(0xff009ae2),
                                    Color(0xffb929be)
                                  ]),
                                  width: 1.5,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(4),
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            "https://res.cloudinary.com/diecwxxmm/image/upload/v1697084087/zellesolutions%20portal/nh5ub0ynyfwvi5c9wnac.jpg"
                                          //  Provider11.emp_profile.toString(),
                                          ),
                                          fit: BoxFit.contain)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      TweenAnimationBuilder(
                        child: Align(
                          alignment: Alignment(-.25.w, -.50.h),
                          child: InkWell(
                            child: CircleEmployDashBoard(
                              img: 'assets/attendence.png',
                              txt: 'Attendence',
                            ),
                            onTap: () async{
                             if (Provider11.emp_shift=="Day") {
                               print(Provider11.branchDetails);
                                await Provider11.checkInternetConnectivity();
                                if (Provider11.internetAvailabilty == "yes") {
                                       await Provider11.setd(context);
                                       await Provider11.checkActiveStatus();
                                      await Provider11.moveToNext(context);
                                 } else {
                                   await  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return InternetConnectivityIssue();
                                      },
                                    );
                                 }
                              } else {
                                await Provider11.checkInternetConnectivity();
                                if (Provider11.internetAvailabilty == "yes") {
                                    
                                await Provider11.setd(context);
                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EmployeAttendenceNight()),
                              );
                                } else {
                                  await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return InternetConnectivityIssue();
                                      },
                                    );
                                }


                              
                              }
                              
                            
                            },
                          ),
                        ),
                        duration: Duration(milliseconds: 3000),
                        curve: Curves.bounceOut,
                        tween: Tween(begin: 1.0, end: 0.0),
                        builder: (context, value, child) {
                          // horizontal disposition of the widget.
                          return Transform.translate(
                            offset: Offset(value * 500, 0.0),
                            child: child,
                          );
                        },
                      ),
                      TweenAnimationBuilder(
                        child: Align(
                          alignment: Alignment(.60.w, -0.29.h),
                          child: GestureDetector(
                            onTap: ()async{
                                await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AttendanceData()),
                                    );

                            },
                            child: CircleEmployDashBoard(
                              img: 'assets/date.png',
                              txt: 'Datewise\nAttendence',
                            ),
                          ),
                        ),
                        duration: Duration(milliseconds: 3000),
                        curve: Curves.bounceOut,
                        tween: Tween(begin: 1.0, end: 0.0),
                        builder: (context, value, child) {
                          // horizontal disposition of the widget.
                          return Transform.translate(
                            offset: Offset(value * 500, 0.0),
                            child: child,
                          );
                        },
                      ),
                      TweenAnimationBuilder(
                        child: Align(
                          alignment: Alignment(.85.w, .0.h),
                          child: GestureDetector(
                            onTap: (){
                         Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => 
                                    Profile()
                                   // Reports()
                                  // TaskStats()
                                    ),);
                            },
                            child: CircleEmployDashBoard(
                              img: 'assets/overview.png',
                              txt: 'Overview',
                            ),
                          ),
                        ),
                        duration: Duration(milliseconds: 3000),
                        curve: Curves.bounceOut,
                        tween: Tween(begin: 1.0, end: 0.0),
                        builder: (context, value, child) {
                          // horizontal disposition of the widget.
                          return Transform.translate(
                            offset: Offset(value * 500, 0.0),
                            child: child,
                          );
                        },
                      ),
                      TweenAnimationBuilder(
                        child: Align(
                          alignment: Alignment(.60.w, 0.29.h),
                          child: GestureDetector(
                            onTap: (){
                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => 
                                    // Profile()
                                   // Reports()
                                  TaskStats()
                                    ),);
                            },
                            child: CircleEmployDashBoard(
                              img: 'assets/skill.png',
                              txt: 'Performance',
                            ),
                          ),
                        ),
                        duration: Duration(milliseconds: 3000),
                        curve: Curves.bounceOut,
                        tween: Tween(begin: 1.0, end: 0.0),
                        builder: (context, value, child) {
                          // horizontal disposition of the widget.
                          return Transform.translate(
                            offset: Offset(value * 500, 0.0),
                            child: child,
                          );
                        },
                      ),
                      TweenAnimationBuilder(
                        child: Align(
                          alignment: Alignment(-.25.w, .50.h),
                          child: GestureDetector(
                            onTap: (){
                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => 
                                  //  Profile()
                                   Reports()
                                  // TaskStats()
                                    ),);
                            },
                            child: CircleEmployDashBoard(
                              img: 'assets/stats.png',
                              txt: 'Stats',
                            ),
                          ),
                        ),
                        duration: Duration(milliseconds: 3000),
                        curve: Curves.bounceOut,
                        tween: Tween(begin: 1.0, end: 0.0),
                        builder: (context, value, child) {
                          // horizontal disposition of the widget.
                          return Transform.translate(
                            offset: Offset(value * 500, 0.0),
                            child: child,
                          );
                        },
                      ),
                      Positioned(
                          top: 20.h,
                          // right: 20.w,
                          right: -15.w,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0.w),
                            child: GestureDetector(
                              onTap: (){
                                logoutUser();
                              },
                              child: Container(
                                height: 40.h,
                                width: 40.w,
                                child: Image.asset("assets/off.png",color: Color(0xff009ae2),),
                              ),
                            )
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                              
                            //     Column(
                            //       children: [
                            //         Multi(
                            //             color: Colors.white,
                            //             subtitle: "Click to Logout",
                            //             weight: FontWeight.bold,
                            //             size: 10),
                            //         SizedBox(
                            //           height: 4.h,
                            //         ),
                            //        Container(
                            //         height: 40.h,
                            //         width: 120.w,
                            //         decoration: BoxDecoration(color: Color.fromARGB(0, 34, 32, 32)),
                            //         child: DecoratedBox(
                            //             decoration: BoxDecoration(
                            //                 gradient: LinearGradient(colors: [
                            //                   Color(0xff009ae2),
                            //                   Color(0xff009ae2)
                            //                 ]),
                            //                 borderRadius: BorderRadius.circular(5),
                            //                 boxShadow: <BoxShadow>[
                            //                   BoxShadow(
                            //                       color: Color.fromRGBO(
                            //                           0, 0, 0, 0.57), 
                            //                       blurRadius: 5) 
                            //                 ]),
                            //             child: ElevatedButton(
                            //                 style: ElevatedButton.styleFrom(
                            //                   primary: Colors.transparent,
                            //                   onSurface: Colors.transparent,
                            //                   shadowColor: Colors.transparent,
                                           
                            //                 ),
                            //                 onPressed: () {
                            //                   logoutUser();
                            //                 },
                            //                 child: Padding(
                            //                   padding: EdgeInsets.only(
                            //                     top: 5,
                            //                     bottom: 5,
                            //                   ),
                            //                   child: Text("Log Out"),
                            //                 ))),
                            //       )
                            //       ],
                            //     ),
                            //   ],
                            // ),
                          )),
                         
                    ],
                  ),
                );
              },
            ),
            Provider11.waitingState==true?Align(
                        alignment: Alignment.center,
                        child: Container(  
                          height: double.infinity,
                          width: double.infinity,
                          color: Colors.black.withOpacity(0.7),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                spinkit1,
                                SizedBox(height: 6.h,),
                                Multi(color: Colors.white, subtitle: "Please Wait", weight: FontWeight.bold, size: 16),
                                Multi(color: Colors.white, subtitle: "Fetching Your Location", weight: FontWeight.bold, size: 14)
                              ],
                            ),
                          ),
                        ),
                      ):Container()
          ],
        ),
      ),
    );
  }
}

