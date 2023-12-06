import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zelleclients/classes/revenue.dart';
import 'package:zelleclients/provider/provider1.dart';
import 'package:zelleclients/utils/multiText.dart';
import 'package:flutter/material.dart';

import '../login.dart';

class Analytics extends StatelessWidget {
  String ts;
  String ns;
  String to;
  String aov;
  String ti;
   Analytics({super.key,required this.ts,required this.ns,required this.to,required this.aov,required this.ti});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
     appBar: AppBar(
          backgroundColor: Color(0xff1E1E1E),
          title: Text("Analytics"),
          leading: BackButton(color: Colors.white,onPressed: () {
            Navigator.pop(context);
          },),
        ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 200.h,
                  width: double.infinity,
                  color: Color(0xff1E1E1E),
                  child: Padding(
                    padding: const EdgeInsets.all(11),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Multi(
                                  color: Colors.white,
                                  subtitle: "Revenue",
                                  weight: FontWeight.w500,
                                  size: 15),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Multi(
                                      color: Colors.grey,
                                      subtitle: "Total sales",
                                      weight: FontWeight.normal,
                                      size: 12),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Multi(
                                      color: Colors.white,
                                      subtitle: "PKR ${ts}",
                                      weight: FontWeight.w500,
                                      size: 20)
                                ],
                              ),
                            ),
                            SizedBox(
                  height: 20.h,
                ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Multi(
                                      color: Colors.grey,
                                      subtitle: "Net sales",
                                      weight: FontWeight.normal,
                                      size: 12),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Multi(
                                      color: Colors.white,
                                      subtitle: "PKR ${ns}",
                                      weight: FontWeight.w500,
                                      size: 20)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 120.h,
                  width: double.infinity,
                  color: Color(0xff1E1E1E),
                  child: Padding(
                    padding: const EdgeInsets.all(11),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Multi(
                                  color: Colors.white,
                                  subtitle: "Orders",
                                  weight: FontWeight.w500,
                                  size: 15),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Multi(
                                      color: Colors.grey,
                                      subtitle: "Total orders",
                                      weight: FontWeight.normal,
                                      size: 12),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Multi(
                                      color: Colors.white,
                                      subtitle: "${to}",
                                      weight: FontWeight.w500,
                                      size: 20)
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Multi(
                                      color: Colors.grey,
                                      subtitle: "Average Order Value",
                                      weight: FontWeight.normal,
                                      size: 12),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Multi(
                                      color: Colors.white,
                                      subtitle: "PKR ${aov}",
                                      weight: FontWeight.w500,
                                      size: 20)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 20.h,),
              Container(
                height: 120.h,
                width: double.infinity,
               color: Color(0xff1E1E1E),
                  child: Padding(
                    padding: const EdgeInsets.all(11),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Multi(
                                  color: Colors.white,
                                  subtitle: "Products",
                                  weight: FontWeight.w500,
                                  size: 15),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Multi(
                                      color: Colors.grey,
                                      subtitle: "Items Sold",
                                      weight: FontWeight.normal,
                                      size: 12),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Multi(
                                      color: Colors.white,
                                      subtitle: "${ti}",
                                      weight: FontWeight.w500,
                                      size: 20)
                                ],
                              ),
                            ),
                          
                          ],
                        ),
                      ],
                    ),
                  ),
              )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
