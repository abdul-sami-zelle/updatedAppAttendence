import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class InternetConnectivityIssue extends StatelessWidget {
  const InternetConnectivityIssue({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 32, 35, 50),
      title:   Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('No Connection',style: TextStyle(color: Colors.white,fontSize: 15),),
        ],
      ),
      content: Container(
        height: 100,
        width: 100,
        child:  Column(
          children: [
           Image.asset("assets/internetIssue.png" , color: Colors.white,height: 45.h,width: 45.w,),
            ElevatedButton(onPressed: (){
              Navigator.of(context).pop();
              // Navigator.push(context,
              //   MaterialPageRoute(builder: (context) => LoginPage()));
            }, 
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff009ae2),
            ),
            
            child: Text('Ok',style: TextStyle(fontSize: 10,color: Colors.white),))
          ],
        ),
      ),
    );

  }
}
