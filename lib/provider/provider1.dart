import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../attendenceApp.dart/day/employAttendenceDay.dart';
import '../attendenceApp.dart/night/employAttendenceNight.dart';
import '../attendenceApp.dart/zelleLogin.dart';
import '../utils/multiText.dart';

class Provider1 extends ChangeNotifier {
  // keys for clients //

  String? cs;
  String? ck;
  String? name;
  String? base;
  bool? state;

  // keys for employes //

  String? emp_name;
  String? emp_uid;
  String? emp_profile;
  String? emp_designation;
  String? emp_shift;
  String? emp_hours;
  String? emp_in;
  String? emp_out;
  int? in_last_hour;
  int? in_last_min;
  Map<String,dynamic> inHours = {};
  Map<String,dynamic> branchDetails = {};
  String? type;

  String? state2;

  // employe_wise_data_list
  List<check_in_out> inout = [];

    String? internetAvailabilty;
  checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      internetAvailabilty = "none";
      print("No Internet connection");
        notifyListeners();
    } else if (connectivityResult == ConnectivityResult.mobile) {
      internetAvailabilty = "yes";
      print("Mobile data connection");
        notifyListeners();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      internetAvailabilty = "yes";
      print("Wi-Fi connection");
        notifyListeners();
    }

  }

  notifyListeners();

  String atndncBtnState = "enable";
  String pg = "home";
  String pg2 = "checkin";

  gett() {
    TimeOfDay targetTime = TimeOfDay(hour: 15, minute: 0);
    // Get the current time as a TimeOfDay object
    TimeOfDay now = TimeOfDay.now();

    if (targetTime.hour < now.hour ||
        (targetTime.hour == now.hour && targetTime.minute < now.minute)) {
      print('The target time is earlier than the current time');
    } else if (targetTime.hour > now.hour ||
        (targetTime.hour == now.hour && targetTime.minute > now.minute)) {
      print('The target time is later than the current time');
    } else {
      print('The target time is the same as the current time');
    }
    notifyListeners();
  }
 int? int_in ;
  getDay(){
     final currentDay = DateTime.now().toLocal().weekday;
    
  String? dayOfWeek;
  
    switch (currentDay) {
      case DateTime.sunday:
        dayOfWeek = 'sunday';
        break;
      case DateTime.monday:
        dayOfWeek = 'monday';
        break;
      case DateTime.tuesday:
        dayOfWeek = 'tuesday';
        break;
      case DateTime.wednesday:
        dayOfWeek = 'wednesday';
        break;
      case DateTime.thursday:
        dayOfWeek = 'thursday';
        break;
      case DateTime.friday:
        dayOfWeek = 'friday';
        break;
      case DateTime.saturday:
        dayOfWeek = 'saturday';
        break;
    }
  int_in = int.parse(inHours[dayOfWeek].toString());
  in_last_hour = int_in;
  // print("${int_in} todays in time is here");
  }

  String? formattedMonth;
  String? formattedDate;
  String? pformattedDate;
  getDate() {
    var now = DateTime.now();
    var monthFormat = DateFormat('MMMM y');
    formattedMonth = monthFormat.format(now);
    var dateFormat = DateFormat('d-M-yyyy');
    formattedDate = dateFormat.format(now);

    notifyListeners();
  }

  checkOutDate() {
    var now = DateTime.now().subtract(Duration(days: 1));
    var monthFormat = DateFormat('MMMM y');
    formattedMonth = monthFormat.format(now);
    var dateFormat = DateFormat('d-M-yyyy');
    pformattedDate = dateFormat.format(now);

    notifyListeners();
  }

  changer() {
    if (state2 == null) {
      state2 = "not";
    } else {
      state2 = null;
    }
    notifyListeners();
  }

  Stream<bool> checkTargetTimeStream() async* {
    notifyListeners();
    // Periodically check the target time every 5 seconds
    const duration = Duration(seconds: 5);
    while (true) {
      TimeOfDay targetTime = TimeOfDay(
          hour: int.parse(in_last_hour.toString()),
          minute: int.parse(in_last_min.toString()));
      TimeOfDay now = TimeOfDay.now();
      if (targetTime.hour < now.hour ||
          (targetTime.hour == now.hour && targetTime.minute < now.minute)) {
        atndncBtnState = "unenable";
        yield false;
      } else if (targetTime.hour > now.hour ||
          (targetTime.hour == now.hour && targetTime.minute > now.minute)) {
        yield false;
      }
      else if (targetTime.hour > now.hour ||
          (targetTime.hour == now.hour && targetTime.minute > now.minute)) {
        atndncBtnState="un";

        yield false;}
      else {
        // If the target time is the same as the current time, wait for 2 seconds and then yield true
        await Future.delayed(Duration(seconds: 2));

        yield true;
      }
      await Future.delayed(duration);
    }
  }








  String? checkout_last;
  String? checkin_last;

  // String? p_checkout_last;
  // String? p_checkin_last;
  setd(context) async {
    await getDate();
    await checkOutDate();
    DatabaseReference reference = FirebaseDatabase.instance.ref(
        "attendence/${formattedMonth}/${emp_shift}/${formattedDate}/${emp_uid}");
    // DatabaseReference reference2 = FirebaseDatabase.instance.ref(
    //     "attendence/${formattedMonth}/${emp_shift}/${pformattedDate}/${emp_uid}");
  await  reference.onValue.listen((DatabaseEvent event) {
      // Access the value of the specific field and store it in a variable
      Map<dynamic, dynamic> data2 =
          event.snapshot.value as Map<dynamic, dynamic>;
      checkout_last = data2["checkout"];
      checkin_last = data2["checkin"];
       if (checkin_last != null && checkout_last == null)  {
       atndncBtnState = "un";
    }
    
    }, onError: (error) {
      print("Error fetching data: $error");
    });
  }

  setN(context) async {
    await getDate();
    await checkOutDate();
    if (TimeOfDay(hour: 16, minute: 00).hour>=15) {
        DatabaseReference reference = FirebaseDatabase.instance.ref(
        "attendence/${formattedMonth}/${emp_shift}/${formattedDate}/${emp_uid}");
    DatabaseReference reference2 = FirebaseDatabase.instance.ref(
        "attendence/${formattedMonth}/${emp_shift}/${pformattedDate}/${emp_uid}");
  await  reference.onValue.listen((DatabaseEvent event) {
      // Access the value of the specific field and store it in a variable
      Map<dynamic, dynamic> data2 =
          event.snapshot.value as Map<dynamic, dynamic>;
      checkout_last = data2["checkout"];
      checkin_last = data2["checkin"];
       if (checkin_last != null && checkout_last == null)  {
       atndncBtnState = "un";
    }
    
    }, onError: (error) {
      print("Error fetching data: $error");
    });
    }
    else{
        DatabaseReference reference = FirebaseDatabase.instance.ref(
        "attendence/${formattedMonth}/${emp_shift}/${formattedDate}/${emp_uid}");
    DatabaseReference reference2 = FirebaseDatabase.instance.ref(
        "attendence/${formattedMonth}/${emp_shift}/${pformattedDate}/${emp_uid}");
  await  reference.onValue.listen((DatabaseEvent event) {
      // Access the value of the specific field and store it in a variable
      Map<dynamic, dynamic> data2 =
          event.snapshot.value as Map<dynamic, dynamic>;
     
      checkin_last = data2["checkin"];
       if (checkin_last != null && checkout_last == null)  {
       atndncBtnState = "un";
    }
    
    }, onError: (error) {
      print("Error fetching data: $error");
    });

     await  reference2.onValue.listen((DatabaseEvent event) {
      // Access the value of the specific field and store it in a variable
      Map<dynamic, dynamic> data2 =
          event.snapshot.value as Map<dynamic, dynamic>;
      checkout_last = data2["checkout"];
     
       if (checkin_last != null && checkout_last == null)  {
       atndncBtnState = "un";
    }
    
    }, onError: (error) {
      print("Error fetching data: $error");
    });
    }
  }





  fetchAttendenceHistory() {
    DatabaseReference reference = FirebaseDatabase.instance.ref(
        "attendence/${formattedMonth}/${emp_shift}/${formattedDate}/${emp_uid}");

    reference.onValue.listen((DatabaseEvent event) {
      // Access the value of the specific field and store it in a variable
      Map<dynamic, dynamic> data2 =
          event.snapshot.value as Map<dynamic, dynamic>;
      checkout_last = data2["checkout"];
      checkin_last = data2["checkin"];
      if (checkin_last!.isNotEmpty == true) {
        atndncBtnState = "un";
      }
      // Do something with the value
      print("Field value: ${checkout_last}");
    }, onError: (error) {
      print("Error fetching data: $error");
    });
  }

  nightTotalHours() {
    String time24 = '24:00:00';
    String checkin = '17:00:00';
    String checkout = '10:00:00';

    // Parse the time strings using the Duration class
    Duration duration24 = Duration(
        hours: int.parse(time24.split(':')[0]),
        minutes: int.parse(time24.split(':')[1]),
        seconds: int.parse(time24.split(':')[2]));
    Duration durationSubtract = Duration(
        hours: int.parse(checkin.split(':')[0]),
        minutes: int.parse(checkin.split(':')[1]),
        seconds: int.parse(checkin.split(':')[2]));
    Duration durationAdded2 = Duration(
        hours: int.parse(checkout.split(':')[0]),
        minutes: int.parse(checkout.split(':')[1]),
        seconds: int.parse(checkout.split(':')[2]));

    // Subtract the durations
    Duration checkin_result = duration24 - durationSubtract;
    Duration checkin_result1 = checkin_result + durationAdded2;

    // Format the result to a time string using the Duration class
    String checkin_result_ =
        '${checkin_result.inHours.toString().padLeft(2, '0')}:${(checkin_result.inMinutes % 60).toString().padLeft(2, '0')}:${(checkin_result.inSeconds % 60).toString().padLeft(2, '0')}';
    String total =
        '${checkin_result1.inHours.toString().padLeft(2, '0')}:${(checkin_result1.inMinutes % 60).toString().padLeft(2, '0')}:${(checkin_result1.inSeconds % 60).toString().padLeft(2, '0')}';

    print('total hours: $total');
    print('check in : $checkin');
    print('check out : $checkout');
    print('checkin_result_: $checkin_result_');

    notifyListeners();
  }

  Stream<bool> checkTargetTimeStreamNight() async* {
    notifyListeners();
    // Periodically check the target time every 5 seconds
    const duration = Duration(seconds: 5);
    while (true) {
      TimeOfDay targetTime = TimeOfDay(
          hour: int.parse(in_last_hour.toString()),
          minute: int.parse(in_last_min.toString()));
      TimeOfDay targetTimelasted = TimeOfDay(hour: 15, minute: 00);
      TimeOfDay now = TimeOfDay.now();
      // if (targetTime.hour < now.hour ||
      //   (targetTime.hour == now.hour && targetTime.minute < now.minute)) {
      // atndncBtnState = "unenable";
      // yield false;
      // }
      if (((targetTimelasted.hour > now.hour ||
              (targetTimelasted.hour >= now.hour &&
                  targetTimelasted.minute < now.minute)) &&
          (targetTime.hour > now.hour ||
              (targetTime.hour >= now.hour &&
                  targetTime.minute < now.minute)))) {
        atndncBtnState = "unenable";
        yield false;
      } else if (((targetTimelasted.hour < now.hour ||
              (targetTimelasted.hour < now.hour &&
                  targetTimelasted.minute > now.minute)) &&
          (targetTime.hour < now.hour ||
              (targetTime.hour < now.hour &&
                  targetTime.minute > now.minute)))) {
        atndncBtnState = "un";

        yield false;
      } else {
        // If the target time is the same as the current time, wait for 2 seconds and then yield true
        await Future.delayed(Duration(seconds: 2));

        yield true;
      }
      await Future.delayed(duration);
    }
  }

  String? formattedYear1;
  String? formattedMonth1;
  String? formatted;

  getDateTimeNow(){
    DateTime now = DateTime.now();
      print(formattedMonth);
      notifyListeners();
  }
  
 bool disableBreakButton = false;
 enableBreakButton(){
  disableBreakButton = !disableBreakButton;
  notifyListeners();
 }


