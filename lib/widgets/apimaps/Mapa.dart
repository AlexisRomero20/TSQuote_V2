import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MyAppMapa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapScreen02(),
    );
  }
}

class MapScreen02 extends StatefulWidget {
  @override
  _MapScreen02State createState() => _MapScreen02State();
}

class _MapScreen02State extends State<MapScreen02> {
  late GoogleMapController mapController;
  late String searchAdd;
  // List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: onMapCreated,
            initialCameraPosition:
            CameraPosition(target: LatLng(19.058366952059007, -98.15196529988391), zoom: 17.0),
          ),
          Positioned(
            top: 30,
            right: 15,
            left: 15,
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Address',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: 15,
                    top: 15,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: searchnavigate,
                    iconSize: 30,
                  ),
                ),
                onChanged: (val) {
                  setState(() {
                    searchAdd = val;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  searchnavigate() {
    locationFromAddress(searchAdd).then((result) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(result[0].latitude, result[0].longitude),
        zoom: 10,
      )));
    });
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

//locationFromAddress(String searchAdd) {}
}
