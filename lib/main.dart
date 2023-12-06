import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zelleclients/pages/landingPage.dart';
import 'package:zelleclients/pages/splash.dart';
import 'package:zelleclients/provider/provider1.dart';

import 'attendenceApp.dart/employDashboard.dart';
import 'attendenceApp.dart/zelleLogin.dart';
import 'attendenceApp.dart/companyName.dart';
import 'mainInitial.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final dio = Dio();
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (client) {
    // Disable certificate validation
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return ChangeNotifierProvider(
            create: (context) => Provider1(),
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home:CompanyName()
                //  ZelleLogIn()
                 )
                 ,
          );
        });
  }
}

