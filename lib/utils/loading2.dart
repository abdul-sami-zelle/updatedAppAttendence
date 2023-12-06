import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zelleclients/pages/login.dart';
import 'package:zelleclients/provider/provider1.dart';
import 'package:zelleclients/utils/multiText.dart';
import 'package:zelleclients/utils/shadowText.dart';



// class Loading2 extends StatelessWidget {
//   const Loading2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Container(
//         color: Colors.black.withOpacity(0.8),
//         height: double.infinity,
//         width: double.infinity,
//         child: Center(
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               color: Colors.white,
//             ),

//             height: 100.h,
//             width: 100.w,
//             child: Padding(
//               padding: const EdgeInsets.all(8),
//               child: SpinKitPouringHourGlass(color: Colors.purple, size: 100,),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';



class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Example App'),
        ),
        body: Center(
          child: ElevatedButton(
            child: Text('Show Loading'),
            onPressed: () {
              EasyLoading.show(status: 'Loading...');
              Future.delayed(Duration(seconds: 3), () {
                EasyLoading.dismiss();
              });
            },
          ),
        ),
      ),
      builder: EasyLoading.init(),
    );
  }
}
