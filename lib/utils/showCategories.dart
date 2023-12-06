import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zelleclients/utils/multiText.dart';
import 'package:zelleclients/utils/shadowText.dart';

class ShowCategory extends StatelessWidget {
  String imgAddress;
  String title;
  ShowCategory({super.key,required this.imgAddress,required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(12),
      child: Container(
        height: 200.h,
        width: double.infinity,
        
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white,width: 1.h),
          borderRadius: BorderRadius.circular(15.r)
        ),
        child: Stack(children: <Widget>[
          Container(
            height: 200.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: NetworkImage(
                    '$imgAddress'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
          Container(
            height: 200.h,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15.r)),
            child: Center(
              child: ShadowText(
                  shadowColor: Colors.black,
                  color: Colors.white,
                  subtitle: "$title",
                  weight: FontWeight.w600,
                  size: 30),
            ),
          ),
        ]),
      ),
    );
  }
}
