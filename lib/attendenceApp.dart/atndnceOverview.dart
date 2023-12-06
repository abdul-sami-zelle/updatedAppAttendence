// import 'package:analog_clock/analog_clock.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:gradient_borders/box_borders/gradient_box_border.dart';
// import 'package:http/http.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// import 'package:zelleclients/provider/provider1.dart';
// import 'package:zelleclients/utils/multiText.dart';
// import 'package:zelleclients/utils/neonButton.dart';
// import 'dart:math' as math;
// import 'package:intl/intl.dart';
// import '../../utils/atndncHistory.dart';
// import '../../utils/numbersMulti.dart';
// import 'package:flutter_charts/flutter_charts.dart' as charts;


// class AttendenceOverview extends StatelessWidget {
//   var list1;
//   AttendenceOverview({super.key,required this.list1});
  

//   @override
//   Widget build(BuildContext context) {
//     return MyTableWidget(data: list1);
//   }
// }

// class _MyDataSource extends DataGridSource {
//   final List<check_in_out>? data;

//   _MyDataSource(this.data) {
//     _updateDataGridRows();
//   }

//   void _updateDataGridRows() {
//     dataGridRows = data!.map<DataGridRow>((checkInOut) {
//       return DataGridRow(cells: [
//         DataGridCell<String>(columnName: 'date', value: checkInOut.date),
//         DataGridCell<String>(columnName: 'check_in', value: checkInOut.check_in),
//         DataGridCell<String>(columnName: 'check_out', value: checkInOut.check_out),
//       ]);
//     }).toList();
//   }

//   List<DataGridRow> dataGridRows = [];

//   @override
//   List<DataGridRow> get rows => dataGridRows;

//   @override
//   DataGridRowAdapter buildRow(DataGridRow row) {
//     return DataGridRowAdapter(cells: [
//       Container(padding: EdgeInsets.all(16.0), child: Text(row.getCells()[0].value.toString())),
//       Container(padding: EdgeInsets.all(16.0), child: Text(row.getCells()[1].value.toString())),
//       Container(padding: EdgeInsets.all(16.0), child: Text(row.getCells()[2].value.toString())),
//     ]);
//   }
// }


// class MyTableWidget extends StatelessWidget {
//   final List<check_in_out>? data;

//   MyTableWidget({required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Check-In/Check-Out Table'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SfDataGrid(
//               source: _MyDataSource(data),
//               columns: [
//                 GridTextColumn(
//                   columnName: 'date',
//                   label: Container(padding: EdgeInsets.all(16.0), child: Text('Date')),
//                 ),
//                 GridTextColumn(
//                   columnName: 'check_in',
//                   label: Container(padding: EdgeInsets.all(16.0), child: Text('Check-In')),
//                 ),
//                 GridTextColumn(
//                   columnName: 'check_out',
//                   label: Container(padding: EdgeInsets.all(16.0), child: Text('Check-Out')),
//                 ),
//               ],
//             ),
            
//           ],
//         ),
//       ),
//     );
//   }
// }

// DateTime parseDateTime(String date, String time) {
//   final components = date.split('-');
//   final day = int.parse(components[0]);
//   final month = int.parse(components[1]);
//   final year = int.parse(components[2]);

//   final timeComponents = time.split(':');
//   final hour = int.parse(timeComponents[0]);
//   final minute = int.parse(timeComponents[1]);
//   final second = int.parse(timeComponents[2]);

//   return DateTime(year, month, day, hour, minute, second);
// }

// List<charts.Series<check_in_out, DateTime>> createSeriesData(List<check_in_out> data) {
//   final seriesData = [
//     charts.Series<check_in_out, DateTime>(
//       id: 'CheckInOut',
//       data: data,
//       domainFn: (check_in_out checkInOut, _) => parseDateTime(checkInOut.check_in.toString(), checkInOut.check_out.toString()),
//       measureFn: (check_in_out checkInOut, _) => 0, // We don't have a measure, so we set it to 0
//     ),
//   ];

//   return seriesData;
// }


