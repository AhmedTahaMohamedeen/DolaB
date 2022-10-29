import 'dart:io';

import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/MyIndicator.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/deviceInfo.dart';
import 'package:adminappp/providers/authProvider.dart';
import 'package:adminappp/providers/fireProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../admin_store_profile/StoreProfile.dart';
class EditStorePhoto extends StatefulWidget {
  static const  route='/EditStorePhoto';
  const EditStorePhoto({Key? key}) : super(key: key);

  @override
  _EditStorePhotoState createState() => _EditStorePhotoState();
}

class _EditStorePhotoState extends State<EditStorePhoto> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAdminInfo();
  }
  @override
  Widget build(BuildContext context) {

    if(admin==null){return Scaffold(body: Center(child: myShimmer(color: Theme.of(context).primaryColor)),);}
    else{ return InfoWidget(

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
                title: Text('تعديل الصوره ',style: TextStyle(color: Theme.of(context).appBarTheme.titleTextStyle!.color)),
                centerTitle: false,
              elevation: 0,

            ),

            body: Center(
              child: ListView(

                children: [
                  _fileTest(height:screenHeight! ),
                  SizedBox(
                    height: screenHeight*.03,
                  ),
                  _chooseImage(height:screenHeight ),
                  SizedBox(
                    height: screenHeight*.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _saveButton(height:screenHeight),
                      _closeButton(height:screenHeight)
                    ],
                  )




                ],
              ),
            ),
          );
        }
    );}

  }

  Widget _fileTest({required double height}){
    return UnconstrainedBox(
      constrainedAxis: Axis.vertical,
      child: Container(
        height: height*.3,width: height*.3,
        decoration: imageFile==null?
        BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: CachedNetworkImageProvider(admin!.photoUrl!,), fit: BoxFit. fill))
            : BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: FileImage(imageFile!), fit: BoxFit. fill)),
      ),
    );
  }
  Widget _chooseImage({required double height}){
    return  UnconstrainedBox(
      constrainedAxis: Axis.vertical,
      child: EbottonI(
        onpressed:  ()async{
          var myCroppedImage= await Provider.of<FireProvider>(context,listen: false).addImageAndCrop();
          setState(() {
            imageFile=myCroppedImage;
            picked=Provider.of<FireProvider>(context,listen: false).pickedCrop;

          });

        },
        child: Text('إختر صوره',style: TextStyle(color: Colors.white,fontSize: height*.018),),
        borderRadius: 10,
        backgroundcolor: color_b.withOpacity(.8),
        borderColor: Colors.white.withOpacity(0),
        padding: 15,
        elevation: 3,
        shadowcolor: Theme.of(context).canvasColor,
        icon: Icon(Icons.photo,color: Colors.white,size: height*.022),



      ),
    );
  }
  Widget _saveButton({required double height}){
    return  MySaveButton(onpressed:()async{
      var fire=Provider.of<FireProvider>(context,listen: false);


      if (picked==null){ debugPrint('error image');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('اختر صوره  ')));   return;}
      else{
        MyIndicator().loading(context);

        if(! await fire.uploadImageCrop(imageFileCrop:  imageFile!,pickedCrop:  picked!))
        {
          Navigator.pop(context);
          debugPrint('error');return;}

        else{
          fire.removeImageFromStorage(photoLoc: admin!.photoLoc!);

          await Admin().editStoreInfo(key:adminPhotoUrl,adminId: admin!.adminId!,newValue:fire. imageUrlCrop);
          await Admin().editStoreInfo(key: adminPhotoLoc,adminId: admin!.adminId!,newValue: fire.photoLocCrop!);
          Navigator.pushNamedAndRemoveUntil(context, StoreProfileScreen.route, (route) => false);
        }

      }
    });
  }
  Widget _closeButton({required double height}){
    return  MyCloseButton(onpressed: (){Navigator.pop(context);});
  }
}


class EditStoreCover extends StatefulWidget {
  static const  route='/EditStoreCover';
  const EditStoreCover({Key? key}) : super(key: key);

  @override
  _EditStoreCoverState createState() => _EditStoreCoverState();
}

