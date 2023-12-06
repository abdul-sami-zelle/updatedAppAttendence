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


class AtendenceHist extends StatelessWidget {
  String? checkin;
  String? checkout;
  String? date;
  
  AtendenceHist({super.key,required this.checkin,required this.checkout,required this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 100.h,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Color(0xff14181D),
                blurRadius: 15,
                spreadRadius: 10
              )
            ]
          ),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  height: 120.h,
                  decoration: BoxDecoration(
                    color: Color(0xff14181D).withOpacity(0.6),
                    borderRadius: BorderRadius.only(
                      topRight:Radius.circular(100.r),
                      bottomRight:Radius.circular(100.r),
                      topLeft:Radius.circular(12.r),
                      bottomLeft:Radius.circular(12.r),
                    ),
                   
                  ),
                  child: Padding(
                    padding:EdgeInsets.only(left: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Multi(color: Colors.white, subtitle: "Check-in Time", weight: FontWeight.bold, size: 12),
                            SizedBox(width: 4.w,),
                            Image.asset("assets/tick.png",height: 20.h,width: 20.w,color: Color(0xff009ae2),),
                          ],
                        ),
                        SizedBox(height: 4.h,),
                        Multi(color: Colors.white, subtitle: "$checkin", weight: FontWeight.bold, size: 25),
                        SizedBox(height: 4.h,),
                        Multi(color: Colors.white, subtitle: "$date", weight: FontWeight.bold, size: 18),
                      ],
                    ),
                  ),
                )
                ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding:EdgeInsets.only(left: 5.w),
                  child: Container(
                    child: Padding(
                      padding:EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                           
                          border: Border(
                            bottom: BorderSide(color: Color(0xff009ae2),width: 1.5,),
                            top: BorderSide(color: Color(0xff009ae2),width: 1.5),
                            right: BorderSide(color: Color(0xff009ae2),width: 1.5),
                            
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 4.h,),
                            Multi(color: Color.fromARGB(255, 42, 48, 54), subtitle: "Status", weight: FontWeight.bold, size: 10),
                            SizedBox(height: 4.h,),
                            Multi(color: Color(0xff009ae2), subtitle: "On Time", weight: FontWeight.bold, size: 21),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                ),
            ],
          ),
        ),
        SizedBox(height: 10.h,),
        Container(
          width: double.infinity,
          height: 100.h,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Color(0xff14181D),
                blurRadius: 15,
                spreadRadius: 10
              )
            ]
          ),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  height: 120.h,
                  decoration: BoxDecoration(
                    color: Color(0xff14181D).withOpacity(0.6),
                    borderRadius: BorderRadius.only(
                      topRight:Radius.circular(100.r),
                      bottomRight:Radius.circular(100.r),
                      topLeft:Radius.circular(12.r),
                      bottomLeft:Radius.circular(12.r),
                    ),
                   
                  ),
                  child: Padding(
                    padding:EdgeInsets.only(left: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Multi(color: Colors.white, subtitle: "Check-out Time", weight: FontWeight.bold, size: 12),
                            SizedBox(width: 4.w,),
                            Image.asset("assets/tick.png",height: 20.h,width: 20.w,color: Color(0xff009ae2),),
                          ],
                        ),
                        SizedBox(height: 4.h,),
                        Multi(color: Colors.white, subtitle: "$checkout", weight: FontWeight.bold, size: 25),
                        SizedBox(height: 4.h,),
                        Multi(color: Colors.white, subtitle: "$date", weight: FontWeight.bold, size: 18),
                      ],
                    ),
                  ),
                )
                ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding:EdgeInsets.only(left: 5.w),
                  child: Container(
                    child: Padding(
                      padding:EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                           
                          border: Border(
                            bottom: BorderSide(color: Color(0xff009ae2),width: 1.5,),
                            top: BorderSide(color: Color(0xff009ae2),width: 1.5),
                            right: BorderSide(color: Color(0xff009ae2),width: 1.5),
                            
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 4.h,),
                            Multi(color: Color.fromARGB(255, 42, 48, 54), subtitle: "Status", weight: FontWeight.bold, size: 10),
                            SizedBox(height: 4.h,),
                            Multi(color: Color(0xff009ae2), subtitle: "On Time", weight: FontWeight.bold, size: 21),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                ),
            ],
          ),
        ),
      ],
    );
  }
}