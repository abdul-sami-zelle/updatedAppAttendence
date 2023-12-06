
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' show get;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:http/http.dart' show get;
import 'package:zelleclients/provider/provider1.dart';
import 'package:zelleclients/utils/multiText.dart';
import 'package:zelleclients/utils/reportCards.dart';




class Reports extends StatefulWidget {
   Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
String _selectedValue =  DateFormat('MMMM yyyy').format(DateTime.now());

String? statusCategorization(String dailyArrival,String? scheduledArrival) {
 

  String arrivalCategory = categorizeArrival(scheduledArrival!, dailyArrival);
  return arrivalCategory;
}

String categorizeArrival(String actualArrivalTime, String dailyArrival) {
  // Parse the actual and daily arrival times
  DateFormat format = DateFormat("hh:mm:ss a");
  DateTime actualTime = format.parse(actualArrivalTime);

  // Extract hours, minutes, and seconds from the daily arrival
  List<String> dailyArrivalParts = dailyArrival.split(":");
  int dailyHours = int.parse(dailyArrivalParts[0]);
  int dailyMinutes = int.parse(dailyArrivalParts[1]);
  int dailySeconds = int.parse(dailyArrivalParts[2]);

  // Create a DateTime object for the daily arrival time
  DateTime dailyTime = DateTime(
    actualTime.year,
    actualTime.month,
    actualTime.day,
    dailyHours,
    dailyMinutes,
    dailySeconds,
  );

  // Define a threshold of 15 minutes
  Duration lateThreshold = Duration(minutes: 15);

  // Calculate the time difference
  Duration timeDifference = dailyTime.difference(actualTime);

  if (timeDifference > lateThreshold) {
    lateArrival.add(double.parse(timeDifference.inMinutes.toString()));
    late15min.add(0);
    onTimemArrival.add(0);
    return timeDifference.inMinutes.toString();
  } 
  else if(timeDifference <= lateThreshold && timeDifference>Duration(minutes: 0,hours: 0,seconds: 0)){
    lateArrival.add(0);
    onTimemArrival.add(0);
    late15min.add(double.parse(timeDifference.inMinutes.toString()));
    return timeDifference.inMinutes.toString();
  }
  else {
    print(timeDifference);
    lateArrival.add(0);
    late15min.add(0);
    onTimemArrival.add(double.parse(timeDifference.inMinutes<0?(timeDifference.inMinutes*-1).toString():timeDifference.inMinutes.toString()));
    return timeDifference.inMinutes.toString();
  }
}

late GlobalKey<SfCircularChartState> _cartesianChartKey;

late GlobalKey<SfCircularChartState> _cartesianChartKeyRadial;

late GlobalKey<SfCartesianChartState> _cartesianChartKeyColumn;

List<int>? imgGraph;
List<int>? imgGraph2;
List<int>? imgGraph3;

   Future<List?> _renderChartAsImage() async {
  final double pixelRatio = 2.0; // Try using a lower pixel ratio (e.g., 2.0)
  final ui.Image data = await _cartesianChartKey.currentState!.toImage(pixelRatio: pixelRatio);
  final ui.Image data2 = await _cartesianChartKeyRadial.currentState!.toImage(pixelRatio: pixelRatio);
  final ui.Image data3 = await _cartesianChartKeyColumn.currentState!.toImage(pixelRatio: pixelRatio);
  final ByteData? bytes = await data.toByteData(format: ui.ImageByteFormat.png);
  final ByteData? bytes2 = await data2.toByteData(format: ui.ImageByteFormat.png);
  final ByteData? bytes3 = await data3.toByteData(format: ui.ImageByteFormat.png);
  final Uint8List imageBytes = bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
  final Uint8List imageBytes2 = bytes2!.buffer.asUint8List(bytes2.offsetInBytes, bytes2.lengthInBytes);
  final Uint8List imageBytes3 = bytes3!.buffer.asUint8List(bytes3.offsetInBytes, bytes3.lengthInBytes);
  imgGraph=imageBytes;
  imgGraph2=imageBytes2;
  imgGraph3=imageBytes3;
  return imageBytes;
}

List<double> lateArrival = [];

List<double> onTimemArrival = [];

List<double> late15min = [];

int index = 0; 

var attenData = [];

var attenDates = [];



String? totalTime;

String? totalLate;

String? totalEarly;

String? onTime;



