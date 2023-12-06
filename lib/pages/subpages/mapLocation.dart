import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utils/heading2.dart';
import '../../utils/heading3.dart';
import '../../utils/heading4.dart';









class ShowOnMap extends StatelessWidget {
  LatLng loc;
  String? name;
  String? address;
  String? city;
  String? phone;
  String? status;
  ShowOnMap({super.key,required this.loc,required this.name,required this.address,required this.city,required this.phone,required this.status});
  @override
  Widget build(BuildContext context) {
  final Completer<GoogleMapController> _controller = Completer();
     late GoogleMapController _controller1;
  onMapCreated(GoogleMapController controller) async {
    _controller1 = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/json/dark.json');
    _controller1.setMapStyle(value);
  }
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff1E1E1E),
          title: Text("Location"),
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      body:Stack(
          children: [
          
            Container(
              child: GoogleMap(
                zoomControlsEnabled: false,
               onMapCreated: onMapCreated,
                initialCameraPosition:
                                CameraPosition(
                                  target: loc, 
                                  zoom: 12
                                  ),
               markers: {
                 Marker(
                                markerId: MarkerId("Your Location"),
                                position: loc,
                                
                                 
                              ),
               },
               
              ),
            ),
             Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 180.h,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffA4A4A4),
                        blurRadius: 6.0,
                        spreadRadius: 1.0,
                        offset: Offset(0.0, 0.0),
                        // Shadow position
                      ),
                    ],
                    color: Color(0xff1E1E1E),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 20.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Heading2(head: "${name}"),
                        Heading4(head: "${address}"),
                        Container(
                          height: 30.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 6.h),
                            child: Text(
                              "$status",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15.w, right: 15.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Heading3(head: "$phone"),
                              Heading4(head: city),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      
      
    );
  }
}



