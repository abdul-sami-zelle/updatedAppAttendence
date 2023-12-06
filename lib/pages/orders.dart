import 'dart:convert';
import 'dart:io';
import 'package:dio/io.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zelleclients/classes/revenue.dart';
import 'package:zelleclients/classes/soldProduct.dart';
import 'package:zelleclients/pages/subpages/orderDetail.dart';
import 'package:zelleclients/provider/provider1.dart';
import 'package:zelleclients/utils/multiText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import '../utils/orderContainer.dart';
import 'login.dart';

class OrdersList extends StatelessWidget {
  var size, height, width;
  OrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    final Provider11 = Provider.of<Provider1>(context);
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    List<dynamic>? orders;
    List<dynamic> imgs = [];
    List<dynamic> names = [];
    List<dynamic> quantity = [];
    List<dynamic> sub_pkr = [];
    List<dynamic> pkr = [];
    List<SoldProduct> prod = [];

    OrderDetails() async {
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
            'https://${base}/wp-json/wc/v3/orders?page=1&per_page=100&consumer_key=${ck}&consumer_secret=${cs}';
        Response response = await dio.get(url);
        return response.data;
        // print(orders![1]['billing']);
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
    
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xff1E1E1E),
        title: Text("Orders"),
        leading: BackButton(color: Colors.white),
      ),
      body:
       Container(
        child: FutureBuilder(
            future: OrderDetails(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error"),
                );
              }
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      abc() {
                        imgs.clear();
                        names.clear();
                        quantity.clear();
                        sub_pkr.clear();
                        pkr.clear();
                        prod.clear();
                        for (var i = 0;
                            i < snapshot.data[index]['line_items'].length;
                            i++) {
                          imgs.add(snapshot.data[index]['line_items'][i]
                                  ['image']['src']
                              .toString());
                          names.add(snapshot.data[index]['line_items'][i]
                                  ['name']
                              .toString());
                          quantity.add(snapshot.data[index]['line_items'][i]
                                  ['quantity']
                              .toString());
                          sub_pkr.add(snapshot.data[index]['line_items'][i]
                                  ['price']
                              .toString());
                          pkr.add(snapshot.data[index]['line_items'][i]['total']
                              .toString());
                        }
                        for (var i = 0; i < imgs.length; i++) {
                          prod.add(SoldProduct(imgs[i], quantity[i], pkr[i],
                              sub_pkr[i], names[i]));
                        }
                        print(prod);
                      }

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async {
                            await abc();
                            print(names);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderDetailEdit(
                                          dt: snapshot.data[index]
                                                  ['date_created']
                                              .toString()
                                              .substring(0, 11),
                                          name: snapshot.data[index]['billing']
                                              ['first_name'],
                                          status: snapshot.data[index]
                                              ['status'],
                                          products: prod,
                                          pt: snapshot.data[index]['total'],
                                          ship: snapshot.data[index]
                                              ['shipping_total'],
                                          ot: snapshot.data[index]['line_items']
                                                  [0]['price']
                                              .toString(),
                                          address: snapshot.data[index]
                                              ['billing']['address_1'],
                                          email: snapshot.data[index]['billing']
                                              ['email'],
                                          phone: snapshot.data[index]['billing']
                                              ['phone'],
                                          number: snapshot.data[index]
                                              ['number'],
                                          pname: snapshot.data[index]['billing']
                                              ['first_name'], orderId: snapshot.data[index]['id'].toString(),
                                        )));
                          },
                          child: OrderContainer(
                            dt: snapshot.data[index]['date_created']
                                .toString()
                                .substring(0, 11),
                            oi: snapshot.data[index]['number'],
                            status: snapshot.data[index]['status'],
                            name: snapshot.data[index]['billing']['first_name'],
                            price: NumberFormat('#,##0.00').format(
                                double.parse(snapshot.data[index]['total'])),
                          ),
                        ),
                      );
                    });
              }
              return ShimmerEffect();
            }),
      ),
    );
  }
}

class ShimmerEffect extends StatelessWidget {
  var size, height, width;
  ShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: ListView.builder(
        shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (ctx, snapshot) {
            return Container(
                height: 100.h,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Shimmer.fromColors(
                        child: Container(
                          height: 12.h,
                          width: 70.w,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 157, 221, 214),
                              borderRadius: BorderRadius.circular(5.r)),
                        ),
                        baseColor: Colors.transparent,
                        highlightColor: Colors.grey,
                      ),
                      SingleChildScrollView(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.transparent,
                              highlightColor: Colors.grey,
                              child: Container(
                                width: width / 1.09,
                                height: 30.h,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 157, 221, 214),
                                    borderRadius: BorderRadius.circular(5.r)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.transparent,
                        highlightColor: Colors.grey,
                        child: Container(
                          height: 20.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 157, 221, 214),
                              borderRadius: BorderRadius.circular(5.r)),
                        ),
                      )
                    ],
                  ),
                ));
          }),
    );
  }
}
