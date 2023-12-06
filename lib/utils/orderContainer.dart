import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zelleclients/utils/multiText.dart';

class OrderContainer extends StatelessWidget {
   String? dt;
   String? oi;
   String? status;
   String? name;
   String? price;
   OrderContainer({super.key,required this.dt,required this.oi,required this.status,required this.name,required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: double.infinity,
      color:Color.fromRGBO(30, 30, 30, 1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Multi(color: Colors.grey, subtitle: "$dt", weight: FontWeight.bold, size: 10),
            SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Multi(color: Colors.white, subtitle: "$oi", weight: FontWeight.normal, size: 12),
                  Container(
                    width: 120.w,
                    child: Multi(color: Colors.white, subtitle: "$name", weight: FontWeight.normal, size: 12),
                  ),
                  Multi(color: Colors.white, subtitle: "PKR ${price}", weight: FontWeight.normal, size: 12),
                ],
              ),
            ),
            Container(
              height: 20.h,
              width: 80.w,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 157, 221, 214),
                borderRadius: BorderRadius.circular(5.r)
              ),
              child: Center(child: Multi(color: Color(0xff1E1E1E), subtitle: "$status", weight: FontWeight.normal, size: 10)),
            )
          ],
        ),
      ),
    );
  }
}