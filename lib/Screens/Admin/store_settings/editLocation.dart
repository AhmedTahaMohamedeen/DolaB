import 'dart:async';

import 'package:adminappp/Screens/Admin/admin_store_profile/StoreProfile.dart';
import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/MyIndicator.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/deviceInfo.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EditLocation extends StatefulWidget {
  static const String route='/EditLocation';

  final Admin admin;
  const EditLocation({Key? key, required this.admin}) : super(key: key);

  @override
  _EditLocationState createState() => _EditLocationState();
}

class _EditLocationState extends State<EditLocation> {
  Completer<GoogleMapController> _controller = Completer();

  LatLng? newLatLng;




  initialLatLng(){
    setState(() {

      newLatLng=LatLng(widget.admin.lat!,widget.admin.long!);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialLatLng();

  }
  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context,deviceInfo) {
        double? screenHeight=deviceInfo.screenHeight;
        double? screenWidth=deviceInfo.screenWidth;
        if(deviceInfo.orientation==Orientation.landscape){
          screenWidth=deviceInfo.screenHeight;
          screenHeight=deviceInfo.screenWidth;
        }
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,

          appBar: AppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            elevation: 0,
            centerTitle: false,
           ),
          body: newLatLng==null?myShimmer(color: Theme.of(context).primaryColor):
          SafeArea(
            child: Stack(
              children: [

                Positioned(
                    bottom: 0,right: 0,left: 0,top: 0,
                    child: myMap()),
                myNotice(height: screenHeight!,width: screenWidth!),
                Positioned(bottom: 0, left: 0,right: 0,


                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      saveButton(height:screenHeight,width: screenWidth ),
                      closeButton(height:screenHeight,width: screenWidth)
                    ],
                  ),
                )

              ],
            ),
          ),
        );
      }
    );
  }



  Widget myMap(){
    return GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: CameraPosition(
        target: newLatLng!,
        zoom: 18.4746,),

      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      onTap: (L){setState(() {newLatLng=L;});},
      markers: [
        Marker(
          markerId: MarkerId('m'),
          position: newLatLng!,)
      ].toSet(),




      //liteModeEnabled: true,


    )
    ;
  }

  Widget myNotice({required double height,required double width}){
    return  Positioned(
      top: 20,left: 20,
      child: Container(
        height: height*.1,
        width:width*.6,
        decoration:  BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(.9),
            // boxShadow: [BoxShadow(color: Colors.white.withOpacity(0.3),blurRadius: 1)],
            border: Border.all(color: Theme.of(context).primaryColor,width: 1),

            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(20)
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ملاحظه',style: TextStyle(color: Theme.of(context).textTheme.titleMedium!.color,fontSize: height*.018)),
                Icon(Icons.info,color: Theme.of(context).iconTheme.color,size:  height*.03,)

              ],
            ),
            Padding(
              padding:  EdgeInsets.only(bottom: height*.01),
              child: Column(
                children: [
                  Text('  قم بتحديد موقع متجرك ',style: TextStyle(color: Theme.of(context).textTheme.titleMedium!.color,fontSize:  height*.014),),
                  Text('  بواسطه النقر على  موقع المتجر على الخريطه',style: TextStyle(color: Theme.of(context).textTheme.titleMedium!.color,fontSize:  height*.014),),
                ],
              ),
            )
          ],
        ),

      ),
    );
  }

  Widget saveButton({required double height,required double width}){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MySaveButton(onpressed: ()async{
        MyIndicator().loading(context);
 await Admin().editStoreInfo(key: adminLong,adminId: widget.admin.adminId!,newValue: newLatLng!.longitude);
        await Admin().editStoreInfo(key: adminLat,adminId: widget.admin.adminId!,newValue: newLatLng!.latitude);
        Navigator.pushNamedAndRemoveUntil(context, StoreProfileScreen.route, (route) => false);

      }),
    );
  }
  Widget closeButton({required double height,required double width}){
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: MyCloseButton(onpressed: (){
        Navigator.pop(context);
      }),
    );
  }
}
