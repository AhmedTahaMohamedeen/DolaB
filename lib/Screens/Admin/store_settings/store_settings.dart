// ignore_for_file: file_names, non_constant_identifier_names, must_be_immutable

import 'dart:io';

import 'package:adminappp/Screens/Admin/store_settings/store_settings_helper.dart';
import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/MyIndicator.dart';
import 'package:adminappp/constants/My_Flush.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/deviceInfo.dart';
import 'package:adminappp/providers/fireProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../../../constants/Categories.dart';
import '../admin_store_profile/StoreProfile.dart';
import 'editLocation.dart';
import 'editStorePhoto.dart';
class StoreSettings extends StatefulWidget {
  static const  route='/StoreSettings';
  const StoreSettings({Key? key}) : super(key: key);

  @override
  _StoreSettingsState createState() => _StoreSettingsState();
}

class _StoreSettingsState extends State<StoreSettings> {
  GlobalKey<FormState>myKey=GlobalKey<FormState>();











  File? imageFile;
  XFile? picked;





  Admin? admin;
  getAdminInfo()async{
    var myId= Provider.of<FireProvider>(context,listen: false).myId;
    var  admin1 =await Admin().getAdminData(myId!);
    setState(() {
      admin=admin1;
    });

  }





  TextEditingController myController=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAdminInfo();
  }

  @override
  Widget build(BuildContext context) {

    if(admin==null){
      return Scaffold(
        appBar: AppBar(title: myShimmer(color: Theme.of(context).primaryColor),centerTitle: true),
        body: Center(child: myShimmer(color: Theme.of(context).primaryColor),),);}

    else{

      return InfoWidget(
        builder: (context,deviceInfo) {
          double? screenHeight=deviceInfo.screenHeight!;
          double? screenWidth=deviceInfo.screenWidth;
          print(screenHeight);
          if(deviceInfo.orientation==Orientation.landscape){
            screenWidth=deviceInfo.screenHeight;
            screenHeight=deviceInfo.screenWidth;
          }
          return Scaffold(

            appBar: AppBar(

              title:  Text('تعديل المتجر',),

              elevation: 1  ,
              centerTitle: true,


            ),



            body:  Stack(
                children:
                [


                 SingleChildScrollView(
                   
                   child: Padding(
                     padding: const EdgeInsets.only(right: 12.0),
                     child: Column(

                       children: [
                         const SizedBox(height: 10,),

                         const SizedBox(height: 10,),

                         ChangeAdminName(admin: admin!,height:screenHeight!),

                         Divider(color: Theme.of(context).primaryColor,height: .5,thickness: .5,indent: 72,endIndent: 60),





                         ChangeAdminPhone(admin: admin!,height:screenHeight),

                         Divider(color: Theme.of(context).primaryColor,height: .5,thickness: .5,indent: 72,endIndent: 60),
                         ChangeAdminDepartment(admin: admin!,height:screenHeight,),
                         Divider(color: Theme.of(context).primaryColor,height: .5,thickness: .5,indent: 72,endIndent: 60),









                         ChangeAdminTargetAge(admin: admin!,height:screenHeight,),

                         Divider(color: Theme.of(context).primaryColor,height: .5,thickness: .5,indent: 72,endIndent: 60),

                         Padding(
                           padding:  EdgeInsets.symmetric(horizontal: screenHeight*.01,vertical:screenHeight*.01),
                           child: Container(

                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.end,
                               children: [

                                 Text(' ${admin!.city!}  ',style:TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w900), ),
                                 Text('المدينه :',style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: screenHeight*.018), textDirection: TextDirection.rtl),
                               ],
                             ),
                           ),
                         ),//city
                         const SizedBox(height: 10,),
                         _buttonItem(
                             onTap: (){Navigator.pushNamed(context, EditStorePhoto.route);},
                             screenHeight: screenHeight,
                             child:  Text('تغيير صوره المتجر',style: TextStyle(fontSize: screenHeight*.016,color: Theme.of(context).primaryColor,fontWeight: FontWeight.w700),textAlign: TextAlign.center,)


                         ),

                         _buttonItem(
                             onTap: (){Navigator.pushNamed(context, EditStoreCover.route);},
                             screenHeight: screenHeight,
                             child:  Text('تغيير صوره الغلاف',style: TextStyle(fontSize: screenHeight*.016,color: Theme.of(context).primaryColor,fontWeight: FontWeight.w700),textAlign: TextAlign.center,)


                         ),
                         _buttonItem(
                             onTap: ()async{
                               await   _locationPress(context);
                             },
                             screenHeight: screenHeight,
                             child: Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children:[
                                   Text('تغيير الموقع',style: TextStyle(color: Theme.of(context).primaryColor,fontSize:  screenHeight*.016,fontWeight: FontWeight.w700),),
                                   Icon(Icons.add_location_alt_rounded,color: Theme.of(context).primaryColor,size:  screenHeight*.02,)
                                 ]

                             )


                         ),





                       ],
                     ),
                   ),
                 )





                ]),


          );
        }
      );
    }



  }



_buttonItem({required double screenHeight, required Widget child,required VoidCallback onTap}){
    return  MaterialButton(
      onPressed: onTap,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,



      child: SizedBox(
        width: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: UnconstrainedBox(child: child),
        ),
      ),
    );
}

  _locationPress(BuildContext context)async{
    MyFlush().showFlush(context: context, text: 'loading');
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
   // LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        Navigator.pop(context);
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        Navigator.pop(context);
        return;
      }
    }




  //  Navigator.pop(context);

    Navigator.push(context,MaterialPageRoute(builder:(context) =>  EditLocation(admin: admin!,)) );

  }





}




