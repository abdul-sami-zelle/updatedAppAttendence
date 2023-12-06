import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ShadowText extends StatelessWidget {
  Color color;
  Color shadowColor;
  String subtitle;
  FontWeight weight;
  double size;
  ShadowText({super.key,required this.color,required this.shadowColor,required this.subtitle,required this.weight,required this.size});


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
  subtitle,
  textAlign: TextAlign.center,
  style: GoogleFonts.lato(
    textStyle: TextStyle(
      color: color, 
      letterSpacing: .5,
      fontSize: size.sp,
      fontWeight: weight,
      shadows: [
      Shadow(
        offset: Offset(2.0, 2.0),
        blurRadius: 3.0,
        color: shadowColor,
        ),
      ],
      ),
      
  ),
),
    );
  }
}