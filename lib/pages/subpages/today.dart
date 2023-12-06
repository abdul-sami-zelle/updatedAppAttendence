import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zelleclients/pages/login.dart';
import 'package:zelleclients/provider/provider1.dart';
import 'package:zelleclients/utils/multiText.dart';
import 'package:flutter/material.dart';

class TodayReport extends StatelessWidget {
  const TodayReport({super.key});

  @override
  Widget build(BuildContext context) {
    final Provider11 = Provider.of<Provider1>(context);
    var orders;
    Dayvise() async {
      try {
        final dio = Dio();
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (client) {
    // Disable certificate validation
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };
       
        String ck = Provider11.ck.toString();
        String cs = Provider11.cs.toString();
        String base = Provider11.base.toString();
        String url =
            'https://${base}/wp-json/wc/v3/reports/sales?consumer_key=${ck}&consumer_secret=${cs}';
        Response response = await dio.get(url);
        orders = response.data;
        // print("${orders![0]['totals'].keys}");
      } catch (e) {
        print("${e} error is here");
      }
    }

    return FutureBuilder(
      future: Dayvise(),
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
           return Container(
            color:Color(0xff1E1E1E) ,
            height: double.infinity,
            width: double.infinity,
            child: Center(
              child: spinkit1,
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
         
            return Container(
              height: double.infinity,
              width: double.infinity,
              color: Color(0xff1E1E1E),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Multi(
                        color: Colors.grey,
                        subtitle: "${orders![0]['totals'].keys.toString()}",
                        weight: FontWeight.w600,
                        size: 14),
                    SizedBox(
                      height: 15.h,
                    ),
                    Multi(
                        color: Colors.white,
                        subtitle: "PKR ${orders![0]['net_sales'].toString()}",
                        weight: FontWeight.w500,
                        size: 40),
                    SizedBox(
                      height: 5.h,
                    ),
                    Multi(
                        color: Colors.grey,
                        subtitle: "Revenue",
                        weight: FontWeight.w600,
                        size: 10),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Multi(
                                color: Colors.white,
                                subtitle: "${orders![0]['total_orders'].toString()}",
                                weight: FontWeight.w500,
                                size: 20),
                            SizedBox(
                              height: 5.h,
                            ),
                            Multi(
                                color: Colors.white,
                                subtitle: "Orders",
                                weight: FontWeight.w600,
                                size: 10),
                          ],
                        ),
                        Column(
                          children: [
                            Multi(
                                color: Colors.white,
                                subtitle: "${orders![0]['total_customers'].toString()}",
                                weight: FontWeight.w500,
                                size: 20),
                            SizedBox(
                              height: 5.h,
                            ),
                            Multi(
                                color: Colors.white,
                                subtitle: "Visitors",
                                weight: FontWeight.w600,
                                size: 10),
                          ],
                        ),
                        Column(
                          children: [
                            Multi(
                                color: Colors.white,
                                subtitle: "0%",
                                weight: FontWeight.w500,
                                size: 20),
                            SizedBox(
                              height: 5.h,
                            ),
                            Multi(
                                color: Colors.white,
                                subtitle: "Conversions",
                                weight: FontWeight.w600,
                                size: 10),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 70.h,),
                    Container(
                      child: Center(
                        child: Multi(color: Colors.white, subtitle: "No revenue this period", weight: FontWeight.bold, size: 15),
                      ),
                    )
                    
                  ],
                ),
              ),
            );
        
        }
        return Text("");
      },
    );
  }
}
