import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(31.4278538, 73.0426166), zoom: 16);

  List<Marker> _marker = [];
  List<Marker> _list = const [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(31.4278538, 73.0426166),
        infoWindow: InfoWindow(title: 'My position')),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(31.4285564, 73.0433760),
        infoWindow: InfoWindow(title: 'Raza Abad')),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(31.4295564, 73.0443760),
        infoWindow: InfoWindow(title: 'Street #22')),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(32.4295564, 74.0443760),
        infoWindow: InfoWindow(title: 'Street #22')),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          initialCameraPosition: _kGooglePlex,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_disabled_outlined),
          onPressed: () async {
            GoogleMapController controller = await _controller.future;
            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(32.4295564, 74.0443760), zoom: 16),
              ),
            );
          }),
    );
  }
}
