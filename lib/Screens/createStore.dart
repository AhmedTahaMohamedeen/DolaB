
// ignore_for_file: file_names, import_of_legacy_library_into_null_safe, avoid_debugPrint

import 'dart:async';
import 'dart:math';

import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/Categories.dart';
import 'package:adminappp/constants/MyIndicator.dart';
import 'package:adminappp/constants/My_Flush.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/providers/authProvider.dart';
import 'package:adminappp/providers/fireProvider.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import 'home/HomeScreen.dart';
class CreateStore extends StatefulWidget {
  static const String route='/CreateStore';

  const CreateStore({Key? key}) : super(key: key);

  @override
  _CreateStoreState createState() => _CreateStoreState();
}

class _CreateStoreState extends State<CreateStore> {

  GlobalKey<FormState>myKey=GlobalKey<FormState>();
  String name='no';
   String phone='no';
   String photoUrl='';
  // String governorate=AllCategories().governorates[0];
   String city='الزقازيق';
  String department='';

   String storeSex=AllCategories().sexCategory[0];


  String storeType=AllCategories().typeCategory[0];

   int targetAgeFrom=15;
   int targetAgeTo=55;



int indexOfCity=0;


  File? imageFile;
  XFile? picked;


  File? imageFileCover;
  XFile? pickedCover;

  Admin admin=Admin();


  TextEditingController myController=TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

appBar: AppBar(),
      body:  Stack(
            children:
            [

              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,

              ),



              Form(
                key: myKey,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SingleChildScrollView(
                    child: Column(
                    children: [

                    //  SizedBox(height: MediaQuery.of(context).size.height*.025,),
                      Container(
                        height: 275,
                        child: Stack(
                          children: [
                            Container(
                              height: 275,
                              width: MediaQuery.of(context).size.width,),

                           testCover(),


                            Positioned(bottom: 0, right: 0, left: 0,
                                      child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                                        SizedBox(),
                                                        testPhoto(),
                                                        SizedBox(),
                                            ],)),//photo

                           selectCover(),

                            selectPhoto(),

                          ],
                        ),
                      ),//image
                      SizedBox(height: MediaQuery.of(context).size.height*.05,),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Column(
                         children: [
                           myCreateAdminTextField(label: 'اسم المتجر', icon: Icon(Icons.person,color: Theme.of(context).primaryColor,size: 20,),input: TextInputType.text,
                               sFuntion: (String? s){setState(() {name=s!;});return null;},
                               vFuntion: (String? v){if (v!.isEmpty){return'enter ur name';}return null;}),
                           SizedBox(height: MediaQuery.of(context).size.height*.012,),
                           myCreateAdminTextField(label: 'الموبايل', icon: Icon(Icons.phone,color: Theme.of(context).primaryColor,size: 20,),
                               input: TextInputType.phone,
                               sFuntion: (String? s){setState(() {phone=s!;});return null;},
                               vFuntion: (String? v){if (v!.isEmpty){return'ادخل رقم الموبايل';}return null;}),






                           SizedBox(height: MediaQuery.of(context).size.height*.012,),
                           storeCity(),//المدينه


                           SizedBox(height: MediaQuery.of(context).size.height*.012,),
                                               myCreateAdminTextField(label: 'اسم المنطقه', icon: Icon(Icons.person,color: Theme.of(context).primaryColor,size: 20,),input: TextInputType.text,
                                                   sFuntion: (String? s){setState(() {department=s!;});return null;},
                                                   vFuntion: (String? v){if (v!.isEmpty){return'enter ur name';}return null;}),
                           SizedBox(height: MediaQuery.of(context).size.height*.012,),
                           location(),


                          storeLatLng.longitude==0? Row(
                             mainAxisAlignment: MainAxisAlignment.end,
                             children: [
                               Icon(Icons.close,color: Colors.red,),
                               Text('لم يتم تحديد الموقع ',style: TextStyle(color: Colors.red),),

                             ],
                           )
                          :
                           Row(
                             mainAxisAlignment: MainAxisAlignment.end,
                             children: [
                               Icon(Icons.file_download_done,color: Colors.green,),
                               Text('تم تحديد الموقع ',style: TextStyle(color: Colors.green),),

                             ],
                           ),


                           SizedBox(height: MediaQuery.of(context).size.height*.075,),
                           sex(),//الفئه
                           SizedBox(height: MediaQuery.of(context).size.height*.05,),
                           serviceType(),//نوع الخدمه
                           SizedBox(height: MediaQuery.of(context).size.height*.05,),
                           targetAge(),//

                         ],
                       ),
                     ),
                      SizedBox(height: MediaQuery.of(context).size.height*.05,),
                     doneButton(),
                      SizedBox(height: MediaQuery.of(context).size.height*.1,),





                    ],
                  ),
                ),
              ),





    ),
  ])




    );
  }


