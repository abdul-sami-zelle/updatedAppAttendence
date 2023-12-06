import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zelleclients/utils/multiText.dart';

class TaskStats extends StatelessWidget {
  const TaskStats({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(

      child: Scaffold(
        backgroundColor:Color(0xff1F2123),
        body: Stack(
          children: [
            Container(
             
              decoration: BoxDecoration(
                  color: Color(0xff1F2123),
                  ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           
                          
                          Padding(
                            padding:EdgeInsets.only(bottom: 0,top: 50.h,left: 20.w,right: 20.w),
                            child: Container(
                              height: 300.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    Multi(
                                        color: Colors.white,
                                        subtitle: "My Incentive Level",
                                        weight: FontWeight.bold,
                                        size: 13.5),
                                 
                                    Container(
                                      height: 200.h,
                                      // width: 100.w,
                                      child: Padding(
                                        padding:  EdgeInsets.all(8.0),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                                top: 5,
                                                left: size.width/6.9,
                                                child: Image.asset(
                                                  "assets/hexagon.png",
                                                  height: 160.h,
                                                  width: 160.w,
                                                  color: Color(0xff64FDC2),
                                                )),
                                           Align(
                                            alignment: Alignment.center,
                                            child:  Image.asset(
                                              "assets/hexagon.png",
                                             height: 160.h,
                                                  width: 160.w,
                                              color: Color(0xff414243),
                                            ),
                                           ),
                                            Align(
                                                alignment: Alignment.center,
                                                child: Multi(
                                                    color: Colors.white,
                                                    subtitle: "70",
                                                    weight: FontWeight.w500,
                                                    size:60)),
                                          ],
                                        ),
                                      ),
                                    ),
                                   
                                    Container(
                                      width: 170,
                                      child: Column(
                                        children: [
                                          LinearPercentIndicator(
                                            barRadius: Radius.circular(10),
                                            width: 160,
                                            lineHeight: 8,
                                            percent: 0.8,
                                            progressColor: Color(0xff64FDC2),
                                            backgroundColor: Color(0xff414243),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Multi(
                                                    color: Colors.white,
                                                    subtitle:
                                                        "2023 to next Level",
                                                    weight: FontWeight.w500,
                                                    size: 12),
                                                Multi(
                                                    color: Colors.white,
                                                    subtitle: "80%",
                                                    weight: FontWeight.w500,
                                                    size: 12),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    // Image.network("https://cdn-icons-png.flaticon.com/128/11881/11881947.png",height: 40,width: 40,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 5,top: 5),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 20.h,),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                               Padding(
                              padding: EdgeInsets.only(bottom: 4),
                              child: Container(
                                width: size.width/2.5,
                                height: 90.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black),
                                child: BarChart1(chartData: [
                                  ChartData2(2019, 3.43),
                                  ChartData2(2020, 3.6),
                                  ChartData2(2021, 5.8),
                                  ChartData2(2022, 5.8),
                                  ChartData2(2023, 8),
                                  ChartData2(2024, 8.2),
                                
                                
                                ], color: [
                                  Color.fromARGB(255, 11, 226, 4).withOpacity(0.1),
                                  Color.fromARGB(255, 11, 226, 4).withOpacity(0.6),
                                  Color.fromARGB(255, 11, 226, 4).withOpacity(0.1)
                                ], color1: [
                                  Color.fromARGB(255, 11, 226, 4),
                                  Color.fromARGB(255, 11, 226, 4)
                                ], barName: 'Attendence', img: 'assets/increase.png',),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 4),
                              child: Container(
                                 width: size.width/2.5,
                                height: 90.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black),
                                child:  BarChart1(chartData: [
                                 ChartData2(2019, 3.43),
                                ChartData2(2020, 8.2),
                                ChartData2(2021, 8),
                                ChartData2(2022, 5.8),
                                ChartData2(2023, 5.8),
                                ChartData2(2024, 3.6),
                                ChartData2(2025, 3.2),
                                ChartData2(2026, 2.7),
                                
                                
                                ], color: [
                                  Color.fromARGB(255, 219, 15, 15).withOpacity(0.1),
                                  Color.fromARGB(255, 219, 15, 15).withOpacity(0.6),
                                  Color.fromARGB(255, 219, 15, 15).withOpacity(0.1)
                                ], color1: [
                                  Color.fromARGB(255, 219, 15, 15),
                                  Color.fromARGB(255, 219, 15, 15)
                                ], barName: 'Arrival', img: 'assets/decrease.png',),
                              ),
                            ),
                            ],
                           ),
                           SizedBox(height: 20.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                              padding: EdgeInsets.only(bottom: 4),
                              child: Container(
                                 width: size.width/2.5,
                                height: 90.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black),
                                child:  BarChart1(chartData: [
                                 ChartData2(2019, 3.43),
                                ChartData2(2020, 3.6),
                                ChartData2(2021, 5.8),
                                ChartData2(2022, 5.8),
                                ChartData2(2023, 8),
                                ChartData2(2024, 8.2),
                                
                                
                                ], color: [
                                  Color.fromARGB(255, 11, 226, 4).withOpacity(0.1),
                                  Color.fromARGB(255, 11, 226, 4).withOpacity(0.6),
                                  Color.fromARGB(255, 11, 226, 4).withOpacity(0.1)
                                ], color1: [
                                  Color.fromARGB(255, 11, 226, 4),
                                  Color.fromARGB(255, 11, 226, 4)
                                ],barName:  'Completing Hours', img: 'assets/increase.png',),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 4),
                              child: Container(
                                 width: size.width/2.5,
                                height: 90.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black),
                                child:  BarChart1(chartData: [
                                 ChartData2(2019, 3.43),
                                ChartData2(2020, 3.6),
                                ChartData2(2021, 5.8),
                                ChartData2(2022, 5.8),
                                ChartData2(2023, 8),
                                ChartData2(2024, 8.2),
                                
                                
                                ], color: [
                                  Color.fromARGB(255, 11, 226, 4).withOpacity(0.1),
                                  Color.fromARGB(255, 11, 226, 4).withOpacity(0.6),
                                  Color.fromARGB(255, 11, 226, 4).withOpacity(0.1)
                                ], color1: [
                                  Color.fromARGB(255, 11, 226, 4),
                                  Color.fromARGB(255, 11, 226, 4)
                                ], barName: 'Performance', img: 'assets/increase.png',),
                              ),
                            ),
                              ],
                            ),
                            SizedBox(height: 20.h,),
                            Padding(
                              padding: EdgeInsets.only(bottom: 4),
                              child: Container(
                                 width: size.width/2.5,
                                height: 90.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black),
                                  child: BarChart1(chartData: [
                                 ChartData2(2019, 3.43),
                                ChartData2(2020, 8.2),
                                ChartData2(2021, 8),
                                ChartData2(2022, 5.8),
                                ChartData2(2023, 5.8),
                                ChartData2(2024, 3.6),
                                ChartData2(2025, 3.2),
                                ChartData2(2026, 2.7),
                                
                                
                                ], color: [
                                  Color.fromARGB(255, 219, 15, 15).withOpacity(0.1),
                                  Color.fromARGB(255, 219, 15, 15).withOpacity(0.6),
                                  Color.fromARGB(255, 219, 15, 15).withOpacity(0.1)
                                ], color1: [
                                  Color.fromARGB(255, 219, 15, 15),
                                  Color.fromARGB(255, 219, 15, 15)
                                ], barName: 'Extra Performance', img: 'assets/decrease.png',),
                              ),
                            ),
                          ],
                        ),
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




