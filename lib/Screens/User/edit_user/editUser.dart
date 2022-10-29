
import 'dart:async';

import 'package:adminappp/constants/Categories.dart';
import 'package:adminappp/constants/MyIndicator.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/userInfo.dart';
import 'package:adminappp/providers/authProvider.dart';
import 'package:adminappp/providers/fireProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../constants/deviceInfo.dart';
import 'editUserPhoto.dart';
import '../user_profile/userProfile.dart';
class EditUserInfo extends StatefulWidget {
  static const String route='/EditUserInfo';
  const EditUserInfo({Key? key}) : super(key: key);

  @override
  _EditUserInfoState createState() => _EditUserInfoState();
}

class _EditUserInfoState extends State<EditUserInfo> {


  UserInfoo? userInfo;

  GlobalKey<FormState>myKey=GlobalKey<FormState>();
  GlobalKey<FormState>myKey1=GlobalKey<FormState>();
  GlobalKey<FormState>myKey2=GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }

    var myUserInfo= Provider.of<FireProvider>(context,listen: false).myUserInfo;

    return Scaffold(

      appBar: AppBar(

        title: Text('البيانات الشخصيه'),

        elevation: 3,
        shadowColor: Theme.of(context).primaryColor,

      ),


      body:   Stack(
          children:
          [

            ListView(
              padding: EdgeInsets.symmetric(horizontal: 10),

              children: [
                const SizedBox(height: 30,),
                _profilePhoto(height: height),//photo
                const SizedBox(height: 30,),
                myName(userInfo:myUserInfo!,height:height),
                const SizedBox(height: 20,),
                myPhone(userInfo:myUserInfo,height: height),
                const SizedBox(height: 20,),
                myAge(userInfo:myUserInfo,height:height ),
                const SizedBox(height: 20,),
                mySex(userInfo:myUserInfo,height: height),
                const SizedBox(height: 20,),

                myCity(userInfo:myUserInfo,height: height),
                const SizedBox(height: 40,),
                myAddress(userInfo:myUserInfo,height: height),
                const SizedBox(height: 200,),








              ],
            ),



            MyFloating(myLoc1: myLoc.none
              , floatingColor:


              Theme.of(context).floatingActionButtonTheme.backgroundColor

              ,
            ),





          ]),









    );
  }


  getUserInfo()async{
    var myUserInfo= Provider.of<FireProvider>(context,listen: false).myUserInfo;

    setState(() {
      userInfo=myUserInfo;
    });
  }








  _profilePhoto({required double height,}){
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          editIcon(context: context,height: height,onTap: (){Navigator.pushNamed(context, EditUserPhoto.route);}),
          Container(
            height: height*.15,width: height*.15,
            decoration:  BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
                border: Border.all(color: Theme.of(context).canvasColor),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(userInfo!.photo!),
                    fit: BoxFit. fill
                )
            ),
          ),




        ],
      )

      ;
  }

  TextStyle nameStyle=TextStyle(color: backColor2,fontWeight: FontWeight.bold);
  TextStyle valueStyle=TextStyle(color: Colors.white,);











  String name='no';
  bool myNamePressed=false;
  myName({required UserInfoo userInfo,required double height}){


    if(!myNamePressed){
      return
        SizedBox(
          height: height*.06,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             editIcon( context: context,onTap: (){setState(() {myNamePressed=!myNamePressed;});}, height: height),
              Row(
                children: [
                  Text(' ${userInfo.name!}  ',
                    style:TextStyle(color:  Theme.of(context).primaryColor,fontSize: height*.018 ),
                      textDirection: TextDirection.ltr),

                  Text('الإسم : ',
                      style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: height*.018),
                      textDirection: TextDirection.rtl),
                ],
              )





            ],
          ),
        );
    }

    else{return


      Material(
        color: Theme.of(context).cardColor,
        elevation: 3,

        child: Container(

          height: height*.25,
          padding: EdgeInsets.symmetric(horizontal: height*.015),

          child: Column(
            children: [
              SizedBox(
                height: height*.06,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(' ${userInfo.name!}  ',
                        style:TextStyle(color:  Theme.of(context).primaryColor,fontSize: height*.018 ),
                        textDirection: TextDirection.ltr),

                    Text('الإسم : ',
                        style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: height*.018),
                        textDirection: TextDirection.rtl),
                  ],
                ),
              ),


              Column(
                children: [
                  Form(
                      key: myKey,
                      child: myEditUserTextField(
                        label: 'الاسم',
                        vFuntion: (v){if(v!.isEmpty){return'ادخل الاسم';}
return null;},
                        sFuntion: (s){setState(() {name=s!;});
return null;},
                        input: TextInputType.text,



                      )

                  ),



                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                     MySaveButton(onpressed: ()async{

                       if(!myKey.currentState!.validate()){return;}
                       else{
                         MyIndicator().loading(context);
                         myKey.currentState!.save();

                         if(await UserInfoo().editMyUser(myId: userInfo.uid!, key: userName,newValue: name)){
                           if( await Provider.of<FireProvider>(context,listen: false).getMyUserInfo(context: context)){
                             Navigator.pop(context);
                             Navigator.popAndPushNamed(context, EditUserInfo.route);
                           }

                         }
                         else{snack(context: context, message: 'خطأ حاول مره اخرى');Navigator.pop(context);   return;}

                       }


                     }),



                     MyCloseButton(onpressed: (){
                       setState(() {
                         myNamePressed=!myNamePressed;
                       });
                     }),
                    ],
                  )
                ],
              ),

            ],
          ),
        ),
      )
    ;}

  }


  String phone='no';
  bool myPhonePressed=false;
  myPhone({required UserInfoo userInfo,required double height}){
    if(!myPhonePressed){
      return
        SizedBox(
          height: height*.06,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              editIcon(context: context, onTap: (){setState(() {myPhonePressed=!myPhonePressed;});} , height: height),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Text(' ${userInfo.phone!}  ',
                      style:TextStyle(color:  Theme.of(context).primaryColor,fontSize: height*.018 ),
                      textDirection: TextDirection.ltr),
                  Text('رقم الهاتف : ',style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: height*.018),
                      textDirection: TextDirection.rtl),
                ],
              ),

            ],
          ),
        );
    }

    else{return


      Material(
        color: Theme.of(context).cardColor,
        elevation: 3,

        child: Container(

          height: height*.25,
          padding: EdgeInsets.symmetric(horizontal: height*.015),

          child: Column(
            children: [
              SizedBox(
                height: height*.06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Text(' ${userInfo.phone!}  ',
                        style:TextStyle(color:  Theme.of(context).primaryColor,fontSize: height*.018 ),
                        textDirection: TextDirection.ltr),
                    Text('رقم الهاتف : ',style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: height*.018),
                        textDirection: TextDirection.rtl),
                  ],
                ),
              ),


              Form(
                  key: myKey2,
                  child: myEditUserTextField(
                    label: 'رقم الهاتف',
                    vFuntion: (v){if(v!.isEmpty){return'ادخل الاسم';}
return null;},
                    sFuntion: (s){setState(() {phone=s!;});
return null;},
                    input: TextInputType.phone,



                  )

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MySaveButton(onpressed:  ()async{

                    if(!myKey2.currentState!.validate()){return;}
                    else{
                      MyIndicator().loading(context);
                      myKey2.currentState!.save();

                      if(await UserInfoo().editMyUser(myId: userInfo.uid!, key: userPhone,newValue: phone)){
                        if( await Provider.of<FireProvider>(context,listen: false).getMyUserInfo(context: context)){
                          Navigator.pop(context);
                          Navigator.popAndPushNamed(context, EditUserInfo.route);
                        }
                      }
                      else{snack(context: context, message: 'خطأ حاول مره اخرى');Navigator.pop(context);   return;}


                    }


                  }),
                  MyCloseButton(onpressed: (){
                    setState(() {
                      myPhonePressed=!myPhonePressed;
                    });
                  }),
                ],
              )

            ],
          ),
        ),
      )
    ;}

  }

  int age=0;
  bool myAgePressed=false;
  myAge({required UserInfoo userInfo,required double height}){
    if(!myAgePressed){
      return
        SizedBox(
          height: height*.06,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              editIcon(context: context,onTap: (){setState(() {myAgePressed=!myAgePressed;});}, height: height),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Text(' ${userInfo.age!}  ', style:TextStyle(color:  Theme.of(context).primaryColor,fontSize: height*.018 ),
                      textDirection: TextDirection.ltr),
                  Text('العمر : ',style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: height*.018),
                      textDirection: TextDirection.rtl),
                ],
              ),

            ],
          ),
        );
    }

    else{return


      Material(
        color: Theme.of(context).cardColor,
        elevation: 3,
        child: Container(
          color: Theme.of(context).cardColor.withOpacity(.1),
          height: height*.20,
          padding: EdgeInsets.symmetric(horizontal: height*.015),

          child: Column(
            children: [
              SizedBox(
                height: height*.06,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Text(' ${userInfo.age!}  ', style:TextStyle(color:  Theme.of(context).primaryColor,fontSize: height*.018 ),
                        textDirection: TextDirection.ltr),
                    Text('العمر : ',style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: height*.018),
                        textDirection: TextDirection.rtl),
                  ],
                ),
              ),
              Material(
                color: Theme.of(context).cardColor,
                elevation: 3,
                child: Container(
                  height: height*.06,
                  padding:  EdgeInsets.only(right: height*.03,left: height*.01),
                  child: DropdownButton(items: targetAges.map((e) => DropdownMenuItem(child: Text(e.toString()), value: e,)).toList(),
                    onChanged: (v){setState(() {age=int.parse(v.toString());});},
                    value:age ,
                    style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize:height*.02 ),
                    dropdownColor: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10),
                    iconEnabledColor: Theme.of(context).primaryColorDark,
                    elevation: 5,
                    underline:Divider(height: 1,color: Theme.of(context).cardColor,) ,



                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                 MySaveButton(onpressed: ()async{
                   MyIndicator().loading(context);
                   if(await UserInfoo().editMyUser(myId: userInfo.uid!, key: userAge,newValue: age)){
                     if( await Provider.of<FireProvider>(context,listen: false).getMyUserInfo(context: context)){
                       Navigator.pop(context);

                       Navigator.popAndPushNamed(context, EditUserInfo.route);
                     }



                   }
                   else{snack(context: context, message: 'خطأ حاول مره اخرى');Navigator.pop(context);   return;}



                 }),
                 MyCloseButton(onpressed: (){
                   setState(() {
                     myAgePressed=!myAgePressed;
                   });
                 }),
                ],
              )

            ],
          ),
        ),
      )
    ;}

  }







  String sex='none';
  bool mySexPressed=false;
  mySex({required UserInfoo userInfo,required double height}){
    // var fire= Provider.of<FireProvider>(context,listen: false);
    if(!mySexPressed){
      return
        SizedBox(
          height: height*.06,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              editIcon(context: context, onTap: (){setState(() {mySexPressed=!mySexPressed;});}, height: height),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(userInfo.sex!, style:TextStyle(color:  Theme.of(context).primaryColor,fontSize: height*.018 ),
                      textDirection: TextDirection.ltr),
                  Text('الجنس : ',style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: height*.018),
                    textDirection: TextDirection.rtl,),
                ],
              ),

            ],
          ),
        );
    }

    else{return


      Material(
        color: Theme.of(context).cardColor,
        elevation: 3,
        child: Container(

          height: height*.25,
          padding: EdgeInsets.symmetric(horizontal: height*.015),

          child: Column(
            children: [
              SizedBox(
                height: height*.06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(userInfo.sex!, style:TextStyle(color:  Theme.of(context).primaryColor,fontSize: height*.018 ),
                        textDirection: TextDirection.ltr),
                    Text('الجنس : ',style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: height*.018),
                      textDirection: TextDirection.rtl,),
                  ],
                ),
              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Column(
                    children: [
                      Row(
                        children: [
                          Radio(value: male, groupValue: sex, onChanged: (value){setState(() {sex=value.toString();});debugPrint(sex);},

                          //  activeColor: Colors.white,
                          //  fillColor: MaterialStateProperty.all(Colors.white),


                          ),
                          Text(male,style:TextStyle(color:  Theme.of(context).primaryColor,fontSize: height*.018 ),
                              textDirection: TextDirection.ltr)
                        ],
                      ),


                      Row(
                        children: [
                          Radio(value:female, groupValue: sex, onChanged: (value){ setState(() {sex=value.toString();});debugPrint(sex);},


                          ),

                          Text(female,style:TextStyle(color:  Theme.of(context). primaryColor,fontSize: height*.018 ),
                              textDirection: TextDirection.ltr)
                        ],
                      ),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child:  Text('الجنس :',style:TextStyle(color: Theme.of(context). primaryColorDark,fontWeight: FontWeight.bold,fontSize: height*.018),
                      textDirection: TextDirection.rtl,),
                  ),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MySaveButton(onpressed: ()async{
                    if(sex=='none'){snack(context: context, message: 'إختر الجنس');  return;}

                    MyIndicator().loading(context);

                    if(await UserInfoo().editMyUser(myId: userInfo.uid!, key: userSex,newValue: sex)){
                      if( await Provider.of<FireProvider>(context,listen: false).getMyUserInfo(context: context)){
                        Navigator.pop(context);

                        Navigator.popAndPushNamed(context, EditUserInfo.route);
                      }



                    }
                    else{snack(context: context, message: 'error please try again'); Navigator.pop(context);  return;}


                  }),
                 MyCloseButton(onpressed: (){
                   setState(() {
                     mySexPressed=!mySexPressed;
                   });
                 }),
                ],
              )

            ],
          ),
        ),
      )
    ;}

  }

  String city='الزقازيق';
  bool myCityPressed=false;
  myCity({required UserInfoo userInfo,required double height}){
    if(!myCityPressed){
      return
        SizedBox(
          height: height*.06,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              editIcon(context: context, onTap: (){setState(() {myCityPressed=!myCityPressed;});} , height: height),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(userInfo.city!,style:TextStyle(color:  Theme.of(context).primaryColor,fontSize: height*.018 ),
                    textDirection: TextDirection.rtl,),
                  Text('المدينه : ',style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: height*.018),
                    textDirection: TextDirection.rtl,),
                ],
              ),

            ],
          ),
        );
    }

    else{return


      Container(
        color: Theme.of(context).cardColor.withOpacity(.1),
        height: height*.2,
        padding: EdgeInsets.symmetric(horizontal: height*.015),

        child: Column(
          children: [
            SizedBox(
              height: height*.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Container(


                    height:  height*.05,
                    child:  DropdownButton(
                      borderRadius:BorderRadius.circular(10) ,
                      elevation: 3,
                      iconEnabledColor: Theme.of(context).primaryColor,
                      underline: Divider(height: 1,thickness: 1,color:Theme.of(context).textTheme.titleMedium!.color,),
                      style:TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: height*.018),
                      dropdownColor: Theme.of(context).cardColor,
                      items:AllCategories().LastCities.map((e) => DropdownMenuItem(child: Text(e), value: e,)).toList(),
                      value:city  ,
                      onChanged: (String? v){setState(() {city=v!;});},







                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(userInfo.city!,style:TextStyle(color:  Theme.of(context).primaryColor,fontSize: height*.018 ),
                        textDirection: TextDirection.rtl,),
                      Text('المدينه : ',style:TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,fontSize: height*.018),
                        textDirection: TextDirection.rtl,),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MySaveButton(onpressed: ()async{
                  MyIndicator().loading(context);

                  if(await UserInfoo().editMyUser(myId: userInfo.uid!, key: userCity,newValue: city)){
                    if( await Provider.of<FireProvider>(context,listen: false).getMyUserInfo(context: context)){
                      Navigator.pop(context);
                      Navigator.popAndPushNamed(context, EditUserInfo.route);}
                  }
                  else{snack(context: context, message: 'خطأ حاول مره اخرى'); Navigator.pop(context);  return;}


                }),
                MyCloseButton(onpressed: (){setState(() {myCityPressed=!myCityPressed;});}),
              ],
            ),

          ],
        ),
      )
    ;}

  }


  myAddress({required UserInfoo userInfo,required double height}){
    return InkWell(
      onTap: ()async{
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeUserLocation(userInfoo: userInfo,),));

      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Text('تغيير العنوان',style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontSize: height*.018),),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).primaryColor,
          boxShadow: [BoxShadow(color: Theme.of(context).canvasColor,blurRadius: 3,spreadRadius: .3,blurStyle: BlurStyle.normal)]
        ),
        alignment: Alignment.center,
      ),
    );
  }







}





