import 'dart:convert';
import 'dart:io';
import 'package:dio/io.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp/whatsapp.dart';
import 'package:zelleclients/classes/revenue.dart';
import 'package:zelleclients/pages/subpages/analytics.dart';
import 'package:zelleclients/pages/subpages/mapLocation.dart';
import 'package:zelleclients/provider/provider1.dart';
import 'package:zelleclients/utils/loading2.dart';
import 'package:zelleclients/utils/multiText.dart';
import 'package:flutter/material.dart';
import '../../classes/soldProduct.dart';
import '../login.dart';
import 'package:circular_menu/circular_menu.dart';

class OrderDetailEdit extends StatefulWidget {
  String? pname;
  String? number;
  String? dt;
  String? name;
  String? status;
  List<SoldProduct> products;
  String? pt;
  String? ship;
  String? ot;
  String? email;
  String? phone;
  String? address;
  String? orderId;
  OrderDetailEdit(
      {super.key,
      required this.pname,
      required this.number,
      required this.dt,
      required this.name,
      required this.status,
      required this.products,
      required this.pt,
      required this.ship,
      required this.ot,
      required this.address,
      required this.email,
      required this.phone,
      required this.orderId});

  @override
  State<OrderDetailEdit> createState() => _OrderDetailEditState();
}

