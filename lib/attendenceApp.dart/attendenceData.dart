import 'dart:convert';
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
import 'package:zelleclients/pages/orders.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:zelleclients/provider/provider1.dart';
import 'package:zelleclients/utils/dateWiseAttendenceTab.dart';
import 'package:zelleclients/utils/multiText.dart';

class AttendanceData extends StatefulWidget {
  AttendanceData({super.key});

  @override
  State<AttendanceData> createState() => _AttendanceDataState();
}

class _AttendanceDataState extends State<AttendanceData> {
  @override
  ScrollController _scrollController = ScrollController();

  List<AttendanceChartData1> graphData = [];
  List<Timings> attendanceDataPdf = [];

  String _selectedValue = DateFormat('MMMM yyyy').format(DateTime.now());

  String? statusCategorization(String dailyArrival, String actualArrivalTime) {
    String arrivalCategory = categorizeArrival(actualArrivalTime, dailyArrival);
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
    } else if (timeDifference <= lateThreshold &&
        timeDifference > Duration(minutes: 0, hours: 0, seconds: 0)) {
      lateArrival.add(0);
      onTimemArrival.add(0);
      late15min.add(double.parse(timeDifference.inMinutes.toString()));
      return timeDifference.inMinutes.toString();
    } else {
      print(timeDifference);
      lateArrival.add(0);
      late15min.add(0);
      onTimemArrival.add(double.parse(timeDifference.inMinutes < 0
          ? (timeDifference.inMinutes * -1).toString()
          : timeDifference.inMinutes.toString()));
      return timeDifference.inMinutes.toString();
    }
  }

  List<int>? imgGraph;

  Future<List?> _renderChartAsImage() async {
    final double pixelRatio = 2.0; // Try using a lower pixel ratio (e.g., 2.0)
    final ui.Image data =
        await _cartesianChartKey.currentState!.toImage(pixelRatio: pixelRatio);
    final ByteData? bytes =
        await data.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List imageBytes =
        bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    imgGraph = imageBytes;
    print(imgGraph);
    return imageBytes;
  }

  List<double> lateArrival = [];

  List<double> onTimemArrival = [];

  List<double> late15min = [];

  int index = 0;

  var attenData = [];

  var attenDates = [];

  late GlobalKey<SfCartesianChartState> _cartesianChartKey;


  Widget build(BuildContext context) {
    _cartesianChartKey = GlobalKey();
    final size = MediaQuery.of(context).size;
    final Provider11 = Provider.of<Provider1>(context, listen: true);
    Future fetchFireBaseData() async {
     await Provider11.getActualCheckInCurrentMonth(Provider11.emp_uid!,_selectedValue.toString());
      attenData = [];
      lateArrival = [];
      index = 0;
      onTimemArrival = [];

      late15min = [];
      attenDates = [];
      final ref = FirebaseDatabase.instance.ref();
      
      final snapshot = await ref
          .child('attendence/${_selectedValue}/${Provider11.emp_shift}')
          .get();
      if (snapshot.exists) {
        
        print(snapshot.value);
         Map<String, dynamic>? data =
            Provider11.convertSnapshotValue(snapshot.value);
print("${data} dataaaaa is here");
        // Initialize an empty Map to store the data for the specified UID
        final Map<String, dynamic> uidData = {};
print("working2");
        // Specify the UID you want to retrieve
        final desiredUid = Provider11.emp_uid;
print("working3");
        // Loop through the data and extract data for the desired UID
        try {
          data.forEach((date, dateData) {
          
          if (dateData.containsKey(desiredUid)) {
            index++;

            uidData[date] = dateData[desiredUid];

            print(uidData[date]['checkin'].toString());
            uidData[date]['checkin'] == null
                ? index--
                : graphData.add(AttendanceChartData1(
                    x: date,
                    y: statusCategorization(uidData[date]['checkin'],
                        Provider11.octoberDates[date]),
                    early: onTimemArrival[index - 1],
                    late: lateArrival[index - 1],
                    late15: late15min[index - 1]));
          }
        });
        } catch (e) {
          print("${e} eror is here");
        }
        print("working4");
        print("${uidData} data is herere");

        final Map<String, dynamic> finalData = Provider11.sorting(uidData);
        print("working5");
        for (var i = 0; i < finalData.length; i++) {
          print("${finalData.keys.toList()[i]} ---> ${i}");
          attendanceDataPdf.add(Timings(
              checkin: finalData.values.toList()[i]['checkin'] == null
                  ? "null"
                  : finalData.values.toList()[i]['checkin'],
              checkout: finalData.values.toList()[i]['checkout'] == null
                  ? "null"
                  : finalData.values.toList()[i]['checkout'],
              date: finalData.keys.toList()[i].toString(),
              workingHours: finalData.values.toList()[i]['checkin'] == null ||
                      finalData.values.toList()[i]['checkout'] == null
                  ? "nil"
                  : Provider11.getTimeDifference(
                      finalData.values.toList()[i]['checkin'].toString(),
                      finalData.values.toList()[i]['checkout'].toString()),
              status: finalData.values.toList()[i]['checkin'] == null
                  ? "nil"
                  : Provider11.statusCategorization2(
                      finalData.values.toList()[i]['checkin'].toString(),
                      finalData.keys.toList()[i].toString())));
        }
        print("working6");
        // Print the extracted data for the specified UID
        attenData = finalData.values.toList();
        print("working7");
        attenDates = finalData.keys.toList();
        print("working8");
        print(lateArrival);
        print(onTimemArrival);
        print(late15min);

        for (var i = 0; i < graphData.length; i++) {
          print(
              "${graphData[i].early}  ${graphData[i].late}  ${graphData[i].late15}");
        }
      } else {
        print('No data available.');
      }

      return attenData;
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff1F2123),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                     SizedBox(
                      height: 60.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
              
                        // Multi(
                        //     color: Colors.white,
                        //     subtitle: "Attendance Record",
                        //     weight: FontWeight.bold,
                        //     size: 10),
                        Container(
                          width: 150.w,
                          child: FutureBuilder(
                                          future: Provider11.fetchAttendanceMonths(),
                                          initialData: "Code sample",
                                          builder: (BuildContext context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                child: CircularProgressIndicator(
                                                  color: Colors.deepPurpleAccent,
                                                ),
                                              );
                                            }
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              if (snapshot.hasError) {
                                                return Center(
                                                  child: Text(
                                                    'An ${snapshot.error} occurred',
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.red),
                                                  ),
                                                );
                                              } else if (snapshot.hasData) {
                                                final data = snapshot.data;
                                                List<DropdownMenuItem<String>>
                                                
                                                    dropdownItems = data
                                                        .map<DropdownMenuItem<String>>(
                                                            (month) {
                                                  return DropdownMenuItem<String>(
                                                    value: month,
                                                    child: Text(
                                                      month,
                                                      style: TextStyle(
                                                          color: Colors.white,fontSize: 11.sp),
                                                    ),
                                                  );
                                                }).toList();
                                                print("${data} data is here");
                                                return Container(
                                                  width: 230,
                                                  child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Multi(color: Colors.white, subtitle: "Select Month", weight: FontWeight.bold, size: 10),
                                           
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
                                                        onChanged: (value)async {
                        
                                                          setState(() {
                                                            attendanceDataPdf = [];
                                                            _selectedValue = value!;
                                                          });
                                                         await Provider11.getActualCheckInCurrentMonth(Provider11.emp_uid!,_selectedValue);
                                                          print(_selectedValue);
                                                        },
                                                        items: dropdownItems,
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            }
                        
                                            return const Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          },
                                        ),
                        ),
                      ],
                    ),
                   SizedBox(height: 15.h,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     InkWell(
                        //       onTap: () {
                              
                        //       },
                        //       child: Row(
                        //         crossAxisAlignment:
                        //             CrossAxisAlignment.start,
                        //         mainAxisAlignment: MainAxisAlignment.start,
                        //         children: [
                        //           Image.network(
                        //             "https://cdn-icons-png.flaticon.com/128/25/25617.png",
                        //             height: 14,
                        //             width: 14,
                        //             color:
                        //                 Provider11.activeTabTimeTracked == 0
                        //                     ? Colors.white
                        //                     : Color(0xff8F95A2),
                        //           ),
                        //           SizedBox(
                        //             width: 5,
                        //           ),
                        //           Multi(
                        //               color:
                        //                   Provider11.activeTabTimeTracked ==
                        //                           0
                        //                       ? Colors.white
                        //                       : Color(0xff8F95A2),
                        //               subtitle: "Table View",
                        //               weight: FontWeight.w500,
                        //               size: 3)
                        //         ],
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 15,
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     FutureBuilder(
                        //       future: Provider11.fetchAttendanceMonths(),
                        //       initialData: "Code sample",
                        //       builder: (BuildContext context, snapshot) {
                        //         if (snapshot.connectionState ==
                        //             ConnectionState.waiting) {
                        //           return const Center(
                        //             child: CircularProgressIndicator(
                        //               color: Colors.deepPurpleAccent,
                        //             ),
                        //           );
                        //         }
                        //         if (snapshot.connectionState ==
                        //             ConnectionState.done) {
                        //           if (snapshot.hasError) {
                        //             return Center(
                        //               child: Text(
                        //                 'An ${snapshot.error} occurred',
                        //                 style: const TextStyle(
                        //                     fontSize: 18,
                        //                     color: Colors.red),
                        //               ),
                        //             );
                        //           } else if (snapshot.hasData) {
                        //             final data = snapshot.data;
                        //             List<DropdownMenuItem<String>>
                        //                 dropdownItems = data
                        //                     .map<DropdownMenuItem<String>>(
                        //                         (month) {
                        //               return DropdownMenuItem<String>(
                        //                 value: month,
                        //                 child: Text(
                        //                   month,
                        //                   style: TextStyle(
                        //                       color: Colors.white),
                        //                 ),
                        //               );
                        //             }).toList();
                        //             print("${data} data is here");
                        //             return Container(
                        //               width: 230,
                        //               child: DropdownButton(
                        //                 isExpanded: true,
                        //                 dropdownColor: Colors.black,
                        //                 icon: null,
                        //                 iconEnabledColor: Colors.white,
                        //                 hint: Multi(
                        //                     color: Colors.white,
                        //                     subtitle: "",
                        //                     weight: FontWeight.normal,
                        //                     size: 3),
                        //                 value: _selectedValue,
                        //                 onChanged: (value)async {
                  
                        //                   setState(() {
                        //                     attendanceDataPdf = [];
                        //                     _selectedValue = value!;
                        //                   });
                        //                  await Provider11.getActualCheckInCurrentMonth(Provider11.uid!,_selectedValue);
                        //                   print(_selectedValue);
                        //                 },
                        //                 items: dropdownItems,
                        //               ),
                        //             );
                        //           }
                        //         }
                  
                        //         return const Center(
                        //           child: CircularProgressIndicator(),
                        //         );
                        //       },
                        //     ),
                        //     // GestureDetector(
                        //     //     onTap: () async {
                        //     //       await _renderChartAsImage();
                        //     //       PdfService().printCustomersPdf(
                        //     //           attendanceDataPdf, imgGraph);
                        //     //     },
                        //     //     child: Image.network(
                        //     //       "https://cdn-icons-png.flaticon.com/128/5261/5261933.png",
                        //     //       height: 20,
                        //     //       width: 20,
                        //     //       color: Colors.white,
                        //     //     )),
                        //   ],
                        // )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                      Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: FutureBuilder(
                              future: fetchFireBaseData(),
                              initialData: "Code sample",
                              builder: (BuildContext context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return  SingleChildScrollView(
                                  child:Column(
                                    children: [
                                      LoadingAttendenceTab(),
                                      SizedBox(height: 10.h,),
                                      LoadingAttendenceTab(),
                                      SizedBox(height: 10.h,),
                                      LoadingAttendenceTab(),
                                      SizedBox(height: 10.h,),
                                     
                                    
                                    ],
                                  ),
                                );
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text(
                                        'An ${snapshot.error} occurred',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.red),
                                      ),
                                    );
                                  } else if (snapshot.hasData) {
                                    final data = snapshot.data;
                                    return ListView.builder(
                                      physics:
                                          NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      // gridDelegate:
                                      //     SliverGridDelegateWithFixedCrossAxisCount(
                                      //         crossAxisCount: 4,
                                      //         crossAxisSpacing: 15,
                                      //         mainAxisSpacing: 15,
                                      //         childAspectRatio: 3),
                                      itemCount: attenData.length,
                                      itemBuilder:
                                          (BuildContext context,
                                              int index) {
                                        return 
                                      //  LoadingAttendenceTab();
                                        GestureDetector(
                                            onTap: () {},
                                            child:
                                             AttendenceBox(
                                              checkin: attenData[index]
                                                      ['checkin']
                                                  .toString(),
                                              checkout: attenData[index]
                                                      ['checkout']
                                                  .toString(),
                                              hours: ((attenData[index][
                                                                  'checkin']
                                                              .toString() ==
                                                          "null") ||
                                                      (attenData[index][
                                                                  'checkout']
                                                              .toString() ==
                                                          "null"))
                                                  ? "null"
                                                  : Provider11.getTimeDifference(
                                                      attenData[index][
                                                              'checkin']
                                                          .toString(),
                                                      attenData[index][
                                                              'checkout']
                                                          .toString()),
                                              dates: attenDates[index]
                                                  .toString(),
                                              status: attenData[index][
                                                              'checkin']
                                                          .toString() ==
                                                      "null"
                                                  ? "null"
                                                  : Provider11.statusCategorization(
                                                          attenData[index]
                                                                  [
                                                                  'checkin']
                                                              .toString(),
                                                          attenDates[
                                                                  index]
                                                              .toString())
                                                      .toString(),
                                            )
                                            );
                                      },
                                    );
                                  }
                                }
                  
                                return SingleChildScrollView(
                                  child:Column(
                                    children: [
                                      LoadingAttendenceTab(),
                                      SizedBox(height: 10.h,),
                                      LoadingAttendenceTab(),
                                      SizedBox(height: 10.h,),
                                      LoadingAttendenceTab(),
                                      SizedBox(height: 10.h,),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                ),
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

class AttendanceChartData1 {
  var x;
  String? y;
  double? early;
  double? late;
  double? late15;
  AttendanceChartData1(
      {required this.x,
      required this.y,
      required this.early,
      required this.late,
      required this.late15});
}

class ChartData {
  ChartData(this.x, this.x2, this.x3, this.y);
  final int x;
  final int x2;
  final int x3;
  final double? y;
}

class Timings {
  String? date;
  String? checkin;
  String? checkout;
  String? workingHours;
  String? status;

  Timings(
      {required this.date,
      required this.checkin,
      required this.checkout,
      required this.workingHours,
      required this.status});
}
