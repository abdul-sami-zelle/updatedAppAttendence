import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zelleclients/provider/provider1.dart';
import 'package:zelleclients/utils/multiText.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Container(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10.h,),
                        CircleAvatar(),
                        SizedBox(height: 15.h,),
                         Shimmer.fromColors(
                                      baseColor: Color(0xff009ae2),
                                      highlightColor: Color(0xffb929be),
                                      child: Multi(
                                          color: Colors.white,
                                          subtitle: "Abdul Sami",
                                          weight: FontWeight.w700,
                                          size: 30),
                                    ),
                      ],
                    ),
                    SizedBox(height: 20.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Multi(color: Colors.white, subtitle: "Employe Id", weight: FontWeight.normal, size: 14),
                        Multi(color: Colors.white, subtitle: "1291", weight: FontWeight.bold, size: 14),
                      ],
                    ),
                    SizedBox(height: 15.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Multi(color: Colors.white, subtitle: "Department", weight: FontWeight.normal, size: 14),
                        Multi(color: Colors.white, subtitle: "Web/App Department", weight: FontWeight.bold, size: 14),
                      ],
                    ),
                    SizedBox(height: 15.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Multi(color: Colors.white, subtitle: "Designation", weight: FontWeight.normal, size: 14),
                        Multi(color: Colors.white, subtitle: "Team Lead", weight: FontWeight.bold, size: 14),
                      ],
                    ),
                    SizedBox(height: 15.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Multi(color: Colors.white, subtitle: "Contact", weight: FontWeight.normal, size: 14),
                        Multi(color: Colors.white, subtitle: "3171707283", weight: FontWeight.bold, size: 14),
                      ],
                    ),
                    SizedBox(height: 15.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Multi(color: Colors.white, subtitle: "Shift", weight: FontWeight.normal, size: 14),
                        Multi(color: Colors.white, subtitle: "Morning", weight: FontWeight.bold, size: 14),
                      ],
                    ),
                    SizedBox(height: 15.h,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Multi(color: Colors.white, subtitle: "Timing", weight: FontWeight.normal, size: 14),
                        Multi(color: Colors.white, subtitle: "8AM - 5PM", weight: FontWeight.bold, size: 14),
                      ],
                    ),
                    SizedBox(height: 15.h,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Multi(color: Colors.white, subtitle: "DOB", weight: FontWeight.normal, size: 14),
                        Multi(color: Colors.white, subtitle: "17-October-2000", weight: FontWeight.bold, size: 14),
                      ],
                    ),
                    SizedBox(height: 15.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Multi(color: Colors.white, subtitle: "Date of Joining", weight: FontWeight.normal, size: 14),
                        Multi(color: Colors.white, subtitle: "2nd-Jan-2023", weight: FontWeight.bold, size: 14),
                      ],
                    ),
                    SizedBox(height: 15.h,),
              
                  ],
                ),
              ),
            ),
                        Positioned(
              top: 5.h,
              left: -2.w,
              child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          elevation: 0, // Remove the built-in shadow
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: Size(30.h, 30.w),
                        ),
                        child:Container(
                          height: 50.h,
                          // width: 30.w,
                         child: Column(
                          children: [
                            Image.asset("assets/back.png",color: Colors.white,height: 30.h,width: 30.w,),
                            // // SizedBox(height: 1.h,),
                            // Multi(color: Colors.white, subtitle: "Back", weight: FontWeight.w600, size: 10)
                          ],
                         ),
                        )
                      ),)
          ],
        ),
      ),
    );
  }
}



class CircleAvatar extends StatelessWidget {
  const CircleAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Provider11 = Provider.of<Provider1>(context, listen: true);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: -10,
          bottom: -10,
          child: Container(
            height: size.height / 4,
            width: size.height / 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
              border: Border.all(width: 1, color: Colors.white),
              shape: BoxShape.rectangle,
            ),
          ),
        ),
        Positioned(
          right: -4,
          bottom: -4,
          child: Container(
            height: size.height / 4,
            width: size.height / 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
              color: Color(0xff1F2123),
              shape: BoxShape.rectangle,
            ),
          ),
        ),
        Container(
          height: size.height / 4,
          width: size.height / 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
            image: DecorationImage(
                image: NetworkImage("https://res.cloudinary.com/diecwxxmm/image/upload/v1697084087/zellesolutions%20portal/nh5ub0ynyfwvi5c9wnac.jpg"),
                fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }
}