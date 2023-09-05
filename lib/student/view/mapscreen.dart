import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../model/studentmodel.dart';
import '../service/helper.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  final Function(String)? onLocationSelected;

  MapScreen({this.onLocationSelected});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  static const CameraPosition _kgooglepixel = CameraPosition(
    target: LatLng(10.0158685, 76.3418586),
    zoom: 11.0,
    tilt: 0,
    bearing: 0,
  );
  String stAddress = '';
  bool isUpdate = false;
  int? studentIdForUpdate;
  late Helper dbHelper ; // Initialize the dbHelper
  List<Student> studentList = [];
  late String _studentCurrentLoc;
  // Map
  GoogleMapController? _mapController;
  Position? _currentLocation;

  final Set<Marker> _markers = {};

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.checkPermission();
      return;
    }

    final currentLocation = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    String lat = currentLocation.latitude.toString();
    String lon = currentLocation.longitude.toString();
    double latData = double.parse(lat);
    double lonData = double.parse(lon);

    List<Placemark> placemarks = await placemarkFromCoordinates(latData, lonData);

    if (mounted) {
      setState(() {
        _currentLocation = currentLocation;
        _markers.clear();
        _markers.add(
          Marker(
            markerId: const MarkerId('selected_location'),
            position: LatLng(
              currentLocation.latitude,
              currentLocation.longitude,
            ),
          ),
        );
        final placemark = placemarks.first;
        stAddress = '${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}';
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: _kgooglepixel,
              markers: _markers,
              onMapCreated: (controller) {
                setState(() {
                  _mapController = controller;
                });
              },
            ),
          ),
          FloatingActionButton.small(
            onPressed: () async {
              await _getCurrentLocation();
              Get.back(result: stAddress);
            },
            child: const Icon(Icons.my_location),
          ),

        ],
      ),
    );
  }
}