  List<AttendanceChartData1> graphData = [];


List<Timings> attendanceDataPdf = [];

  Widget build(BuildContext context) {
_cartesianChartKey = GlobalKey();
_cartesianChartKeyRadial = GlobalKey();
_cartesianChartKeyColumn = GlobalKey();
    final size = MediaQuery.of(context).size;
     final Provider11 = Provider.of<Provider1>(context, listen: true);



List<DougnutChartData> categoryChart = [

];


 cleanAllData(){
  setState(() {
      index=0;
  attendanceDataPdf = [];
  graphData = [];
  attenData = [];
  lateArrival = [];
  onTimemArrival = [];
  late15min = [];
  attenDates = [];
  });
 }
      Future fetchFireBaseData()async{
 await Provider11.getActualCheckInCurrentMonth(Provider11.emp_uid!,_selectedValue.toString());
 var dataFinal = {};
       index=0;
  attendanceDataPdf = [];
  graphData = [];
  attenData = [];
  lateArrival = [];
  onTimemArrival = [];
  late15min = [];
  attenDates = [];
  // await Future.delayed(Duration(seconds: 3));
  final ref = FirebaseDatabase.instance.ref();
final snapshot = await ref.child('attendence/${_selectedValue}/${Provider11.emp_shift}').get();
if (snapshot.exists) {
  final Map<String, dynamic> data =Provider11.convertSnapshotValue(snapshot.value);
  print("data is ${data}");
    // Initialize an empty Map to store the data for the specified UID
    final Map<String, dynamic> uidData = {};
    
    // Specify the UID you want to retrieve
    

    // Loop through the data and extract data for the desired UID
    data.forEach((date, dateData) {
      if (dateData.containsKey(Provider11.emp_uid)) {
        index++;
       
        uidData[date] = dateData[Provider11.emp_uid];
       
        // print('${Provider11.octoberDates[date].toString()} here are dates');


        uidData[date]['checkin']==null?index--:graphData.add(AttendanceChartData1(x: date, y:statusCategorization(uidData[date]['checkin'],Provider11.octoberDates[date].toString()), early: onTimemArrival[index-1], late: lateArrival[index-1], late15:late15min[index-1]));
      }
    });
    print("${uidData} data is herere");
    DateTime parseDate(String dateStr) {
    final parts = dateStr.split('-');
    if (parts.length == 3) {
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      return DateTime(year, month, day);
    }
    return DateTime(0); // Return a default value for invalid dates.
  }
   graphData.sort((a, b) {
      final aDate = parseDate(a.x);
      final bDate = parseDate(b.x);
      return aDate.compareTo(bDate);
    });
    final Map<String, dynamic> finalData = Provider11.sorting(uidData);
    for (var i = 0; i < finalData.length; i++) {
      print("${finalData.keys.toList()[i]} ---> ${i}");
        attendanceDataPdf.add(Timings(checkin:finalData.values.toList()[i]['checkin']==null?"null":finalData.values.toList()[i]['checkin'], checkout:finalData.values.toList()[i]['checkout']==null?"null":finalData.values.toList()[i]['checkout'], date:finalData.keys.toList()[i].toString(), workingHours:finalData.values.toList()[i]['checkin']==null||finalData.values.toList()[i]['checkout']==null?"00:00:00": Provider11.getTimeDifference(finalData.values.toList()[i]['checkin'].toString(),finalData.values.toList()[i]['checkout'].toString()), status:finalData.values.toList()[i]['checkin']==null?"00:00:00": Provider11.statusCategorization2(finalData.values.toList()[i]['checkin'].toString(),finalData.keys.toList()[i].toString()), serial: i+1));

    }
    // Print the extracted data for the specified UID
    attenData=finalData.values.toList();
    attenDates = finalData.keys.toList();
    dataFinal =finalData;
    print(lateArrival);
    print(onTimemArrival);
    print(late15min);

    for (var i = 0; i < graphData.length; i++) {
      print("${graphData[i].early}  ${graphData[i].late}  ${graphData[i].late15} ${graphData[i].x}");
    }
   












    int totalHours = 0;
  int totalMinutes = 0;
  int totalSeconds = 0;



  for (int i = 0; i < attendanceDataPdf.length; i++) {
    String timeString = attendanceDataPdf[i].workingHours!;
    List<String> timeParts = timeString.split(':');
    if (timeParts.length == 3) {
      int hours = int.parse(timeParts[0]);
      int minutes = int.parse(timeParts[1]);
      int seconds = int.parse(timeParts[2]);

      totalHours += hours;
      totalMinutes += minutes;
      totalSeconds += seconds;
    } else {
      print('Invalid time format for element $i: $timeString');
    }
  }

  // Adjust totalMinutes and totalSeconds for overflow
  totalMinutes += totalSeconds ~/ 60;
  totalSeconds %= 60;
  totalHours += totalMinutes ~/ 60;
  totalMinutes %= 60;
   double fractionalHours = totalHours + (totalMinutes / 60.0);

 totalTime ='${fractionalHours.toStringAsFixed(1)}';

  print('Total Time: $totalHours hours, $totalMinutes minutes, $totalSeconds seconds');
    
} else {
    print('No data available.');
}

  // Create a Map to store the counts
  Map<String, int> countMap = {};

  for (int i = 0; i < attendanceDataPdf.length; i++) {
    String? status = attendanceDataPdf[i].status!;
   if (status != null) {
      countMap[status] = (countMap[status] ?? 0) + 1;
    }
  }
  print(countMap);
  // Print the counts
  countMap.forEach((status, count) {
    print('$status: $count');
  });

  onTime = countMap['on Time'].toString();
  totalEarly = countMap['early'].toString();
  totalLate = countMap['late'].toString();
    categoryChart = [
  DougnutChartData("on Time", onTime.toString()=="null"?0:int.parse(onTime.toString()), Color.fromRGBO(13, 81, 139, 1)),
  DougnutChartData("Early", totalEarly.toString()=="null"?0:int.parse(totalEarly.toString()), Color.fromRGBO(9, 55, 95, 1)),
  DougnutChartData("late", totalLate.toString()=="null"?0:int.parse(totalLate.toString()), Color.fromRGBO(69, 160, 237, 1)),
  DougnutChartData("total offs", 0, Color.fromRGBO(230, 121, 47, 1)),
  DougnutChartData("total Leaves", 0, const Color.fromARGB(255, 200, 20, 7)),
  ];
 final list1 = [onTime,totalEarly,totalLate];
 print(list1);
  
return attenData;
}

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
               
                children: [
                  SizedBox(height: 60.h,),
                  FutureBuilder(
                                        
                                             future: Provider11.fetchAttendanceMonths(),
                                             initialData: "Code sample",
                                             builder: (BuildContext context, snapshot) {
                                               if (snapshot.connectionState == ConnectionState.waiting) {
                                                 return  Center(
                                                   child: dropDownLoader()
                                                 );
                                               }
                                               if (snapshot.connectionState == ConnectionState.done) {
                                                 if (snapshot.hasError) {
                                                   return Center(
                                                     child: Text(
                                                       'An ${snapshot.error} occurred',
                                                       style: const TextStyle(fontSize: 18, color: Colors.red),
                                                     ),
                                                   );
                                                 } else if (snapshot.hasData) {
                                                   final data = snapshot.data;
                                                List<DropdownMenuItem<String>> dropdownItems = data.map<DropdownMenuItem<String>>((month) {
                return
                 DropdownMenuItem<String>(
                value: month,
                child: Text(
                month,
                style: TextStyle(color: Colors.white),
                ),
                );
                }).toList();
                                                   print("${data} data is here");
                                                   return 
                Container(
                                        width: 230,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Multi(color: Colors.white, subtitle: "Select Month", weight: FontWeight.bold, size: 10),
                                            SizedBox(height: 5.h,),
                                            DropdownButton(
                                              isExpanded: true,
                                              dropdownColor: Colors.black,
                                              icon: null,
                                              iconEnabledColor: Colors.white,
                                              hint: Multi(
                                               color: Colors.white,
                                               subtitle: "",
                                               weight: FontWeight.normal,
                                               size: 3),
                                              value: _selectedValue,
                                              onChanged: (value)async{
                                             setState(() {
                                               attendanceDataPdf = [];
                                               _selectedValue = value!;      
                                             });
                                             await Provider11.getActualCheckInCurrentMonth(Provider11.emp_uid!,_selectedValue);
                                             print(_selectedValue);
                                              },
                                              items:dropdownItems,
                                            ),
                                          ],
                                        ),
                                      );
                
                
                                           
                                                 }
                                               }
                                      
                                               return const Center(
                                                 child: dropDownLoader(),
                                               );
                                             },
                                         
                                      ),
                
              
                  FutureBuilder(
                                        
                                                future: fetchFireBaseData(),
                                                initialData: "Code sample",
                                                builder: (BuildContext context, snapshot) {
                                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                                    return const Center(
                                                      child: loader2(),
                                                    );
                                                  }
                                                  if (snapshot.connectionState == ConnectionState.done) {
                                                    if (snapshot.hasError) {
                                                      return Center(
                                                        child: Text(
                                                          'An ${snapshot.error} occurred',
                                                          style: const TextStyle(fontSize: 18, color: Colors.red),
                                                        ),
                                                      );
                                                    } else if (snapshot.hasData) {
                                                    
                                                      return  
                                                      SingleChildScrollView(
                                                        child: Column(
                                                          
                                                          
                                                                    children: [
                                                                        Container(
                      height: 250,
                      // width: ,
                      child: SfCircularChart(
                      
                        key: _cartesianChartKey,
                        legend: Legend(
                              isVisible: true,
                              textStyle: TextStyle(color: Color(0xff8D939F),fontWeight: FontWeight.bold)
                            ),
                                  series: <CircularSeries>[
                                     
                                      DoughnutSeries<DougnutChartData, String>(
                                          dataSource: categoryChart,
                                          pointColorMapper:(DougnutChartData data,  _) => data.color,
                                          xValueMapper: (DougnutChartData data, _) => data.x,
                                          yValueMapper: (DougnutChartData data, _) => data.y
                                      )
                                  ]
                              ),
                    ),
                                                                      Container(
                                                                        
                                                                         
                                                                        child: Padding(
                                                                          padding:EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                                                          child: Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Multi(color: Colors.white, subtitle: "Cummulative Stats", weight: FontWeight.bold, size: 18.5),
                                                                              SizedBox(height: 20,),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                children: [
                                                                                  ReportCards(imgAddress: 'assets/totalHours.png', value: '$totalTime', heading: 'Total Working Hours', subHeading: 'hours',),
                                                                              
                                                                                  ReportCards(imgAddress: 'assets/in.png', value: '$totalLate', heading: 'Total Late Arrivals', subHeading: 'arrivals',),
                                                                                ],
                                                                              ),
                                                                              SizedBox(height: 20.h,),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                children: [
                                                                                  ReportCards(imgAddress: 'assets/in.png', value: '$onTime', heading: 'On Times', subHeading: 'arrivals',),
                                                                              
                                                                              ReportCards(imgAddress: 'assets/in.png', value: '$totalEarly', heading: 'Total Early Arrivals', subHeading: 'arrivals',),
                                                                                ],
                                                                              ),
                                                                              SizedBox(height: 20.h,),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                children: [
                                                                                  ReportCards(imgAddress: 'assets/off.png', value: '00', heading: 'Total Offs', subHeading: 'days',),
                                                                              SizedBox(height: 10,),
                                                                              ReportCards(imgAddress: 'assets/leave.png', value: '00', heading: 'Total Leaves', subHeading: 'days',)
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )
                                                                      ),
                                                                      SizedBox(height: 40,),
                                                                      Padding(
                                                                        padding:EdgeInsets.only(left:20 ),
                                                                        child: Multi(color: Colors.white, subtitle: "Attendence Record", weight: FontWeight.bold, size: 3.5),
                                                                      ),
                                                                      SizedBox(height: 20,),
                                                                     
                                                             
                                                                      
                                                                    ],
                                                                  ),
                                                      );
                                                    }
                                                  }
                                      
