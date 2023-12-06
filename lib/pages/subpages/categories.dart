import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zelleclients/pages/landingPage.dart';
import 'package:zelleclients/pages/orders.dart';
import 'package:zelleclients/pages/splash.dart';
import 'package:zelleclients/provider/provider1.dart';
import 'package:zelleclients/utils/forgotLink.dart';
import '../../utils/multiText.dart';

class CategoriacalPage extends StatelessWidget {
  String id;
  String name;
  CategoriacalPage({super.key, required this.id,required this.name});

  @override
  Widget build(BuildContext context) {
    final Provider11 = Provider.of<Provider1>(context);
    Pro1() async {
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
            'https://${base}/wp-json/wc/v3/products?consumer_key=${ck}&consumer_secret=${cs}&category=${id}&per_page=100';
        Response response = await dio.get(url);
        return response.data;
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      backgroundColor: Color(0xff1E1E1E),
      appBar: AppBar(
        backgroundColor: Color(0xff1E1E1E),
        title: Text("$name"),
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
          future: Pro1(),
          builder: (ctx, snapshot) {
            if (snapshot.hasError) {
              print("error");
            }
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, index) {
                    return GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Container(
                            height: 80.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 50.h,
                                      width: 50.w,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                        color: Colors.white,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            snapshot.data[index]['images']
                                                    .isEmpty
                                                ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                : snapshot.data[index]['images']
                                                    [0]['src'],
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w,),
                                    Multi(
                                        color: Colors.white,
                                        subtitle: snapshot.data[index]['name']
                                                    .toString()
                                                    .length >
                                                15
                                            ? "${snapshot.data[index]['name'].toString().substring(0, 14)}..."
                                            : snapshot.data[index]['name'],
                                        weight: FontWeight.normal,
                                        size: 15),
                                  ],
                                ),
                                Multi(
                                    color: Colors.white,
                                    subtitle:
                                        "PKR ${snapshot.data[index]['price'].toString()}",
                                    weight: FontWeight.normal,
                                    size: 15),
                              ],
                            ),
                          ),
                        ));
                  });
            }
            return ShimmerEffect2();
          }),
    );
  }
}

class ShimmerEffect2 extends StatelessWidget {
  var size, height, width;
  
  ShimmerEffect2({super.key});

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (ctx, snapshot) {
            return Container(
                height: 100.h,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Shimmer.fromColors(
                        child: Container(
                          height: 50.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(4.r),
                            color: Colors.white,
                          ),
                        ),
                        baseColor: Colors.transparent,
                        highlightColor: Colors.grey,
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