Widget storeCity()  {
    return Container(
      decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(5),
         // color: Colors.white.withOpacity(.1),
          border: Border.all(color: Theme.of(context).primaryColorDark,width: .2)
      ),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween ,
        children: [

          DropdownButton(items: AllCategories().LastCities.map((e) =>
              DropdownMenuItem(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(e,),
              ), value: e,)).toList(),
            onChanged: (String? v){

              setState(() {


                city=v!;

              });
            },
            value:city ,

            style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize:18 ),
            dropdownColor: Theme.of(context).primaryColorLight,



          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('المدينه',style: TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize:18 ),),
          ),
        ],
      ),
    );
}


  Widget testPhoto(){
    if (imageFile==null){
      return Container(
        height: 100,width: 100,
        decoration:  BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white,width: 1,),

          //  image: DecorationImage(image: AssetImage('assets/images/c.jpg'), fit: BoxFit. fill)
        ),
      );}
    else {return Container(
      height: 100,width: 100,
      decoration: BoxDecoration(
         // color: Colors.yellow,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white,width: 1,),
          image: DecorationImage(
              image: FileImage(imageFile!,),
              fit: BoxFit. fill
          )
      ),
    );}
  }

  Widget testCover(){
    if (imageFileCover==null){
      return Container(
        height: 220,width: MediaQuery.of(context).size.width,
        decoration:  BoxDecoration(
          color: Theme.of(context).primaryColorLight.withOpacity(.5),
         // shape: BoxShape.circle,
          //  image: DecorationImage(image: AssetImage('assets/images/c.jpg'), fit: BoxFit. fill)
        ),
      );}
    else {return Container(
      height: 220,width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.yellow,
        //  shape: BoxShape.circle,
          image: DecorationImage(
              image: FileImage(imageFileCover!,),
              fit: BoxFit. fill
          )
      ),
    );}
  }




  Widget targetAge(){
    return  Container(
      height: 100,
      decoration: BoxDecoration(
         // color: Colors.white.withOpacity(.1),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: backColor2,width: .2)),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15,left: 10),
                    child: DropdownButton(
                      items: targetAges.map((e) =>
                          DropdownMenuItem(child: Text(e.toString()), value: e,)).toList(),
                      onChanged: (v){setState(() {targetAgeFrom=int.parse(v.toString());});},
                      value:targetAgeFrom ,
                      style:TextStyle(color:  Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize:18 ),
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      iconEnabledColor:  Theme.of(context).primaryColorDark,



                    ),
                  ),

                  Text('من',style: TextStyle(color:  Theme.of(context).primaryColorDark),)
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15,left: 10),
                    child: DropdownButton(
                      items: targetAges.map((e) =>
                          DropdownMenuItem(child: Text(e.toString()), value: e,)).toList(),
                      onChanged: (v){setState(() {targetAgeTo=int.parse(v.toString());});},
                      value:targetAgeTo ,
                      style:TextStyle(color:  Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize:18 ),
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      iconEnabledColor:  Theme.of(context).primaryColorDark,



                    ),
                  ),
                  Text('الى',style: TextStyle(color:  Theme.of(context).primaryColorDark))
                ],
              ),



            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('السن المستهدف',style: TextStyle(color: Theme.of(context).primaryColorDark,fontSize: 16,fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  Widget serviceType(){
    return  Container(
      height: 100,
      decoration: BoxDecoration(
         // color: Colors.white.withOpacity(.1),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: backColor2,width: .2)),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [

              Row(
                children: [
                  Radio(value: AllCategories().typeCategory[0].toString(),groupValue: storeType,onChanged: (s){setState(() {storeType=AllCategories().typeCategory[0];});},

                  ),
                  Text(clothes,style: TextStyle(color:  Theme.of(context).primaryColorDark))
                ],
              ),
              Row(
                children: [
                  Radio(value: AllCategories().typeCategory[1].toString(),
                      groupValue: storeType,onChanged: (s){setState(() {storeType=AllCategories().typeCategory[1];});}

                  ),
                  Text(shoes,style: TextStyle(color:  Theme.of(context).primaryColorDark),)
                ],
              ),


            ],
          ),
          Text('نوع الخدمه',style: TextStyle(color: Theme.of(context).primaryColorDark,fontSize: 16,fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  Widget doneButton(){
    return  Builder(
        builder: (context) {
          return InkWell(
              onTap: ()async{

                FireProvider fireProvider=Provider.of<FireProvider>(context,listen: false);
                if(targetAgeFrom>=targetAgeTo){MyFlush().showFlush(context: context, text: 'الحد الاعلى يجب ان يكبر الحد الادنى');return;}
                if(storeLatLng.longitude==0){MyFlush().showFlush(context: context, text: 'لم يتم تحديد موقع المتجر');return;}
                else if(pickedCover==null){MyFlush().showFlush(context: context, text: 'اختر صوره الغلاف من فضلك');}
                else  if (picked==null){MyFlush().showFlush(context: context, text: 'اختر صوره من فضلك');  return;}
               else if(myKey.currentState!.validate()){
                  MyIndicator().loading(context);
                  myKey.currentState!.save();
                  debugPrint ('save done');

                  if(! await fireProvider.uploadImageCrop(imageFileCrop:  imageFile!,pickedCrop:  picked!)){   Navigator.pop(context); debugPrint('error');return;}
                  else if(! await fireProvider.uploadImageCropCover(imageFileCropCover:  imageFileCover!,pickedCropCover:  pickedCover!)){   Navigator.pop(context); debugPrint('error');return;}
                  else{
                    debugPrint('name=$name');
                    debugPrint('phone=$phone');
                    var ran=Random().nextInt(1000000);

                    setState(() {


                      admin=Admin(
                          name: name,
                          phone: phone,
                          photoUrl:  fireProvider.imageUrlCrop,photoLoc:fireProvider.photoLocCrop,
                          photoUrlCover:  fireProvider.imageUrlCropCover,photoLocCover:fireProvider.photoLocCropCover,
                          adminId: fireProvider.myId,
                          adminId2: '${fireProvider.myId}$ran',
                          storeType:  storeType,
                          storeSex:  storeSex,
                          targetAgeFrom: targetAgeFrom,
                          targetAgeTo: targetAgeTo,
                          city: city,
                          department: department,
                         // governorate: governorate,
                          followers: 0,

                          views: 0,
                          lat: storeLatLng.latitude,
                          long: storeLatLng.longitude,


                      );
                    });
                    await Admin().addAdmin(admin);
                    Navigator.pushNamedAndRemoveUntil(context, Home.route, (route) => false);
                  }



                }










              },
              child: Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  color:  Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white,width: .3),
                  boxShadow: [BoxShadow(color: Colors.black,blurRadius: 1)]

                ),
                child: const Center(child: Text('إنشاء المتجر',style: TextStyle(color: Colors.white),)),


              )
          );
        }
    );
  }


  Widget sex(){
    return  Container(
      height: 150,
      decoration: BoxDecoration(
         // color: Colors.white.withOpacity(.1),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Theme.of(context).primaryColorDark,width: .2)),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Radio(value:men,groupValue: storeSex,onChanged: (s){setState(() {storeSex=men;});},
                   // activeColor:  Theme.of(context).primaryColorLight,

                    ),
                  Text(men,style: TextStyle(color:  Theme.of(context).primaryColorDark),
                  )
                ],
              ),
              Row(
                children: [
                  Radio(value: women,groupValue: storeSex,onChanged: (s){setState(() {storeSex=women;});},
   // activeColor:  Theme.of(context).primaryColorLight,

                  ),
                  Text(women,style: TextStyle(color:  Theme.of(context).primaryColorDark))
                ],
              ),
              Row(
                children: [
                  Radio(value:kids,groupValue: storeSex,onChanged: (s){setState(() {storeSex=kids;});},
                      //activeColor: Theme.of(context).primaryColorLight,

                  ),
                  Text(kids,style: TextStyle(color:  Theme.of(context).primaryColorDark))
                ],
              ),


            ],
          ),
          Text('الفئه',style: TextStyle(color:  Theme.of(context).primaryColorDark,fontSize: 16,fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  Widget selectPhoto(){
    return  Positioned(
      bottom: 0,
      right: 0,
      child:  InkWell(
        onTap: ()async{
          var myCroppedImage= await Provider.of<FireProvider>(context,listen: false).addImageAndCrop();
          setState(() {
            imageFile=myCroppedImage;
            picked=Provider.of<FireProvider>(context,listen: false).pickedCrop;


          });
        },

        child: Container(
            child:
            Row(
              children: [
                Image(image: AssetImage('assets/images/selectPhoto.png'),width: 12,height: 12,color: Theme.of(context).primaryColorDark),
                Text('تحميل صوره ',style: TextStyle(color: Theme.of(context).primaryColorDark,fontSize: 12),),

              ],
            )),




      ),
    );
  }

  Widget selectCover(){
    return   Positioned(
      bottom: 50,left: 0,
      child: InkWell(
        onTap:  ()async{
          var myCroppedImageCover= await Provider.of<FireProvider>(context,listen: false).addImageAndCropCover();
          setState(() {
            imageFileCover=myCroppedImageCover;
            pickedCover=Provider.of<FireProvider>(context,listen: false).pickedCropCover;


          });

        },
        child: Container(
          color: Theme.of(context).cardColor,
          width: 100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Image(image: AssetImage('assets/images/cover.png'),width: 12,height: 12,color: Theme.of(context).primaryColorDark),
                Text(' تحميل غلاف ',style: TextStyle(color: Theme.of(context).primaryColorDark),),
              ],
            ),
          ),
        ),




      ),
    );
  }



 // LatLng myLatLng= LatLng(30.5925904, 31.5227452);
  LatLng storeLatLng=LatLng(0, 0);



  Widget location(){
    return InkWell(
      onTap: ()async{
        locationPress(context);

      },

      child: Container(
        height: 50,width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.black,blurRadius: 1)],

        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Padding(
              padding: const EdgeInsets.only(right:  12.0),
              child: Image(image: AssetImage('assets/images/location.png'),width: 20,height: 20,color: Theme.of(context).cardColor),
            ),
            Text('إضافه موقعك على الخريطه',style: TextStyle(color: Theme.of(context).cardColor),)
          ],
        ),

      ),
    );
  }

  locationPress(BuildContext context)async{
    MyFlush().showFlush(context: context, text: 'loading');
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

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

    _locationData = await location.getLocation();
    debugPrint(_locationData.toString());
    LatLng latLng1=LatLng(_locationData.latitude!,_locationData.longitude!);

   // Navigator.pop(context);

    //LatLng backLatLng= await Navigator.push(context,MaterialPageRoute(builder:(context) =>  CreatLocation(latLng:latLng1)) );
    await getStoreLocation(await Navigator.push(context,MaterialPageRoute(builder:(context) =>  CreateStoreLocation(latLng:latLng1))));


   debugPrint(storeLatLng.longitude.toString());

  }

  getStoreLocation(backLatLng)async{
    setState(() {
      storeLatLng=backLatLng;
    });
  }

}