Future<bool> checkActiveStatus() async {
  try {
    // Replace 'appBreak' with your collection name and 'p87RllzQ3AluLlYxC5Ha' with the document ID
    var querySnapshot = await FirebaseFirestore.instance
        .collection('appBreak')
        .doc("p87RllzQ3AluLlYxC5Ha")
        .collection(emp_shift!)
        .where('active', isEqualTo: 'yes')
        .get();

    // Check if there are any documents that meet the condition
    notifyListeners();
    disableBreakButton = querySnapshot.docs.isNotEmpty;
    print(querySnapshot.docs.isNotEmpty);
    return querySnapshot.docs.isNotEmpty;
  } catch (e) {
    print('Error checking active status: $e');
    notifyListeners();
    disableBreakButton =false;
    return false; // Return false in case of an error
  }
  
}


  // checkBreakActive()async{
  // await  FirebaseFirestore.instance
  //   .collection('appBreak').doc("p87RllzQ3AluLlYxC5Ha").collection(emp_shift!)
  // .where('active', isEqualTo: "yes")
  // .get()
  // .then(
  //   enableBreakButton()
  // );
   
  // }


  String? startTime;

  
  addBreakDataBase()async{
   await FirebaseFirestore.instance
    .collection('appBreak').doc("p87RllzQ3AluLlYxC5Ha").collection(emp_shift!)
    .doc(formattedMonth)
    .get()
    .then((DocumentSnapshot documentSnapshot) async{
      if (documentSnapshot.exists) {
           await FirebaseFirestore.instance
    .collection('appBreak').doc("p87RllzQ3AluLlYxC5Ha").collection(emp_shift!)
    .doc(formattedMonth).update({
       "active":"yes",
       "startTime":DateTime.now().toString()
    });
        
      
      }
      else{
         await FirebaseFirestore.instance
    .collection('appBreak').doc("p87RllzQ3AluLlYxC5Ha").collection(emp_shift!)
    .doc(formattedMonth).set({
       "breaks":[
          // {
          //   "start":DateTime.now().toString(),
          //   "end":"",
          //   "duration":""
          // }
       ],
       "active":"yes",
       "startTime":DateTime.now().toString()
    });
      }
    });
  }

  offBreakButton()async{
        var data = await FirebaseFirestore.instance
          .collection('appBreak').doc("p87RllzQ3AluLlYxC5Ha").collection(emp_shift!)
          .doc(formattedMonth).get();
          startTime = data['startTime'];
 await FirebaseFirestore.instance
    .collection('appBreak').doc("p87RllzQ3AluLlYxC5Ha").collection(emp_shift!)
    .doc(formattedMonth).update({
       "breaks":FieldValue.arrayUnion([
         {
            "start":startTime.toString(),
            "end":DateTime.now().toString(),
            "duration":""
          }
       ]),
       "active":"no",
       "startTime":""
    });
        
  }


