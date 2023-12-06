import 'dart:convert';
import 'dart:io';
import 'package:dio/io.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zelleclients/classes/revenue.dart';
import 'package:zelleclients/provider/provider1.dart';
import 'package:zelleclients/utils/multiText.dart';
import '../login.dart';
import 'analytics.dart';

class MonthReport extends StatelessWidget {
  const MonthReport({super.key});

  @override
  Widget build(BuildContext context) {
    final Provider11 = Provider.of<Provider1>(context);
    List<dynamic>? orders;
    List<dynamic>? orderDetails;
    List<String> dts = [];
    List<String> sell = [];
    List<Revenue> revenue = [];
    List<String> dts1 = [];
    Dayvise() async {
      try {
        final dio = Dio();
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (client) {
    // Disable certificate validation
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };
        String ck = Provider11.ck.toString();
        String cs = Provider11.cs.toString();
        String base = Provider11.base.toString();
        String url =
            'https://${base}/wp-json/wc/v3/reports/sales?period=month&consumer_key=${ck}&consumer_secret=${cs}';
        Response response = await dio.get(url);
        orders = response.data;
        print(orders![0]['total_sales']);
        for (var i in orders![0]['totals'].keys) {
          dts1.add(i);
         dts.add(DateTime.parse(i).day.toString());
        }
        for (var i in orders![0]['totals'].values) {
          sell.add(i['sales']);
        }
        for (var i = 0; i < dts.length; i++) {
          revenue.add(Revenue(dts[i], sell[i]));
        }

        print(revenue);
      } catch (e) {
        print("${e} error is here");
      }
    }
     div()async{
      final dio = Dio();
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (client) {
    // Disable certificate validation
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };
      String ck = Provider11.ck.toString();
        String cs = Provider11.cs.toString();
        String base = Provider11.base.toString();
       String url2 = "https://${base}/wp-json/wc/v3/orders?&consumer_key=${ck}&consumer_secret=${cs}&startDate=${dts1.first}&endDate=${dts1.last}";
        Response response2 = await dio.get(url2);
        orderDetails = response2.data;
        print(orderDetails);
    }

    return FutureBuilder(
      future: Dayvise(),
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Color(0xff1E1E1E),
            height: double.infinity,
            width: double.infinity,
            child: Center(
              child: spinkit1,
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            color: Color(0xff1E1E1E),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Multi(
                      color: Colors.grey,
                      subtitle: "Last 7 days",
                      weight: FontWeight.w600,
                      size: 14),
                  SizedBox(
                    height: 15.h,
                  ),
                  Multi(
                      color: Colors.white,
                      subtitle:
                          "PKR ${NumberFormat('#,##0.00').format(double.parse(orders![0]['net_sales']))}",
                      weight: FontWeight.w500,
                      size: 40),
                  SizedBox(
                    height: 5.h,
                  ),
                  Multi(
                      color: Colors.grey,
                      subtitle: "Revenue",
                      weight: FontWeight.w600,
                      size: 10),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Multi(
                              color: Colors.white,
                              subtitle: "${orders![0]['total_orders']}",
                              weight: FontWeight.w500,
                              size: 20),
                          SizedBox(
                            height: 5.h,
                          ),
                          Multi(
                              color: Colors.white,
                              subtitle: "Orders",
                              weight: FontWeight.w600,
                              size: 10),
                        ],
                      ),
                      Column(
                        children: [
                          Multi(
                              color: Colors.white,
                              subtitle: "${orders![0]['total_customers']}",
                              weight: FontWeight.w500,
                              size: 20),
                          SizedBox(
                            height: 5.h,
                          ),
                          Multi(
                              color: Colors.white,
                              subtitle: "Visitors",
                              weight: FontWeight.w600,
                              size: 10),
                        ],
                      ),
                      Column(
                        children: [
                          Multi(
                              color: Colors.white,
                              subtitle: "0%",
                              weight: FontWeight.w500,
                              size: 20),
                          SizedBox(
                            height: 5.h,
                          ),
                          Multi(
                              color: Colors.white,
                              subtitle: "Conversions",
                              weight: FontWeight.w600,
                              size: 10),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    child: Center(
                      child: Container(
                          child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              series: <ChartSeries>[
                            StackedLineSeries<Revenue, String>(
                                dataLabelSettings: DataLabelSettings(
                                    isVisible: true,
                                    useSeriesColor: true,
                                    color: Color(0xffb929be),

                                    ),
                                color: Color(0xffb929be),
                                dataSource: revenue,
                                animationDuration: 4000,
                                xValueMapper: (Revenue data, _) => data.dt,
                                yValueMapper: (Revenue data, _) =>
                                    num.parse(data.value.toString())),
                          ])),
                    ),
                  ),
                   SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
                      height: 55.h,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xff009ae2),
                                Color(0xffb929be)
                              ]),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Color.fromRGBO(
                                        0, 0, 0, 0.57), //shadow for button
                                    blurRadius: 5) //blur radius of shadow
                              ]),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                onSurface: Colors.transparent,
                                shadowColor: Colors.transparent,
                                //make color or elevated button transparent
                              ),
                              onPressed: () async{
                                await div();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Analytics(
                                            ts: NumberFormat('#,##0.00').format(double.parse(orders![0]['total_sales'])), 
                                            ns: NumberFormat('#,##0.00').format(double.parse(orders![0]['net_sales'])), 
                                            to: orders![0]['total_orders'].toString(), 
                                            aov: NumberFormat('#,##0.00').format(double.parse(orders![0]['average_sales'])),
                                             ti: orders![0]['total_items'].toString(),
                                            )));
                                           
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 18,
                                  bottom: 18,
                                ),
                                child: Text("See More"),
                              ))),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return Text("");
      },
    );
  }
}