// ignore: must_be_immutable
class myCreateAdminTextField extends StatelessWidget {

  double borderWidth = 1;
  Color borderColor = Colors.white.withOpacity(.2);
  Color fillColor = Colors.black.withOpacity(0);
  double borderRadus = 5;

  TextStyle inputTextStyle=TextStyle(color: Colors.white, fontSize:16);
  TextStyle labelTextStyle=TextStyle(color: Colors.white, fontSize:16);




  TextEditingController? myController ;
  final String label;
  final Icon icon;
  final bool obsecure;
  final TextInputType input;


  final String? Function(String?) vFuntion;
  final  String? Function(String?) sFuntion;

  //Function ontapFunction;

  myCreateAdminTextField({Key? key,
    required this.label,
    this.obsecure = false,
    required this.icon,
    required this.vFuntion,
    required this.sFuntion,
    this.myController,
    required this.input


  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color borderColor = Theme.of(context).primaryColorDark;
    return TextFormField(
      style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize:16),
      decoration: InputDecoration(
          fillColor:fillColor,



          filled: true,
          isCollapsed: true,
          contentPadding: const EdgeInsets.all(20),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: label,
          labelStyle: TextStyle(color: Theme.of(context).primaryColorDark, fontSize:16),
          prefixIcon: icon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadus),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadus),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadus),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadus),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadus),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          )),

      obscureText: obsecure,
      textInputAction: TextInputAction.done,
      keyboardType: input,
      enabled: true,

      validator:vFuntion ,
      onSaved:sFuntion ,
      // onTap: ontapFunction,
      controller: myController,
    );
  }

