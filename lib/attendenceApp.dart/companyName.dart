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
import 'package:zelleclients/attendenceApp.dart/zelleLogin.dart';
import 'package:zelleclients/provider/provider1.dart';
import 'package:zelleclients/utils/multiText.dart';
import '../mainInitial.dart';
import '../utils/forgotLink.dart';
import 'employDashboard.dart';

class CompanyName extends StatefulWidget {
  const CompanyName({super.key});

  @override
  State<CompanyName> createState() => _CompanyNameState();
}

class _CompanyNameState extends State<CompanyName> {
  bool value = false;
  final username = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  late bool _passwordVisible;
  void initState() {
    _passwordVisible = false;
  }

  bool _isChecked = false;
  bool _showPassword = false;
  Widget build(BuildContext context) {
    final Provider11 = Provider.of<Provider1>(context);

    // Save the user's authentication state
    Future<void> saveUserLoggedInState(bool isLoggedIn) async {}
    void logoutUser() async {}
    // Get the user's authentication state

    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Stack(
            children: [
              Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                  // image: new DecorationImage(
                  //   image: ExactAssetImage('assets/bg.jpeg'),
                  //   fit: BoxFit.fitHeight,
                  // ),
                ),
                height: double.infinity,
                width: double.infinity,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 20.h),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(children: [
                                Shimmer.fromColors(
                                  baseColor: Color(0xff009ae2),
                                  highlightColor: Color(0xffb929be),
                                  child: Multi(
                                      color: Colors.white,
                                      subtitle: "Welcome To",
                                      weight: FontWeight.w700,
                                      size: 30),
                                ),
                                Container()
                              ]),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(children: [
                                Shimmer.fromColors(
                                  baseColor: Color(0xff009ae2),
                                  highlightColor: Color(0xffb929be),
                                  child: Multi(
                                      color: Colors.white,
                                      subtitle: "Attendence App",
                                      weight: FontWeight.w700,
                                      size: 30),
                                ),
                                Container()
                              ]),
                              SizedBox(
                                height: 15.h,
                              ),
                              Row(children: [
                                Multi(
                                    color: Color(0xff009ae2),
                                    subtitle: "Powered By Zelle Solutions",
                                    weight: FontWeight.w700,
                                    size: 18),
                                Container()
                              ]),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff1B1B1B),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r),
                      )),
                  height: height / 1.4,
                  width: double.infinity,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            height: 55.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(0, 34, 32, 32)),
                            child: DecoratedBox(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Color(0xff009ae2),
                                      Color(0xff009ae2)
                                    ]),
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.57),
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
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ZelleLogIn(extension: '@zellesolutions.com', name: 'Zelle Solutions',)));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: 18,
                                        bottom: 18,
                                      ),
                                      child: Text("Zelle Solutions"),
                                    ))),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            height: 55.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(0, 34, 32, 32)),
                            child: DecoratedBox(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Color(0xff009ae2),
                                      Color(0xff009ae2)
                                    ]),
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.57),
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
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ZelleLogIn(extension: '@nexzell.com', name: 'Nexzell',)));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: 18,
                                        bottom: 18,
                                      ),
                                      child: Text("Nexzell"),
                                    ))),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            height: 55.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(0, 34, 32, 32)),
                            child: DecoratedBox(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Color(0xff009ae2),
                                      Color(0xff009ae2)
                                    ]),
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.57),
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
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ZelleLogIn(extension: '@nexit360.com', name: 'Nexit360',)));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: 18,
                                        bottom: 18,
                                      ),
                                      child: Text("Nexit360"),
                                    ))),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GradientIcon extends StatelessWidget {
  GradientIcon(
    this.icon,
    this.size,
    this.gradient,
  );

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}

final spinkit = SpinKitFadingCircle(
  itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: index.isEven ? Color(0xff009ae2) : Color(0xffb929be),
      ),
    );
  },
);

final spinkit1 = SpinKitSpinningLines(
  color: Color(0xff009ae2),
);