class ChangeUserLocation extends StatefulWidget {

  final UserInfoo userInfoo;

  const ChangeUserLocation({Key? key, required this.userInfoo}) : super(key: key);

  @override
  _ChangeUserLocationState createState() => _ChangeUserLocationState();
}

class _ChangeUserLocationState extends State<ChangeUserLocation> {
  Completer<GoogleMapController> _controller = Completer();

  LatLng myLatLng= LatLng(0, 0);

  bool locChanged=false;
  initialLatLng(){
    if(widget.userInfoo.lat==null){
      setState(() {
        myLatLng=LatLng(30.58768, 31.502);
      });
    }
    else{
      setState(() {
        myLatLng=LatLng(widget.userInfoo.lat!, widget.userInfoo.long!);
      });
    }


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialLatLng();
  }

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }

    return Scaffold(backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(backgroundColor:Theme.of(context).appBarTheme.backgroundColor,elevation: 0,),
      body: SafeArea(
        child: Stack(
          children: [
            myMap(),
            myNotice(height:height,width: width ),
            Positioned(
              bottom: 0,

                child: Container(
                  height: height*.1,width:width,
                  child: Row(
                       children: [
                          saveButton(height:height,width: width),
                          closeButton(height:height,width: width)
              ],
            ),
                ))

          ],
        ),
      ),
    );
  }

  Widget myMap(){
    return GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: CameraPosition(
        target:widget.userInfoo.lat==null?myLatLng: LatLng(widget.userInfoo.lat!, widget.userInfoo.long!),
        zoom: 18.4746,),
      onMapCreated: (GoogleMapController controller) {_controller.complete(controller);},
      onTap: (L){
        setState(() {
          myLatLng=L;
          locChanged=true;

        });},


      markers: [
        Marker(
          markerId: MarkerId('m'),
          position: myLatLng,


        )


      ].toSet(),



    );
  }

  Widget myNotice({required double height,required double width}){
    return  Positioned(
      top: 20,left: 20,
      child: Container(
        height: height*.1,width:height*.4,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(.8),
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
                Text('ملاحظه',style: TextStyle(color:Theme.of(context).textTheme.titleMedium!.color,fontSize: height*.018)),
                Icon(Icons.info,color: Theme.of(context).iconTheme.color,size: height*.03,)

              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                children: [
                  Text('  قم بتحديد موقع متجرك ',style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontSize:  height*.015),textDirection: TextDirection.rtl),
                  Text('  بواسطه النقر على  موقع المتجر على الخريطه',style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontSize:  height*.015),textDirection: TextDirection.rtl),
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
      child: InkWell(
        onTap: ()async{

          if(!locChanged){Navigator.pop(context);}

          if(
          await UserInfoo().editMyUser(myId: await Provider.of<FireProvider>(context,listen: false).myId!, key: userLat,newValue: myLatLng.latitude)
              &&
          await UserInfoo().editMyUser(myId: await Provider.of<FireProvider>(context,listen: false).myId!, key: userLong,newValue: myLatLng.longitude)

          )

          {
            if( await Provider.of<FireProvider>(context,listen: false).getMyUserInfo(context: context)){
              Navigator.pop(context);
              Navigator.popAndPushNamed(context, EditUserInfo.route);
            }
          }



        },
        child: Container(
            alignment: Alignment.center,
            width: height*.18,
            height: height*.06,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),),
            child: Text('حفظ',style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontSize: height*.018),)
        ),
      ),
    );
  }
  Widget closeButton({required double height,required double width}){
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          Navigator.pop(context);
        },
        child: Container(
            alignment: Alignment.center,
            width: height*.18,
            height: height*.06,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),),
            child: Text('إغلاق',style: TextStyle(color:  Theme.of(context).textTheme.bodySmall!.color,fontSize: height*.018),)
        ),
      ),
    );
  }
}