String getFormatedMonth(){
  var now = DateTime.now();
  var monthFormat = DateFormat('MMMM y');
  return monthFormat.format(now);
}






Map<String, dynamic> octoberDates = {};
getActualCheckInCurrentMonth( String uid ,String dated ) async{
print(getFormatedMonth);
await FirebaseFirestore.instance.collection("actualCheckIns").doc("$uid").get().then((DocumentSnapshot documentSnapshot){
  if (documentSnapshot.exists) {
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      octoberDates = data[dated];
      print(octoberDates);
  } else {
    print("not not not");
  }
});
}


  Map<String, dynamic> sorting(Map<String, dynamic> uidData) {
    // Parse and sort the keys as DateTime objects
    List<String> sortedKeys = uidData.keys.toList()
      ..sort((a, b) {
        var aParts = a.split('-').map(int.parse).toList();
        var bParts = b.split('-').map(int.parse).toList();
        var aDate = DateTime(aParts[2], aParts[1], aParts[0]);
        var bDate = DateTime(bParts[2], bParts[1], bParts[0]);
        return aDate.compareTo(bDate);
      });

    // Create a new map with sorted keys
    Map<String, dynamic> sortedUidData = {};
    for (var key in sortedKeys) {
      sortedUidData[key] = uidData[key];
    }

    // Print the sorted map
    return sortedUidData;
  }



    String? statusCategorization2(String dailyArrival, String date) {
    String arrivalCategory = categorizeArrival2(octoberDates[date]!, dailyArrival);
    return arrivalCategory;
  }

  String categorizeArrival2(String actualArrivalTime, String dailyArrival) {
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
      return "late";
    } else if (timeDifference <= lateThreshold &&
        timeDifference > Duration(minutes: 0, hours: 0, seconds: 0)) {
      return "on Time";
    } else {
      return "early";
    }
  }


 String getTimeDifference(String startTimeStr, String endTimeStr) {
    List<int> startTimeParts = startTimeStr.split(':').map(int.parse).toList();
    List<int> endTimeParts = endTimeStr.split(':').map(int.parse).toList();

    DateTime startTime = DateTime(
        0, 1, 1, startTimeParts[0], startTimeParts[1], startTimeParts[2]);
    DateTime endTime =
        DateTime(0, 1, 1, endTimeParts[0], endTimeParts[1], endTimeParts[2]);

    if (endTime.isBefore(startTime)) {
      // If end time is before start time, add a day to the end time
      endTime = endTime.add(Duration(days: 1));
    }

    Duration difference = endTime.difference(startTime);

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    int hours = difference.inHours;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60;

    return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
  }




    String? statusCategorization(String dailyArrival , String date) {
    String actualArrivalTime = octoberDates[date];

    String arrivalCategory = categorizeArrival(actualArrivalTime, dailyArrival);
  //  timee.add(arrivalCategory);
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
      print(timeDifference.inMinutes);
      return "late";
    } else if (timeDifference < Duration(minutes: 0, hours: 0, seconds: 0)) {
      return "early";
    } else {
      print(timeDifference);
      return "onTime";
    }
  }


