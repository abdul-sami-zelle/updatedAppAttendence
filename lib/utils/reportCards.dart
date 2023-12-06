import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zelleclients/utils/multiText.dart';

class ReportCards extends StatelessWidget {
  String? imgAddress;
  String? value;
  String? heading;
  String? subHeading;
  ReportCards({super.key,required this.imgAddress,required this.value,required this.heading,required this.subHeading});

  @override



  
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Container(
        height: 100.h,
      width: size.width/2.5,
      decoration: BoxDecoration(
          color: Color(0xff1F2123), borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding:EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Multi(color: Colors.white, subtitle: "${value.toString()=="null"?"00":value}", weight: FontWeight.bold, size: 26),
                    Multi(color: Colors.green, subtitle: "$subHeading", weight: FontWeight.normal, size: 9.5),
                  ],
                ),
                Container(
                  height: 30.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black
                  ),
                  child: Padding(
                    padding:EdgeInsets.all(5),
                    child: Image.asset("$imgAddress",height: 25,width: 25,color: Color(0xff424344),),
                  ),
                ),
      
              ],
            ),
            SizedBox(height: 20,),
            Multi(color: Colors.white, subtitle: "$heading", weight: FontWeight.bold, size: 10)
          ],
        ),
      ),
    );
  }
}

class ReportLoader extends StatelessWidget {
  const ReportLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Shimmer.fromColors(
                   child: Container(
        height: 100.h,
      width: size.width/2.5,
      decoration: BoxDecoration(
          color: Color(0xff1F2123), borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding:EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
          ],
        ),
      ),
    ),
                   baseColor: Color.fromARGB(255, 39, 40, 40),
                   highlightColor: Color.fromARGB(255, 99, 98, 98),
                 );
   ;
  }
}