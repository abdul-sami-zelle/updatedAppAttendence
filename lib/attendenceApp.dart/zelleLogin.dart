import 'dart:convert';

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
import 'package:zelleclients/provider/provider1.dart';
import 'package:zelleclients/utils/multiText.dart';
import '../mainInitial.dart';
import '../utils/forgotLink.dart';
import 'companyName.dart';
import 'employDashboard.dart';

class ZelleLogIn extends StatefulWidget {
  String? extension;
  String? name;
  ZelleLogIn({super.key,required this.extension,required this.name});

  @override
  State<ZelleLogIn> createState() => _ZelleLogInState();
}

class _ZelleLogInState extends State<ZelleLogIn> {
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
     Future<void> saveUserLoggedInState(bool isLoggedIn) async {
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
  // Get the user's authentication state
    Future<bool> getUserLoggedInState() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      return isLoggedIn;
    }
  

    log_in() async {
      try {
        setState(() {
          value=true;
        });
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: "${username.text}", password: password.text);
        //  Provider11.getDate();
         var data = await FirebaseFirestore.instance.
          collection("Employes").
          doc(userCredential.user!.uid). 
          get();  
        
        Provider11.emp_name=data['name'];
        Provider11.emp_profile=data['aProfile'];
        Provider11.emp_designation=data['designation'];
        Provider11.emp_in=data['in'];
        Provider11.emp_out=data['out'];
        Provider11.emp_shift=data['shift'];
        Provider11.emp_uid=userCredential.user!.uid;
        Provider11.in_last_hour=data['in_last_hour'];
        Provider11.in_last_min = data['in_last_min'];
        Provider11.inHours = data['checkIns'];
        Provider11.type = data['type'];
        var branchType = await FirebaseFirestore.instance.
          collection("constants").
          doc("gllDcmynUMPCi9WZw1l6"). 
          get();  
        Provider11.branchDetails =  data['type'].toString()=="0"?branchType['branch3']:data['type'].toString()=="1"?branchType['branch2']:data['type'].toString()=="2"?branchType['branch1']:{};
        await Provider11.getDay();
        print("${data['checkIns']}--> here is data");

              
        // Obtain shared preferences.
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        // Save an String value to 'action' key.
        await prefs.setString('emp_name', data['name']);
        await prefs.setString('type', data['type']);
        await prefs.setString('emp_profile', data['aProfile']);
        await prefs.setString('emp_designation', data['designation']);
        await prefs.setString('emp_in', data['in']);
        await prefs.setString('emp_out', data['out']);
        await prefs.setString('emp_shift', data['shift']);
        await prefs.setString('emp_uid', userCredential.user!.uid);
        await prefs.setInt('in_last_hour', data['in_last_hour']);
        await prefs.setInt('in_last_min', data['in_last_min']);
        await prefs.setBool('state', _isChecked);
        await prefs.setString('inHours',json.encode(data['checkIns']));
        await prefs.setString('branchDetails',json.encode(Provider11.branchDetails));
        

        await saveUserLoggedInState(_isChecked);

      print("${userCredential.user!.uid} here is uid");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EmployeDashBoard()));
      } on  FirebaseAuthException catch (e) {
         setState(() {
          value=false;
        });
      Fluttertoast.showToast(
        msg: "$e",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
    }
   getD()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
        Provider11.emp_name=prefs.getString('emp_name');
        Provider11.type=prefs.getString('type');
        Provider11.emp_profile=prefs.getString('emp_profile');
        Provider11.emp_designation=prefs.getString('emp_designation');
        Provider11.emp_in=prefs.getString('emp_in');
        Provider11.emp_out=prefs.getString('emp_out');
        Provider11.emp_shift=prefs.getString('emp_shift');
        Provider11.emp_uid=prefs.getString('emp_uid');
        Provider11.in_last_hour=prefs.getInt('in_last_hour');
        Provider11.in_last_min = prefs.getInt('in_last_min');
        Provider11.inHours =jsonDecode(prefs.getString('inHours').toString());
        Provider11.branchDetails =jsonDecode(prefs.getString('branchDetails').toString());
        await Provider11.getDay();
    }
     Future<bool> isUserLoggedIn() async {
      // Get the user's authentication state
      bool isLoggedIn = await getUserLoggedInState();
      if (isLoggedIn==true) {
        getD();
      }
      return isLoggedIn;
    }
   
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return   FutureBuilder<bool>(
      future:isUserLoggedIn() ,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
        if (snapshot.hasData==true&&snapshot.data==true) {
          
          return EmployeDashBoard();
        }else{
          return Scaffold(
           
            body: Stack(
                children: [
                  Container(
                     decoration: new BoxDecoration(
                       color: Colors.white,
          // image:  DecorationImage(
          //   image: ExactAssetImage('assets/bg.jpeg'),
          //   fit: BoxFit.fitHeight,
          //   ),
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
                                  SizedBox(height:50.h),
                                  Row(children: [
                                    Shimmer.fromColors(
                                      baseColor: Color(0xff009ae2),
                                      highlightColor: Color(0xffb929be),
                                      child: Multi(
                                          color: Colors.white,
                                          subtitle: "Hi",
                                          weight: FontWeight.w700,
                                          size: 30),
                                    ),
                                    Container()
                                  ]),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(children: [
                                    Multi(
                                        color: Color(0xff009ae2),
                                        subtitle: "${widget.name} Employee",
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
                            children: [
                              SizedBox(
                                height: 30.h,
                              ),
                              Multi(
                                  color: Colors.white,
                                  subtitle: "Login",
                                  weight: FontWeight.normal,
                                  size: 25),
                              SizedBox(
                                height: 15.h,
                              ),
                              Row(
                                children: [
                                  Multi(
                                      color: Colors.white,
                                      subtitle: "Employe Id",
                                      weight: FontWeight.normal,
                                      size: 15),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: GradientBoxBorder(
                                      gradient: LinearGradient(colors: [
                                        Color(0xff009ae2),
                                        Color(0xffb929be)
                                      ]),
                                      width: 4,
                                    ),
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 8.h, bottom: 8.h, right: 12.w, left: 12.w),
                                  child: TextField(
                                    controller: username,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.normal),
                                    decoration: InputDecoration(
                                      prefixIcon: GradientIcon(
                                        CupertinoIcons.person,
                                        30.0,
                                        LinearGradient(
                                          colors: [
                                            Color(0xff009ae2),
                                            Color(0xffb929be)
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                      hintText: "Employe Id",
                                      hintStyle: TextStyle(
                                          color: Colors.white,
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
                              SizedBox(
                                height: 30.h,
                              ),
                              Row(
                                children: [
                                  Multi(
                                      color: Colors.white,
                                      subtitle: "Password",
                                      weight: FontWeight.normal,
                                      size: 15),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: GradientBoxBorder(
                                      gradient: LinearGradient(colors: [
                                        Color(0xff009ae2),
                                        Color(0xffb929be)
                                      ]),
                                      width: 4,
                                    ),
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 8.h, bottom: 8.h, right: 12.w, left: 12.w),
                                  child: TextField(
                                    controller: password,
                                    obscureText: !this._showPassword,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.normal),
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          Icons.remove_red_eye,
                                          color: this._showPassword
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                        onPressed: () {
                                          setState(() => this._showPassword =
                                              !this._showPassword);
                                        },
                                      ),
                                      prefixIcon: GradientIcon(
                                        Icons.key,
                                        30.0,
                                        LinearGradient(
                                          colors: [
                                            Color(0xff009ae2),
                                            Color(0xffb929be)
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                      hintText: "Password",
                                      hintStyle: TextStyle(
                                          color: Colors.white,
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
                              SizedBox(height: 5.h,),
                           
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                Row(
                                  children: [
                                    ForgotLink(link: "Keep me logged in"),
                                    Checkbox(
                                      checkColor: Colors.white,
                                      focusColor: Colors.red,
                                    fillColor: MaterialStateProperty.all(Color(0xffb929be)),
                                      activeColor: Colors.pink,
                                      value: _isChecked,
                                      onChanged: ( newValue) {
                                        setState(() {
                                          _isChecked = newValue!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                              SizedBox(height: 30.h,),
                              
                              value==false?Container(
                                height: 55.h,
                                width: double.infinity,
                                decoration: BoxDecoration(color: Color.fromARGB(0, 34, 32, 32)),
                                child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Color(0xff009ae2),
                                          Color(0xff009ae2)
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
                                          log_in();
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: 18,
                                            bottom: 18,
                                          ),
                                          child: Text("Log in"),
                                        ))),
                              ):spinkit1,
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
        }
      });
    
    
    

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
        color: index.isEven ?   Color(0xff009ae2) : Color(0xffb929be),
      ),
    );
  },
);

final spinkit1 = SpinKitSpinningLines(
color:Color(0xff009ae2)  ,
);
                                      









                                      