                                                  return const Center(
                                                    child: loader2(),
                                                  );
                                                },
                                            
                                      ),
                ],
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






































    class DougnutChartData {
        DougnutChartData(this.x, this.y, this.color);
            final String x;
            final int y;
            final Color color;
    }













  






class ChartData {
        ChartData(this.x,this.x2,this.x3, this.y);
        final int x;
        final int x2;
        final int x3;
        final double? y;

    }
class Timings{
      int? serial;
      String? date;
      String? checkin;
      String? checkout;
      String? workingHours;
      String? status;
  
  Timings({
    required this.serial,
    required this.date,
    required this.checkin,
    required this.checkout,
    required this.workingHours,
    required this.status
    });
}

class AttendanceChartData1 {
  var x;
  String? y;
  double? early;
  double? late;
  double? late15;
  AttendanceChartData1({required this.x,required this.y,required this.early,required this.late,required this.late15});
}












class dropDownLoader extends StatelessWidget {
  const dropDownLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 10.h),
      child: Container(
        // height: 100.h,
        width:230,
        decoration: BoxDecoration(
          color: Colors.black,
         
        ),
        child: Padding(
          padding:EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    baseColor: Color.fromARGB(255, 39, 40, 40),
                   highlightColor: Color.fromARGB(255, 99, 98, 98),
                 ),
                  Shimmer.fromColors(
                   child: Padding(
                    padding:  EdgeInsets.only(bottom: 10.h),
                     child: Container(
                        height: 30.h,
                         width: 230.w,
                       decoration: BoxDecoration(
                           color: Color.fromARGB(255, 157, 221, 214),
                           borderRadius: BorderRadius.circular(1.r)),
                       child: Multi(color: Colors.white, subtitle: "", weight: FontWeight.w500, size: 13),
                     ),
                     
                   ),
                   baseColor: Color.fromARGB(255, 39, 40, 40),
                   highlightColor: Color.fromARGB(255, 99, 98, 98),
                 ),
          
            ],
          ),
        ),
      ),
    );
    
    
  
  }
}






