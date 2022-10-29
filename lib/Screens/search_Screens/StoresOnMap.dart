import 'dart:async';
import 'dart:math';

import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/MyIndicator.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class StoresOnMap extends StatefulWidget {
  static const route='/StoresOnMap';
  const StoresOnMap({Key? key}) : super(key: key);

  @override
  _StoresOnMapState createState() => _StoresOnMapState();
}

class _StoresOnMapState extends State<StoresOnMap> {
  Completer<GoogleMapController> _controller = Completer();
  List<Admin>? admins ;
  getAllAdmins()async{
    List<Admin>admins1=await Admin().getAllAdmins();
    setState(() {admins=admins1;});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllAdmins();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex:7,
              child: Container(

                child:Stack(
                  children: [
                    admins==null?myShimmer(color: Theme.of(context).primaryColor)
                    :
                    MyStoresOnMap(admins: admins!,),


                  ],
                ),
              ),),


          ],
        ),
      ),
    );
  }



}

class MyStoresOnMap extends StatefulWidget {

  final List<Admin>admins;
  const MyStoresOnMap({Key? key, required this.admins}) : super(key: key);

  @override
  _MyStoresOnMapState createState() => _MyStoresOnMapState();
}

class _MyStoresOnMapState extends State<MyStoresOnMap> {
  Completer<GoogleMapController> _controller = Completer();


  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.terrain,
      initialCameraPosition: CameraPosition(
        target: LatLng(30.58767926406506,31.49797774851322),
        zoom: 12.5,),
      onMapCreated: (GoogleMapController controller) {_controller.complete(controller);},

      markers: widget.admins.map((e) => Marker(
          markerId: MarkerId('${Random().nextInt(100000).toString()}'),
          position: LatLng(e.lat!,e.long!),
          infoWindow: InfoWindow(
            title: e.name,
            snippet: e.storeType,



          ),
        visible: true,







      )).toSet(),
      myLocationEnabled: true,







     // trafficEnabled: true,


    );
  }
}