class ChartData2 {
  ChartData2(this.x, this.y);
  final int x;
  final double y;
}

class BarChart1 extends StatefulWidget {
  List<Color> color;
  List<Color> color1;
  List<ChartData2> chartData;
  String? barName;
  String? img;
  BarChart1(
      {super.key,
      required this.chartData,
      required this.color,
      required this.color1,
      required this.barName,
      required this.img
      });

  @override
  State<BarChart1> createState() => _BarChart1State();
}

class _BarChart1State extends State<BarChart1> {
  @override
  @override
  @override
  Widget build(BuildContext context) {
    final List<double> stops = <double>[];
    stops.add(0.0);
    stops.add(0.5);
    stops.add(0.9);

    final LinearGradient gradientColors =
        LinearGradient(colors: widget.color, stops: stops);
    return  Container(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding:EdgeInsets.all(8.0),
            child: Multi(color: Colors.white, subtitle: "${widget.barName}", weight: FontWeight.w500, size: 13.2),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
        ),
         Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding:EdgeInsets.all(8.0),
            child: Row(
              children: [
                Multi(color: Colors.white, subtitle: "+1", weight: FontWeight.w500, size:14),
                SizedBox(width: 10,),
                Image.asset("${widget.img}",height: 20,width: 20,)
              ],
            ),
          ),
        ),
          Positioned(
            right: 5,
            bottom: 2,
            child: Container(
              width: 50,
              height: 80,
                    child: SfCartesianChart(
                        plotAreaBorderWidth: 0,
                        primaryXAxis: NumericAxis(
                          majorGridLines: MajorGridLines(width: 0),
                          axisLine: AxisLine(width: 0),
                          isVisible: false,
                          borderWidth: 0,
                        ),
                        primaryYAxis: NumericAxis(
                            majorGridLines: MajorGridLines(width: 0),
                            axisLine: AxisLine(width: 0),
                            isVisible: false,
                            borderWidth: 0),
                        series: <ChartSeries>[
                      SplineAreaSeries<ChartData2, int>(
                        dataSource: widget.chartData,
                        xValueMapper: (ChartData2 data, _) => data.x,
                        yValueMapper: (ChartData2 data, _) => data.y,
                        animationDuration: 4000,
                        gradient: gradientColors,
                        borderWidth: 2,
                        borderGradient: LinearGradient(
                            colors: widget.color1, stops: <double>[0.2, 0.9]),
                      ),
                    ])),
          ),
        ],
      ),
    );
  }
}

class ChartData1 {
  ChartData1({required this.x, required this.y});
  int? x;
  final double y;
}