class loader2 extends StatelessWidget {
  const loader2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 10.h),
      child: Container(
        // height: 100.h,
        // width:230,
        decoration: BoxDecoration(
          color: Colors.black,
         
        ),
        child: Padding(
          padding:EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                   child: Padding(
                    padding:  EdgeInsets.only(bottom: 10.h),
                     child: Container(
                        height: 200.h,
                         width: double.infinity,
                       decoration: BoxDecoration(
                           color: Color.fromARGB(255, 157, 221, 214),
                           borderRadius: BorderRadius.circular(1.r)),
                       child: Multi(color: Colors.white, subtitle: "", weight: FontWeight.w500, size: 13),
                     ),
                     
                   ),
                    baseColor: Color.fromARGB(255, 39, 40, 40),
                   highlightColor: Color.fromARGB(255, 99, 98, 98),
                 ),
                 SizedBox(height: 10.h,),
                Shimmer.fromColors(
                   child: Padding(
                    padding:  EdgeInsets.only(bottom: 10.h),
                     child: Container(
                        height: 30.h,
                         width: 230.w,
                       decoration: BoxDecoration(
                           color: Color.fromARGB(255, 157, 221, 214),
                           borderRadius: BorderRadius.circular(1.r)),
                       child: Multi(color: Colors.white, subtitle: "", weight: FontWeight.w500, size: 13),
                     ),
                     
                   ),
                   baseColor: Color.fromARGB(255, 39, 40, 40),
                   highlightColor: Color.fromARGB(255, 99, 98, 98),
                 ),
                Container(
                                                                    
                                                                     
                                                                    child: Padding(
                                                                      padding:EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                            children: [
                                                                              ReportLoader(),
                                                                             
                                                                              ReportLoader(),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 20.h,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                            children: [
                                                                             ReportLoader(),
                                                                          
                                                                          ReportLoader(),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 20.h,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                            children: [
                                                                             ReportLoader(),
                                                                          SizedBox(height: 10,),
                                                                        ReportLoader(),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ),
                                                                  SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
    
    
  
  }
}
