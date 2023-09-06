import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserCurrentLocationScreen extends StatefulWidget {
  const GetUserCurrentLocationScreen({Key? key}) : super(key: key);

  @override
  State<GetUserCurrentLocationScreen> createState() =>
      _GetUserCurrentLocationScreenState();
}

class _GetUserCurrentLocationScreenState
    extends State<GetUserCurrentLocationScreen> {
  Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(31.4278538, 73.0426166), zoom: 16);

  final List<Marker> _markers = <Marker>[
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(31.4278538, 73.0426166),
        infoWindow: InfoWindow(title: 'My current location ')),
  ];

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print(error.toString());
    });

    return Geolocator.getCurrentPosition();
  }

  loadData(){
    getUserCurrentLocation().then((value) async {
      print('My current location');
      print(
          value.latitude.toString() + " " + value.longitude.toString());

      _markers.add(Marker(
          markerId: MarkerId('1'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(title: "My current position ")));

      CameraPosition cameraPosition = CameraPosition(
        zoom: 16,
        target: LatLng(value.latitude, value.longitude),
      );

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          initialCameraPosition: _kGooglePlex,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_on),
          onPressed: () async {
            loadData();
          }),
    );
  }
}
