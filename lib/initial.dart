import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:zelleclients/pages/login.dart';
import 'package:zelleclients/provider/provider1.dart';
import 'package:zelleclients/utils/heading3.dart';
import 'package:zelleclients/utils/multiText.dart';
import '../mainInitial.dart';
import '../utils/forgotLink.dart';
import 'attendenceApp.dart/zelleLogin.dart';


class Initial extends StatelessWidget {
  const Initial({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Color(0xff1B1B1B), 
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100.h,
              width: 100.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/logo.png",),
                  fit: BoxFit.contain
                  )
              ),
            ),
            SizedBox(height: 20.h,),
            Container(
                              height: 55.h,
                              width: double.infinity,
                              decoration: BoxDecoration(color: Color.fromARGB(0, 34, 32, 32)),
                              child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Color(0xff009ae2),
                                        Color(0xffb929be)
                                      ]),
                                      borderRadius: BorderRadius.circular(15),
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
                                      onPressed: () {
                                         Navigator.push(
            context, MaterialPageRoute(builder: (context) => LogIn()));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: 18,
                                          bottom: 18,
                                        ),
                                        child: Heading3(head: "Continue as Client"),
                                      ))),
                            ),
              SizedBox(height: 10.h,),
              Container(
                              height: 55.h,
                              width: double.infinity,
                              decoration: BoxDecoration(color: Color.fromARGB(0, 34, 32, 32)),
                              child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Color(0xff009ae2),
                                        Color(0xffb929be)
                                      ]),
                                      borderRadius: BorderRadius.circular(15),
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
                                      onPressed: () {
                                         Navigator.push(
            context, MaterialPageRoute(builder: (context) => ZelleLogIn(extension: '', name: '',)));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: 18,
                                          bottom: 18,
                                        ),
                                        child: Heading3(head: "Continue as Employe"),
                                      ))),
                            )
          ],
        ),
      ),
    );
  }
}