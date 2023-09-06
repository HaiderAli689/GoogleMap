

import 'package:flutter/material.dart';
import 'package:google_map/google_places_api.dart';

import 'convert_latlang_to_address.dart';
import 'get_user_location.dart';
import 'home_screen.dart';
import 'marker_info_window.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomeMarkerInfoWindow(),
    );
  }
}
