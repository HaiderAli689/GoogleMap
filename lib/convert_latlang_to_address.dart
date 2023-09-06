import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLatLangToAddressScreen extends StatefulWidget {
  const ConvertLatLangToAddressScreen({Key? key}) : super(key: key);

  @override
  State<ConvertLatLangToAddressScreen> createState() =>
      _ConvertLatLangToAddressScreenState();
}

class _ConvertLatLangToAddressScreenState
    extends State<ConvertLatLangToAddressScreen> {
  String stAddress = '', stAdd = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            stAddress,
          ),
          Text(
            stAdd,
          ),
          GestureDetector(
            onTap: () async {
              // final coordinates = new Coordinates(31.4261, 73.0479);
              List<Location> locations =
                  await locationFromAddress("Gronausestraat 710, Enschede");

              List<Placemark> placemarks =
                  await placemarkFromCoordinates(52.2165157, 6.9437819);

              setState(() {
                stAddress = locations.last.longitude.toString() +
                    "  " +
                    locations.last.latitude.toString();

                stAdd = placemarks.reversed.last.country.toString() + " " +placemarks.reversed.last.locality.toString();
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(color: Colors.green),
                child: Center(child: Text("Convert")),
              ),
            ),
          )
        ],
      ),
    );
  }
}
