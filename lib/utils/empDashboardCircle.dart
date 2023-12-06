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
import 'package:zelleclients/provider/provider1.dart';
import 'package:zelleclients/utils/multiText.dart';
import '../mainInitial.dart';
import '../utils/forgotLink.dart';
import '../utils/heading2.dart';
import 'dart:math' as math;

class CircleEmployDashBoard extends StatelessWidget {
  String? img;
  String? txt;
  
  CircleEmployDashBoard({
    super.key,
    required this.img,
    required this.txt
  });

  @override
  Widget build(BuildContext context) {



    return Container(
       height: 100.h,
       width: 140.w,
      child: Row(
        
        children: [
          Container(
            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xff009ae2),
                  Color(0xffb929be)
                ]
              ),
             boxShadow: [
              BoxShadow(  
                offset: Offset(-1, -1),
                blurRadius: 10,
                color: Color(0xff009ae2),
              )
             ]
            ),
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Container(
                height: 100.h,
                width: 100.w,
                decoration: BoxDecoration(
                   image: DecorationImage(image: AssetImage("$img"),fit: BoxFit.contain)
                ),
              ),
            ),
          ),
          SizedBox(width: 6.w,),
          Multi(color: Colors.white, subtitle: "$txt", weight: FontWeight.bold, size: 10)
        ],
      ),
    );
  }
}