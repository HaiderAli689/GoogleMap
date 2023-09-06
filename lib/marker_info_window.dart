import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomeMarkerInfoWindow extends StatefulWidget {
  const CustomeMarkerInfoWindow({Key? key}) : super(key: key);

  @override
  State<CustomeMarkerInfoWindow> createState() =>
      _CustomeMarkerInfoWindowState();
}

class _CustomeMarkerInfoWindowState extends State<CustomeMarkerInfoWindow> {
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  final List<Marker> _markers = [];
  final List<LatLng> _latlng = [LatLng(31.4278538, 73.0426166)];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() {
    for (int i = 0; i < _latlng.length; i++) {
      _markers.add(
        Marker(
            markerId: MarkerId(i.toString()),
            icon: BitmapDescriptor.defaultMarker,
        position: _latlng[i],
        onTap: (){
              _customInfoWindowController.addInfoWindow!(
                Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, ),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Container(
                    height: 100,
                    width: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(image:
                        NetworkImage('https://wallpapercave.com/wp/wp2038281.jpg'),

                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, ),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Luxury Restarant' ,style: TextStyle(
                              color: Colors.black,
                              fontSize: 16
                            ),),
                            Text('4ml..' ,style: TextStyle(
                              color: Colors.black,
                              fontSize: 16
                            ),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Your experience of starting the journey and continuing it with excellence over the years will have to be included on the page.' ,style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12
                        ),),
                      ),
                    ],
                  ),
                ),
                _latlng[i]
              );
        }),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Marker info Window'),
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(31.4278538, 73.0426166),
            ),
            markers: Set.of(_markers),
            onTap: (position){
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position){
              _customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller){
              _customInfoWindowController.googleMapController = controller;
            },
          ),
          CustomInfoWindow(
              controller: _customInfoWindowController,
            height: 200,
            width: 300,
            offset: 35,
          ),
        ],
      ),
    );
  }
}