/*
  validator:( String v){
  if(v.isEmpty){return 'wrong';}
  return  null;
  }
   */
/*
 onPressed:(){if (!formKey.currentState.validate()) {return;}
                    formKey.currentState.save();
                    }
 */
}












class CreateStoreLocation extends StatefulWidget {
  final LatLng latLng;
  const CreateStoreLocation({Key? key, required this.latLng}) : super(key: key);

  @override
  _CreateStoreLocationState createState() => _CreateStoreLocationState();
}

class _CreateStoreLocationState extends State<CreateStoreLocation> {
  Completer<GoogleMapController> _controller = Completer();

  LatLng myLatLng= LatLng(0, 0);


  initialLatLng(){
    setState(() {
      myLatLng=widget.latLng;
    });
  }
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(backgroundColor:  Theme.of(context).appBarTheme.backgroundColor,elevation: 0,),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex:7,
              child: Container(

                child:Stack(
                  children: [
                    myMap(),
                    myNotice()

                  ],
                ),
              ),),

            Expanded(
              flex: 1,
              child: Row(
                children: [
                  saveButton(),
                  closeButton()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget myMap(){
    return GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: CameraPosition(
        target: widget.latLng,
        zoom: 18.4746,),
      onMapCreated: (GoogleMapController controller) {_controller.complete(controller);},
      onTap: (L){setState(() {myLatLng=L;});},
      markers: [Marker(markerId: MarkerId('m'), position: myLatLng,)].toSet(),

    );
  }

  Widget myNotice(){
    return  Positioned(
      top: 20,left: 20,
      child: Container(
        height: 80,width: MediaQuery.of(context).size.width*.8,
        decoration: BoxDecoration(
            color:Theme.of(context).primaryColorDark.withOpacity(.5),
            boxShadow: [BoxShadow(color: Colors.white.withOpacity(0.3),blurRadius: 1)],
            border: Border.all(color: Colors.white,width: 1),

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
                Text('ملاحظه',style: TextStyle(color: Colors.white)),
                Icon(Icons.info,color: Colors.white,size: 20,)

              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                children: [
                  Text('  قم بتحديد موقع متجرك ',style: TextStyle(color: Colors.white,fontSize: 12),),
                  Text('  بواسطه النقر على  موقع المتجر على الخريطه',style: TextStyle(color: Colors.white,fontSize: 12),),
                ],
              ),
            )
          ],
        ),

      ),
    );
  }

  Widget saveButton(){
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: (){
            if(myLatLng.longitude!=0){Navigator.pop(context,myLatLng);}
            else{
              MyFlush().showFlush(context: context, text: 'قم بالنقر على موقع متجرك');
            }


          },
          child: Container(
              alignment: Alignment.center,
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),),
              child: Text('حفظ',style: TextStyle(color: Colors.white),)
          ),
        ),
      ),
    );
  }
  Widget closeButton(){
    return  Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: (){
            Navigator.pop(context,myLatLng);
          },
          child: Container(
              alignment: Alignment.center,
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                color:Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),),
              child: Text('إغلاق',style: TextStyle(color: Colors.white),)
          ),
        ),
      ),
    );
  }
}