class _OrderDetailEditState extends State<OrderDetailEdit> {
  bool state = false;
  LatLng? loc;
  @override
  Widget build(BuildContext context) {
    final Provider11 = Provider.of<Provider1>(context);
    Future<LatLng> _getLatLngFromAddress(String address) async {
      List<Location> locations = await locationFromAddress(address);
      Location location = locations.first;
      loc = LatLng(location.latitude, location.longitude);
      await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShowOnMap(loc: loc!, address: address, name: widget.name, city: "Karachi", phone: widget.phone, status: widget.status,)));
      return LatLng(location.latitude, location.longitude);
  }
    WhatsApp whatsapp = WhatsApp();
    Color bgcol = Colors.black;

    updateOrderStatus(String status) async {
      try {
        EasyLoading.show(status: 'changing...');

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
            'https://${base}/wp-json/wc/v3/orders/${widget.orderId}?consumer_key=${ck}&consumer_secret=${cs}';

        FormData formData = FormData.fromMap({'status': status});

        Response response = await dio.post(url, data: formData);
        if (response.statusCode == 200) {
          print('Order status updated successfully.');
        } else {
          print('Error updating order status.');
        }
        EasyLoading.showSuccess('Great Success!');
        await Future.delayed(Duration(seconds: 3));
        EasyLoading.dismiss();
      } catch (e) {
        print(e.toString());
        EasyLoading.dismiss();
      }
    }

    final Uri whatsapp1 = Uri.parse("https://wa.me/3242824117");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: bgcol,
        appBar: AppBar(
          backgroundColor: Color(0xff1E1E1E),
          title: Text("${widget.number}"),
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 80.h,
                  width: double.infinity,
                  color: Color(0xff1E1E1E),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Multi(
                            color: Colors.grey,
                            subtitle: "${widget.dt}",
                            weight: FontWeight.bold,
                            size: 10),
                        Multi(
                            color: Colors.white,
                            subtitle: "${widget.pname}",
                            weight: FontWeight.w500,
                            size: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 20.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 157, 221, 214),
                                  borderRadius: BorderRadius.circular(5.r)),
                              child: Center(
                                  child: Multi(
                                      color: Color(0xff1E1E1E),
                                      subtitle: "${widget.status}",
                                      weight: FontWeight.normal,
                                      size: 10)),
                            ),
                            GestureDetector(
                              onTap: () {
                                Dialogs.bottomMaterialDialog(
                                    title: 'Change The Status',
                                    context: context,
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              IconsButton(
                                                onPressed: () async {
                                                  await updateOrderStatus(
                                                      "processing");
                                                  Navigator.pop(context);
                                                },
                                                text: 'Processing',
                                                color: Color(0xffC6E1C6),
                                                textStyle: TextStyle(
                                                    color: Color(0xff88841B)),
                                                iconColor: Colors.white,
                                              ),
                                              IconsButton(
                                                onPressed: () async {
                                                  await updateOrderStatus(
                                                      "on-hold");
                                                  Navigator.pop(context);
                                                },
                                                text: 'On Hold',
                                                color: Color(0xffF8DDA7),
                                                textStyle: TextStyle(
                                                    color: Color(0xff94660C)),
                                                iconColor: Colors.white,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          Column(
                                            children: [
                                              IconsButton(
                                                onPressed: () async {
                                                  await updateOrderStatus(
                                                      "completed");
                                                  Navigator.pop(context);
                                                },
                                                text: 'Completed',
                                                color: Color(0xffC8D7E1),
                                                textStyle: TextStyle(
                                                    color: Color(0xff2E4453)),
                                                iconColor: Colors.white,
                                              ),
                                              IconsButton(
                                                onPressed: () async {
                                                  await updateOrderStatus(
                                                      "cancelled");
                                                  Navigator.pop(context);
                                                },
                                                text: 'Cancelled',
                                                color: Color(0xffE5E5E5),
                                                textStyle: TextStyle(
                                                    color: Color(0xff7788B0)),
                                                iconColor: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ]);
                              },
                              child: Icon(
                                Icons.edit,
                                color: Color(0xffb929be),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 200.h,
                  width: double.infinity,
                  color: Color(0xff1E1E1E),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: Color(0xff1E1E1E),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: Multi(
                                        color: Colors.white,
                                        subtitle: "Products",
                                        weight: FontWeight.bold,
                                        size: 15),
                                  ),
                                  Container()
                                ],
                              ),
                            ),
                          )),
                      Expanded(
                          flex: 5,
                          child: Container(
                            color: Color(0xff1E1E1E),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: ListView.builder(
                                  itemCount: widget.products.length,
                                  itemBuilder: (ctx, index) {
                                    return Container(
                                      height: 80.h,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                                image: NetworkImage(widget
                                                    .products[index].imgAddress
                                                    .toString()),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Multi(
                                                  color: Colors.white,
                                                  subtitle: widget
                                                              .products[index]
                                                              .name
                                                              .toString()
                                                              .length >
                                                          15
                                                      ? "${widget.products[index].name.toString().substring(0, 14)}..."
                                                      : widget
                                                          .products[index].name
                                                          .toString(),
                                                  weight: FontWeight.normal,
                                                  size: 15),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Multi(
                                                  color: Colors.grey,
                                                  subtitle:
                                                      "${widget.products[index].quantity} x PKR${widget.products[index].eprice}",
                                                  weight: FontWeight.bold,
                                                  size: 12),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Multi(
                                                  color: Colors.white,
                                                  subtitle:
                                                      "PKR ${widget.products[index].tprice}",
                                                  weight: FontWeight.normal,
                                                  size: 15),
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              Container()
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 150.h,
                  width: double.infinity,
                  color: Color(0xff1E1E1E),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 7.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Multi(
                                color: Colors.grey,
                                subtitle: "Payment",
                                weight: FontWeight.bold,
                                size: 12),
                            Container()
                          ],
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Divider(
                          thickness: 1.h,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Multi(
                                color: Colors.white,
                                subtitle: "Products total",
                                weight: FontWeight.w500,
                                size: 13),
                            Multi(
                                color: Colors.white,
                                subtitle:
                                    "${double.parse(widget.pt.toString()) - double.parse(widget.ship.toString())}",
                                weight: FontWeight.w500,
                                size: 13),
                          ],
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Multi(
                                color: Colors.white,
                                subtitle: "Shipping",
                                weight: FontWeight.w500,
                                size: 13),
                            Multi(
                                color: Colors.white,
                                subtitle: "${widget.ship}",
                                weight: FontWeight.w500,
                                size: 13),
                          ],
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Multi(
                                color: Colors.white,
                                subtitle: "Taxes",
                                weight: FontWeight.w500,
                                size: 13),
                            Multi(
                                color: Colors.white,
                                subtitle: "0",
                                weight: FontWeight.w500,
                                size: 13),
                          ],
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Multi(
                                color: Colors.white,
                                subtitle: "Order total",
                                weight: FontWeight.w500,
                                size: 13),
                            Multi(
                                color: Colors.white,
                                subtitle: "${widget.pt}",
                                weight: FontWeight.bold,
                                size: 13),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 150.h,
                  width: double.infinity,
                  color: Color(0xff1E1E1E),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 7.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Multi(
                                color: Colors.grey,
                                subtitle: "Customer Information",
                                weight: FontWeight.bold,
                                size: 12),
                            Container()
                          ],
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Divider(
                          thickness: 1.h,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Multi(
                                color: Colors.white,
                                subtitle: "Name",
                                weight: FontWeight.w500,
                                size: 13),
                            Multi(
                                color: Colors.white,
                                subtitle: "${widget.name}",
                                weight: FontWeight.w500,
                                size: 13),
                          ],
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Multi(
                                color: Colors.white,
                                subtitle: "Email",
                                weight: FontWeight.w500,
                                size: 13),
                            Multi(
                                color: Colors.white,
                                subtitle: "${widget.email}",
                                weight: FontWeight.w500,
                                size: 13),
                          ],
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Multi(
                                color: Colors.white,
                                subtitle: "Phone",
                                weight: FontWeight.w500,
                                size: 13),
                            Multi(
                                color: Colors.white,
                                subtitle: "${widget.phone}",
                                weight: FontWeight.w500,
                                size: 13),
                          ],
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Multi(
                                color: Colors.white,
                                subtitle: "Address",
                                weight: FontWeight.w500,
                                size: 13),
                            Container(
                              width: 200.w,
                              child: Multi(
                                  color: Colors.white,
                                  subtitle: "${widget.address}",
                                  weight: FontWeight.w500,
                                  size: 7),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: widget.address=='pickup from branch'?80.h:150.h,
                  width: double.infinity,
                  color: Color(0xff1E1E1E),
                  child: Column(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    child: ElevatedButton(
                                      onPressed: () async{
                                        await  FlutterPhoneDirectCaller.callNumber(widget.phone.toString());
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Image.asset(
                                            "assets/call.png",
                                            height: 45.h,
                                            width: 45.w,
                                          ),
                                          Multi(
                                              color: Colors.white,
                                              subtitle: "Phone Call",
                                              weight: FontWeight.bold,
                                              size: 12)
                                        ],
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary:
                                              Color.fromARGB(255, 54, 53, 53),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.w, vertical: 5.h),
                                          textStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          final countryCode =
                                              '92'; // Replace with the country code for Pakistan
                                          final url =
                                              'https://wa.me/$countryCode${widget.phone}'; // Construct the URL

                                          if (await canLaunch(url)) {
                                            await launch(url);
                                          } else {
                                            throw 'Could not launch WhatsApp. Make sure the app is installed on your device.';
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Image.asset(
                                              "assets/whatsapp.png",
                                              height: 45.h,
                                              width: 45.w,
                                            ),
                                            Container(
                                                width: 70.w,
                                                child: Multi(
                                                    color: Colors.white,
                                                    subtitle: "Whatsapp Call",
                                                    weight: FontWeight.bold,
                                                    size: 12))
                                          ],
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary:
                                                Color.fromARGB(255, 54, 53, 53),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.w,
                                                vertical: 5.h),
                                            textStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  )),
                            ],
                          )),
                    widget.address=='pickup from branch'?Container():  Expanded(
                          flex: 3,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  try {
                                    _getLatLngFromAddress(widget.address.toString());
                                  } catch (e) {
                                    print('${e} error is here');
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/map.png",
                                      height: 45.h,
                                      width: 45.w,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Multi(
                                        color: Colors.white,
                                        subtitle: "Google Map Location",
                                        weight: FontWeight.bold,
                                        size: 12)
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 54, 53, 53),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 5.h),
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      builder: EasyLoading.init(),
    );
  }
}