class _EditStoreCoverState extends State<EditStoreCover> {
  File? imageFileCover;
  XFile? pickedCover;
  Admin? admin;
  getAdminInfo()async{
    var myId= Provider.of<FireProvider>(context,listen: false).myId;
    var  admin1 =await Admin().getAdminData(myId!);
    setState(() {
      admin=admin1;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAdminInfo();
  }
  @override
  Widget build(BuildContext context) {
    if(admin==null){return Scaffold(body: myShimmer(color: Theme.of(context).primaryColor),);}

    else{return



        InfoWidget(
          builder: (context,deviceInfo) {
            double? screenHeight=deviceInfo.screenHeight;
            double? screenWidth=deviceInfo.screenWidth;
            if(deviceInfo.orientation==Orientation.landscape){
              screenWidth=deviceInfo.screenHeight;
              screenHeight=deviceInfo.screenWidth;
            }
            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,

                appBar: AppBar(title: Text('تغيير صوره الغلاف',style: TextStyle(color: Theme.of(context).appBarTheme.titleTextStyle!.color)),
                  backgroundColor:Theme.of(context).appBarTheme.backgroundColor ,
                  centerTitle: false,
                  elevation: 0,


                ),

                body: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView(

                    children: [

                      _fileTest(height: screenHeight!),

                  SizedBox(height: screenHeight*.05),
                  _chooseImage(height: screenHeight),
                  SizedBox(height: screenHeight*.05),


                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     _saveButton(height:screenHeight ),
                     _closeButton( height:screenHeight)
                   ],
                 )
              ],
            ),
                ),
    );
          }
        );}


  }
  Widget _fileTest({required double height}){
     return Container(
      height: height*.2,
      width: MediaQuery.of(context).size.width,
      decoration: imageFileCover==null?
      BoxDecoration(image: DecorationImage(image: CachedNetworkImageProvider(admin!.photoUrlCover!,), fit: BoxFit. cover))
          :BoxDecoration( image: DecorationImage(image: FileImage(imageFileCover!), fit: BoxFit. cover
      )
      )
      ,
    );
  }
  Widget _chooseImage({required double height}){
    return  UnconstrainedBox(
      constrainedAxis: Axis.vertical,
      child: EbottonI(
        onpressed: ()async{
          var myCroppedImageCover= await Provider.of<FireProvider>(context,listen: false).addImageAndCropCover();
          setState(() {
            imageFileCover=myCroppedImageCover;
            pickedCover=Provider.of<FireProvider>(context,listen: false).pickedCropCover;

          });

        },
        child: Text('إختر صوره',style: TextStyle(color: Colors.white,fontSize: height*.018),),
        borderRadius: 10,
        backgroundcolor: color_b.withOpacity(.8),
        borderColor: Colors.white.withOpacity(0),
        padding: 15,
        elevation: 3,
        shadowcolor: Theme.of(context).canvasColor,
        icon: Icon(Icons.photo,color: Colors.white,size: height*.022),



      ),
    );
  }
  Widget _saveButton({required double height}){
    return  MySaveButton(onpressed: ()async{
      var fire=Provider.of<FireProvider>(context,listen: false);


      if (pickedCover==null){ debugPrint('error image');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('اختر صوره  ')));   return;}
      else{
        MyIndicator().loading(context);

        if(! await fire.uploadImageCropCover(imageFileCropCover:  imageFileCover!,pickedCropCover:  pickedCover!))
        {
          Navigator.pop(context);
          debugPrint('error');return;}

        else{
          fire.removeImageFromStorage(photoLoc: admin!.photoLocCover!);

          await Admin().editStoreInfo(key: adminPhotoUrlCover,adminId: admin!.adminId!,newValue:fire. imageUrlCropCover);
          await Admin().editStoreInfo(key: adminPhotoLocCover,adminId: admin!.adminId!,newValue: fire.photoLocCropCover!);
          Navigator.pushNamedAndRemoveUntil(context, StoreProfileScreen.route, (route) => false);
        }

      }
    });
  }
  Widget _closeButton({required double height}){
    return  MyCloseButton(onpressed: (){Navigator.pop(context);});
  }
}

