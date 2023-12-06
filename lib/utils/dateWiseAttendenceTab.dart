import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zelleclients/utils/multiText.dart';

class AttendenceBox extends StatelessWidget {
  String? checkin;
  String? checkout;
  String? hours;
  String? dates;
  String? status;
  AttendenceBox({super.key,required this.checkin,required this.checkout,required this.hours,required this.dates,required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 10.h),
      child: Container(
        height: 100.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border(
            left: BorderSide(color:status=="early"?Colors.green:status=="late"?Colors.red:Colors.blue,width: 2)
          )
        ),
        child: Padding(
          padding:EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Multi(color: Colors.white, subtitle: "$dates", weight: FontWeight.w500, size: 13),
                  Container(
                    
                    width: 60.w,
                    decoration: BoxDecoration(
                      color: status=="early"?Colors.green.withOpacity(0.3):status=="late"?Colors.red.withOpacity(0.3):Colors.blue.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(vertical: 5.h),
                      child: Center(
                        child: Multi(color: Colors.white, subtitle: "$status", weight: FontWeight.normal, size: 12),
                      ),
                    ) ,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Multi(color: Colors.grey, subtitle: "Check In", weight: FontWeight.bold, size: 10),
                      SizedBox(height: 5,),
                      Multi(color: Colors.grey, subtitle: "$checkin", weight: FontWeight.normal, size: 14),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Multi(color: Colors.grey, subtitle: "Check Out", weight: FontWeight.bold, size: 10),
                      SizedBox(height: 5,),
                      Multi(color: Colors.grey, subtitle: "$checkout", weight: FontWeight.normal, size: 14),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Multi(color: Colors.grey, subtitle: "Total Time", weight: FontWeight.bold, size:10),
                      SizedBox(height: 5,),
                      Multi(color: Colors.grey, subtitle: "${hours}", weight: FontWeight.normal, size: 14),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class LoadingAttendenceTab extends StatelessWidget {
  const LoadingAttendenceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 10.h),
      child: Container(
        height: 100.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
         
        ),
        child: Padding(
          padding:EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Shimmer.fromColors(
                        child: Padding(
                         padding:  EdgeInsets.only(bottom: 10.h),
                          child: Container(
                             height: 10.h,
                              width: 40.w,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 157, 221, 214),
                                borderRadius: BorderRadius.circular(1.r)),
                            child: Multi(color: Colors.white, subtitle: "", weight: FontWeight.w500, size: 13),
                          ),
                          
                        ),
                        baseColor: Colors.black,
                        highlightColor: const Color.fromARGB(255, 80, 79, 79),
                      ),
                  Shimmer.fromColors(
                        child: Padding(
                         padding:  EdgeInsets.only(bottom: 10.h),
                          child: Container(
                             height: 10.h,
                              width: 40.w,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 157, 221, 214),
                                borderRadius: BorderRadius.circular(1.r)),
                            child: Multi(color: Colors.white, subtitle: "", weight: FontWeight.w500, size: 13),
                          ),
                          
                        ),
                        baseColor: Colors.black,
                        highlightColor: const Color.fromARGB(255, 80, 79, 79),
                      ),
                 Shimmer.fromColors(
                        child: Padding(
                         padding:  EdgeInsets.only(bottom: 10.h),
                          child: Container(
                             height: 10.h,
                              width: 40.w,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 157, 221, 214),
                                borderRadius: BorderRadius.circular(1.r)),
                            child: Multi(color: Colors.white, subtitle: "", weight: FontWeight.w500, size: 13),
                          ),
                          
                        ),
                        baseColor: Colors.black,
                        highlightColor: const Color.fromARGB(255, 80, 79, 79),
                      ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        child: Padding(
                         padding:  EdgeInsets.only(bottom: 10.h),
                          child: Container(
                             height: 10.h,
                              width: 40.w,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 157, 221, 214),
                                borderRadius: BorderRadius.circular(1.r)),
                            child: Multi(color: Colors.white, subtitle: "", weight: FontWeight.w500, size: 13),
                          ),
                          
                        ),
                        baseColor: Colors.black,
                        highlightColor: const Color.fromARGB(255, 80, 79, 79),
                      ),
                      SizedBox(height: 5,),
                      Shimmer.fromColors(
                        child: Padding(
                         padding:  EdgeInsets.only(bottom: 10.h),
                          child: Container(
                             height: 10.h,
                              width: 60.w,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 157, 221, 214),
                                borderRadius: BorderRadius.circular(1.r)),
                            child: Multi(color: Colors.white, subtitle: "", weight: FontWeight.w500, size: 13),
                          ),
                          
                        ),
                        baseColor: Colors.black,
                        highlightColor: const Color.fromARGB(255, 80, 79, 79),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        child: Padding(
                         padding:  EdgeInsets.only(bottom: 10.h),
                          child: Container(
                             height: 10.h,
                              width: 40.w,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 157, 221, 214),
                                borderRadius: BorderRadius.circular(1.r)),
                            child: Multi(color: Colors.white, subtitle: "", weight: FontWeight.w500, size: 13),
                          ),
                          
                        ),
                        baseColor: Colors.black,
                        highlightColor: const Color.fromARGB(255, 80, 79, 79),
                      ),
                      SizedBox(height: 5,),
                      Shimmer.fromColors(
                        child: Padding(
                         padding:  EdgeInsets.only(bottom: 10.h),
                          child: Container(
                             height: 10.h,
                              width: 60.w,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 157, 221, 214),
                                borderRadius: BorderRadius.circular(1.r)),
                            child: Multi(color: Colors.white, subtitle: "", weight: FontWeight.w500, size: 13),
                          ),
                          
                        ),
                        baseColor: Colors.black,
                        highlightColor: const Color.fromARGB(255, 80, 79, 79),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        child: Padding(
                         padding:  EdgeInsets.only(bottom: 10.h),
                          child: Container(
                             height: 10.h,
                              width: 40.w,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 157, 221, 214),
                                borderRadius: BorderRadius.circular(1.r)),
                            child: Multi(color: Colors.white, subtitle: "", weight: FontWeight.w500, size: 13),
                          ),
                          
                        ),
                        baseColor: Colors.black,
                        highlightColor: const Color.fromARGB(255, 80, 79, 79),
                      ),
                      SizedBox(height: 5,),
                      Shimmer.fromColors(
                        child: Padding(
                         padding:  EdgeInsets.only(bottom: 10.h),
                          child: Container(
                             height: 10.h,
                              width: 60.w,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 157, 221, 214),
                                borderRadius: BorderRadius.circular(1.r)),
                            child: Multi(color: Colors.white, subtitle: "", weight: FontWeight.w500, size: 13),
                          ),
                          
                        ),
                        baseColor: Colors.black,
                        highlightColor: const Color.fromARGB(255, 80, 79, 79),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
    
    
    
     Shimmer.fromColors(
                        child: Padding(
                         padding:  EdgeInsets.only(bottom: 10.h),
                          child: Container(
                             height: 100.h,
                              width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 157, 221, 214),
                                borderRadius: BorderRadius.circular(5.r)),
                          ),
                        ),
                        baseColor: Colors.black,
                        highlightColor: const Color.fromARGB(255, 80, 79, 79),
                      );
  }
}