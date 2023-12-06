import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class Location11 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double currentLatitude = 0.0;
  double currentLongitude = 0.0;
  double rangeInMeters = 0.05; // Adjust this value as needed

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        currentLatitude = position.latitude;
        currentLongitude = position.longitude;
      });

      // Calculate the range
      double latRange = calculateLatitudeRange();
      double lngRange = calculateLongitudeRange();

      print('Current Location: ($currentLatitude, $currentLongitude)');
      print('Latitude Range: $latRange');
      print('Longitude Range: $lngRange');

      // Example: Check if a given location is within the range
      double testLatitude = currentLatitude; // Replace with the latitude to test
      double testLongitude = currentLongitude; // Replace with the longitude to test

      bool isInRange = checkLocationInRange(24.902628,67.1143292);
      print('Is in Range: $isInRange');
    } catch (e) {
      print('Error: $e');
    }
  }

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

  double officeLocationLat = 24.9026302;
  double officeLocationLng = 67.1143481;


  bool checkLocationInRange(double latitude, double longitude) {
    double latRange = calculateLatitudeRange();
    double lngRange = calculateLongitudeRange();

    double minLat = officeLocationLat - latRange;
    double maxLat = officeLocationLat + latRange;
    double minLng = officeLocationLng - lngRange;
    double maxLng = officeLocationLng + lngRange;

    return (latitude >= minLat && latitude <= maxLat) &&
        (longitude >= minLng && longitude <= maxLng);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Range Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Current Location: ($currentLatitude, $currentLongitude)'),
            SizedBox(height: 20),
            Text('Latitude Range: ${calculateLatitudeRange()}'),
            SizedBox(height: 20),
            Text('Longitude Range: ${calculateLongitudeRange()}'),
          ],
        ),
      ),
    );
  }
}
