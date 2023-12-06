import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zelleclients/pages/landingPage.dart';
import 'package:zelleclients/pages/orders.dart';
import 'package:zelleclients/pages/splash.dart';
import 'package:zelleclients/pages/subpages/categories.dart';
import 'package:zelleclients/provider/provider1.dart';
import 'package:zelleclients/utils/forgotLink.dart';

import '../utils/multiText.dart';
import '../utils/showCategories.dart';

// class Products extends StatelessWidget {
//   const Products({super.key});

//   @override
//   Widget build(BuildContext context) {
// final Provider11 = Provider.of<Provider1>(context);
// List<dynamic>? products1;
// Pro() async {
//   try {
//     Dio dio = Dio();
//     String consumerKey = Provider11.ck.toString();
//     String consumerSecret = Provider11.cs.toString();
//     String base = "sialkotbakers.pk";
//     String url =
//         'https://${base}/wp-json/wc/v3/products?page=1&per_page=100&consumer_key=ck_326948a21e2fd1d837fb9b7852f1cf9ada73463d&consumer_secret=cs_45d1e192a5e62fa3584bd07fd7cf1ebffef7b73e';
//     Response response = await dio.get(url);
//     final headers = response.headers;
//     final totalPages = headers['x-wp-totalpages'];
//     products1 = response.data;
//     if (totalPages != 1) {
//       for (int i = 2; i <= int.parse(totalPages.toString()); i++) {
//          String url2 =
//         'https://${base}/wp-json/wc/v3/products?page=${i}&per_page=100&consumer_key=ck_326948a21e2fd1d837fb9b7852f1cf9ada73463d&consumer_secret=cs_45d1e192a5e62fa3584bd07fd7cf1ebffef7b73e';
//          Response response2 = await dio.get(url2);
//          print(response2.data);
//       }
//     }
//     print("${products1![0]['name']}------------>");
//     print("${totalPages}=====>");
//     return response.data;
//   } catch (e) {
//     print(e);
//   }
// }

//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Color(0xff1E1E1E),
//         title: Text("Products"),
//       ),
//       body: FutureBuilder(
//           future: Pro(),
//           builder: (ctx, snapshot) {
//             if (snapshot.hasError) {
//               return Text("error");
//             }
//             if (snapshot.hasData) {
//               return ListView.builder(
//                   itemCount: products1!.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return GestureDetector(
//                       onTap: () {},
// child: Padding(
//   padding: EdgeInsets.symmetric(horizontal: 15.w),
//   child: Container(
//     height: 80.h,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Container(
//           height: 50.h,
//           width: 50.w,
//           decoration: BoxDecoration(
//             border:
//                 Border.all(color: Colors.grey, width: 1),
//             borderRadius: BorderRadius.circular(4.r),
//             color: Colors.white,
//             image: DecorationImage(
//               image: NetworkImage(
//                 products1![index]['images'].isEmpty
//                     ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
//                     : products1![index]['images'][0]
//                         ['src'],
//               ),
//               fit: BoxFit.fill,
//             ),
//           ),
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Multi(
//                 color: Colors.white,
//                 subtitle: products1![index]['name']
//                             .toString()
//                             .length >
//                         15
//                     ? "${products1![index]['name'].toString().substring(0, 14)}..."
//                     : products1![index]['name'],
//                 weight: FontWeight.normal,
//                 size: 15),
//             SizedBox(
//               height: 5.h,
//             ),
//             // Multi(
//             //     color: Colors.grey,
//             //     subtitle:
//             //         "${products[index].quantity} x PKR${products[index].eprice}",
//             //     weight: FontWeight.bold,
//             //     size: 12),
//           ],
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Multi(
//                 color: Colors.white,
//                 subtitle:
//                     "PKR ${products1![index]['price'].toString()}",
//                 weight: FontWeight.normal,
//                 size: 15),
//             SizedBox(
//               height: 15.h,
//             ),
//             Container()
//           ],
//         ),
//       ],
//     ),
//   ),
//                       ),
//                     );
//                   });
//             }
//             return ShimmerEffect();
//           }),
//     );
//   }
// }

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    final Provider11 = Provider.of<Provider1>(context);
    List<dynamic>? products1;
    Pro() async {
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
            'https://${base}/wp-json/wc/v3/products/categories?consumer_key=${ck}&consumer_secret=${cs}';
        Response response = await dio.get(url);
        return response.data;
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xff1E1E1E),
        title: Text("Products"),
      ),
      body: FutureBuilder(
          future: Pro(),
          builder: (ctx, snapshot) {
            if (snapshot.hasError) {
              print("error");
            }
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoriacalPage(
                                    id: snapshot.data[index]['id']
                                        .toString(), name:snapshot.data[index]['name'] ,)));
                      },
                      child: ShowCategory(
                          imgAddress: snapshot.data[index]['image']!=null?snapshot.data[index]['image']['src']:"",
                          title: snapshot.data[index]['name']),
                    );
                  });
            }
            return ShimmerEffect();
          }),
    );
  }
}