class myEditUserTextField extends StatelessWidget {

  double borderWidth = 1;
  Color borderColor = Colors.white.withOpacity(.3);
  Color fillColor = Colors.white.withOpacity(.1);
  double borderRadus = 5;


  TextEditingController? myController ;
  final String label;
  // final Icon icon;
  final bool obsecure;
  final TextInputType input;


  final String? Function(String?) vFuntion;
  final  String? Function(String?) sFuntion;

  //Function ontapFunction;

  myEditUserTextField({Key? key,
    required this.label,
    this.obsecure = false,
    // required this.icon,
    required this.vFuntion,
    required this.sFuntion,
    this.myController,
    required this.input,



  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
        builder: (context,deviceInfo) {
          double? screenHeight=deviceInfo.screenHeight!;
          double? screenWidth=deviceInfo.screenWidth;
          print(screenHeight);
          if(deviceInfo.orientation==Orientation.landscape){
            screenWidth=deviceInfo.screenHeight;
            screenHeight=deviceInfo.screenWidth;

          }
          return TextFormField(
            style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontSize:screenHeight!*.02 ),
            decoration: InputDecoration(
                fillColor: Theme.of(context).primaryColor,
                counterStyle: TextStyle(color: Theme.of(context).canvasColor,fontSize: screenHeight*.015),



                filled: true,
                isCollapsed: true,
                enabled: true,
                contentPadding:  EdgeInsets.all(screenHeight*.025),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: label,
                labelStyle: TextStyle(color:Theme.of(context).cardColor,fontWeight: FontWeight.normal,fontSize:screenHeight*.015 ),

                //  prefixIcon: icon,
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
                )
            ),

            obscureText: obsecure,
            textInputAction: TextInputAction.done,
            keyboardType: input,
            enabled: true,
            minLines: 1,
            maxLines: 1,
            maxLength: 20,
            // initialValue: 'bota',

            validator:vFuntion ,
            onSaved:sFuntion ,

            controller: myController,
          );
        }
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