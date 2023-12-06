import 'package:analog_clock/analog_clock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
import 'package:zelleclients/utils/neonButton.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import '../../utils/atndncHistory.dart';
import '../../utils/numbersMulti.dart';
import '../clock/clock_view.dart';



class AtendenceHistoryDay extends StatefulWidget {
  @override
  _AtendenceHistoryDayState createState() => _AtendenceHistoryDayState();
}

class _AtendenceHistoryDayState extends State<AtendenceHistoryDay> {



  @override
  Widget build(BuildContext context) {
        final Provider11 = Provider.of<Provider1>(context, listen: true);
    var data2 ;
    DatabaseReference ref = FirebaseDatabase.instance
        .ref("attendence_test/${Provider11.formattedMonth}/${Provider11.emp_shift}");
    return Scaffold(
      backgroundColor: Color(0xff1B1B1B),
      appBar: AppBar(
        title: Text("Your Attendence History"),
      ),
      body: 
      Center(
        child: StreamBuilder(
          stream: ref.onValue,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data.snapshot.value;
              var keys = data.keys.toList();
              return 
              ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: (){
                      print(keys);
                    },
                    child: AtendenceHist(
                      checkin: data[keys[index]][Provider11.emp_uid]['checkin'].toString(),
                      checkout:data[keys[index]][Provider11.emp_uid]['checkout'].toString(), date: keys[index].toString(),
                      ),
                  ),
                );
              },
            );
             
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
