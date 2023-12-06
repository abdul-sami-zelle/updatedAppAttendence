import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Heading4 extends StatelessWidget {
  String? head;
   Heading4({super.key,required this.head});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("$head",
      style:GoogleFonts.montserrat(
        textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontSize: 12.sp),
      ),
      textAlign: TextAlign.center,
    ) );
  }
}