// fetch all months:

  var data2 = {};
  var attendanceMonths = [];

  Future fetchAttendanceMonths() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('attendence').get();
    if (snapshot.exists) {
      data2 = convertSnapshotValue(snapshot.value);;
      attendanceMonths = data2.keys.toList();
    } else {
      print('No data available.');
    }
    return attendanceMonths;
  }


    Map<String, dynamic> convertSnapshotValue(dynamic value) {
  if (value is Map<String, dynamic>) {
    return value;
  } else if (value is Map<Object?, Object?>) {
    // Convert _Map<Object?, Object?> to Map<String, dynamic>
    Map<String, dynamic> convertedMap = {};
    value.forEach((key, val) {
      if (key is String) {
        convertedMap[key] = val;
      }
    });
    return convertedMap;
  } else {
    // Handle other cases or return an empty map if needed
    return {};
  }
}














//

bool waitingState = false;

changeWaitingState( bool value){
  waitingState = value;
  notifyListeners();
}







// location working

bool showCheckInCheckOut = false;

changeShowCheckInCheckOut(bool value){
  showCheckInCheckOut = value;
  notifyListeners();
}








  double? currentlatitude ;
  double? currentlongitude ;

Future<void> getCurrentLocation() async {
  await [Permission.location].request();

  // Check if location services are enabled
  bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!isLocationServiceEnabled) {
    // Location services are not enabled
    return;
  }

  // Request permission to access location
  LocationPermission permission = await Geolocator.requestPermission();
  if (permission != LocationPermission.always && permission != LocationPermission.whileInUse) {
    // Permission not granted
    return;
  }

  // Get current position
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  currentlatitude = position.latitude;
  currentlongitude = position.longitude;

  print('Latitude: $currentlatitude, Longitude: $currentlongitude');
}

// bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
// if (!isLocationServiceEnabled) {
//   // Location services are not enabled
//   return;
// }



















  double rangeInMeters = 0.05;
  // double officeLocationLat = 24.9026302;
  // double officeLocationLng = 67.1143481;
  bool? inLocation;

  double calculateLatitudeRange() {
    // 1 degree of latitude is approximately 111 kilometers
    double degreesPerKilometer = 1 / 111.0;
    return rangeInMeters * degreesPerKilometer;
  }

  double calculateLongitudeRange() {
    // 1 degree of longitude varies based on latitude
    double degreesPerKilometer = 1 / (111.0 * 1.0);
    return rangeInMeters * degreesPerKilometer;
  }




 Future<bool> checkLocationInRange() async{
    await getCurrentLocation();
    double latRange = calculateLatitudeRange();
    double lngRange = calculateLongitudeRange();
    double minLat = double.parse(branchDetails['latitude'].toString()) - latRange;
    double maxLat = double.parse(branchDetails['latitude'].toString()) + latRange;
    double minLng = double.parse(branchDetails['longitude'].toString()) - lngRange;
    double maxLng = double.parse(branchDetails['longitude'].toString()) + lngRange;
  
    await changeShowCheckInCheckOut((currentlatitude! >= minLat && currentlatitude! <= maxLat) && (double.parse(branchDetails['longitude'].toString()) >= minLng && double.parse(branchDetails['longitude'].toString()) <= maxLng));

  //  notifyListeners();
    return (currentlatitude! >= minLat && currentlatitude! <= maxLat) && (double.parse(branchDetails['longitude'].toString()) >= minLng && double.parse(branchDetails['longitude'].toString()) <= maxLng);
  }








moveToNext(context)async{
  try {
    await changeWaitingState(true);
  await checkLocationInRange();    
  await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EmployeAttendenceDay()),
                                );
  await changeWaitingState(false);
  } catch (e) {
    await changeWaitingState(false);
  }
  
}














}

class check_in_out {
  String? date;
  String? check_in;
  String? check_out;
  check_in_out(
      {required this.date, required this.check_in, required this.check_out});
}
