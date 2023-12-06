import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
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
import '../utils/empDashboardCircle.dart';
import '../utils/forgotLink.dart';
import '../utils/heading2.dart';
import 'dart:math' as math;

class NeonButton extends StatefulWidget {
  VoidCallback  click;
  String? txt;
  NeonButton({super.key,required this.click,required this.txt});

  @override
  State<NeonButton> createState() => _NeonButtonState();
}

class _NeonButtonState extends State<NeonButton> {
  @override
 bool ispressed = true;
  Widget build(BuildContext context) {
    Color shadowColor = Color(0xffb929be);
    return Container(
      height: 40.h,
      width: 130.w,
      child: Listener(
        onPointerDown: (_) => setState(() {
          ispressed=true;
        }),
         onPointerUp: (_) => setState(() {
          ispressed=false;
        }),
        child: Container(
         
          child: Container(
           
            child: TextButton(
              onHover: (hovered){
                setState(() {
                  this.ispressed=hovered;
                });
              },
              style: TextButton.styleFrom(
                side: BorderSide(color: Color(0xff009ae2),width: 2),
                
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
              onPressed:widget.click,
              child:  Text(
              "${widget.txt}",
              
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.white,
                shadows: [
                  for(double i = 1;i<(ispressed?8:4);i++)
                  Shadow(
                    color: shadowColor,
                    blurRadius: 3*i,
                    // inset:true
                  )
                ]
              ),
            ),),
          )
        ),
      ),
    );
  }
}