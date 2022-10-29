// ignore_for_file: file_names, avoid_debugPrint




import 'dart:io';

import 'package:adminappp/constants/Categories.dart';
import 'package:adminappp/constants/MyIndicator.dart';
import 'package:adminappp/constants/My_Flush.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/userInfo.dart';
import 'package:adminappp/providers/authProvider.dart';
import 'package:adminappp/providers/fireProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../home/HomeScreen.dart';
import 'LoginScreen.dart';

class SignUpScreen extends StatefulWidget {
  static const  String route='/SignUpScreen';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState>myKey=GlobalKey<FormState>();
  String name='';
  String email='';
  String password='';


  String city='الزقازيق';
  String? sex;

  int age=18;
  String? phone;
  int indexOfCity=0;
  File? imageFile;
  XFile? picked;
  TextEditingController myController=TextEditingController();
  bool visible=false;




  @override
  Widget build(BuildContext context) {
    var authProvider=Provider.of<AuthProvider>(context,listen: false);

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }
    return Scaffold(
      backgroundColor:Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 50,

      ),


        body:
        SafeArea(
          child: Stack(
              children:
              [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                     // color:Colors.black


                    //  image: const DecorationImage(image: AssetImage('assets/images/back4.jpg'),fit: BoxFit.cover)
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(


                  ),
                ),



                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView(
                    keyboardDismissBehavior:ScrollViewKeyboardDismissBehavior.onDrag ,

                    children: [
                      Text('انشاء حساب',style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: height*.025,color: Theme.of(context).primaryColorDark),
                      textAlign: TextAlign.right,),

                      SizedBox(height: MediaQuery.of(context).size.height*.03,),
                      Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                        children: [
                          ImageCircle(),

                          Ebotton(
                            onpressed: ()async{
                              var myCroppedImage= await Provider.of<FireProvider>(context,listen: false).addImageAndCrop();
                              setState(() {
                                imageFile=myCroppedImage;
                                picked=Provider.of<FireProvider>(context,listen: false).pickedCrop;


                              });

                            },
                            child: Text('اختر صوره',style:  Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: height*.018),),
                            borderRadius: 10,
                            backgroundcolor: Theme.of(context).primaryColorDark,
                            borderColor: Colors.white.withOpacity(0),
                            padding: 15,



                          )


                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.03,),
                      Form(
                        key: myKey,
                        child: Column(
                          children: [
                                    Container(
                                      decoration: BoxDecoration(
                                         // boxShadow: [BoxShadow(color: Colors.white)]
                         ),
                                      child: MySignUpTextField(label: 'الاسم', icon: Icon(Icons.person,color: Theme.of(context).iconTheme.color,size: 20,),
                                          input: TextInputType.text,
                                          sFuntion: (s){setState(() {name=s!;});return null;},
                                          vFuntion: (String? v){if (v!.isEmpty){return'ادخل اسمك';}return null;}),
                                    ),


                            SizedBox(height: MediaQuery.of(context).size.height*.0125,),
                                    MySignUpTextField(label: 'البريد الالكترونى', icon: Icon(Icons.alternate_email_outlined,color: Theme.of(context).iconTheme.color,size: 20),
                                        input: TextInputType.emailAddress,
                                        sFuntion: (s){setState(() {email=s!;authProvider.email=s;});return null;},
                                        vFuntion: (String? v) {if (v!.isEmpty || !v.contains('@')) {return 'البريد به خطأ';}return null;}),


                            SizedBox(height: MediaQuery.of(context).size.height*.0125,),
                                    MyPasswordTextField(
                                        label: 'كلمه السر',
                                        prefIcon: Icon(Icons.vpn_key_outlined,color:Theme.of(context).iconTheme.color,size: 20,),
                                        sufIcon: InkWell(
                                          child: visible?Icon(Icons.visibility_off_outlined,color: Colors.white)
                                              :Icon(Icons.remove_red_eye_outlined,color: Colors.white,),
                                          onTap: (){setState(() {visible=!visible;});},
                                        ),
                                        obsecure:visible?false: true,
                                        input: TextInputType.text,
                                        myController: myController,
                                        sFuntion: (s){setState(() {
                                            password=s!;
                                            authProvider.password=s;});},
                                        vFuntion: (String? v){if (v!.isEmpty){return'ادخل كلمه السر';}}),

                            SizedBox(height: MediaQuery.of(context).size.height*.0125,),
                            MyPasswordTextField(
                              label: 'اعاده كلمه السر',
                              prefIcon: Icon(Icons.vpn_key_outlined,color:Theme.of(context).iconTheme.color,size: 20,),
                              sufIcon: InkWell(
                                child: visible?Icon(Icons.visibility_off_outlined,color: Colors.white)
                                    :Icon(Icons.remove_red_eye_outlined,color: Colors.white,),
                                onTap: (){setState(() {visible=!visible;});},
                              ),
                              obsecure:visible?false: true,
                              input: TextInputType.text,
                                        vFuntion: (String? v){if (v!=myController.text){return 'الكلمتان ليست متطابقتان';}},
                                        sFuntion: (s){},

                                      ),
                            SizedBox(height: MediaQuery.of(context).size.height*.0125,),

                                      MySignUpTextField(label: 'رقم الهاتف', icon: Icon(Icons.settings_cell_rounded,color: Theme.of(context).iconTheme.color,size: 20,),
                                          input: TextInputType.text,
                                          sFuntion: (s){setState(() {phone=s!;});},
                                          vFuntion: (String? v){
                                            if (v!.isEmpty){return'ادخل رقم الهاتف';}}),
                          ],
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height*.025,),
                      SizedBox(height: MediaQuery.of(context).size.height*.025,),




                      getMyLocation(context),
                      SizedBox(height: MediaQuery.of(context).size.height*.0125,),
                      signupAge(),






                      //SizedBox(height: MediaQuery.of(context).size.height*.025,),
                      SizedBox(height: MediaQuery.of(context).size.height*.025,),
                       signupSex(),
                       SizedBox(height: MediaQuery.of(context).size.height*.0125,),







                      SizedBox(height: MediaQuery.of(context).size.height*.025,),

                      signupButton(),


                      SizedBox(height: MediaQuery.of(context).size.height*.07,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,

                        children: [

                        GestureDetector(
                          child:

                          Text('تسجيل الدخول',
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,
                               // decoration: TextDecoration.underline
                            ),

                          ),



                          onTap: (){
                            Navigator.pushNamed(context, LoginScreen.route);
                          },



                        ),
                         Text("    لدى حساب بالفعل     ",style: Theme.of(context).textTheme.subtitle1!.copyWith(
                             fontSize:height*.015,color: Theme.of(context).primaryColorDark,
                           decoration: TextDecoration.underline

                         )),
                      ],),
                      SizedBox(height: MediaQuery.of(context).size.height*.07,),



                    ],
                  ),
                ),



              ]),
        ),

    );
  }








  Widget ImageCircle(){
    if (imageFile==null){
      return Container(
        height: 100,width: 100,

        child: Icon(Icons.person,size: 70,),
        decoration:  BoxDecoration(
            color: Theme.of(context).primaryColor,

            shape: BoxShape.circle,
         border: Border.all(color: backColor2,width: .5),
           // image: DecorationImage(image: AssetImage('assets/images/emptyprofile.png'))

        ),
      );}
    else {return Container(
      height: 150,width: 150,
      decoration: BoxDecoration(
        // color: Colors.yellow,
          shape: BoxShape.rectangle,
          image: DecorationImage(
              image: FileImage(imageFile!,),
              fit: BoxFit. fill
          )
      ),
    );}
  }





  TextStyle nameStyle=TextStyle(color: backColor2,fontWeight: FontWeight.w500);
  TextStyle chooseStyle=TextStyle(color: backColor2,);
  TextStyle dropStyle=TextStyle(color:backColor2,);
  double borderRadius=5;
  double borderWidth=.5;
 // Color iconsColor1=Theme.of(context).iconTheme.color;
  Color borderColor=Colors.black;
  Color checkColor=backColor2;
  Color backgroundColor=backColor1;




Widget _signupCity(){
    return Container(
       // width:  MediaQuery.of(context).size.width*.45,
      decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: backgroundColor,
          border: Border.all(color: borderColor,width: borderWidth)
      ),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween ,
        children: [

          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: DropdownButton(items: AllCategories().LastCities.map((e) =>
                DropdownMenuItem(child: Text(e,style: TextStyle(fontSize: 12),), value: e,)).toList(),
              onChanged: (String? v){

                setState(() {


                  city=v!;

                });
              },
              value:city ,

              style:dropStyle,
              dropdownColor: color_bl,



            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('المدينه',style:nameStyle,),
          ),
        ],
      ),
    );//city
  }
  Widget signupAge(){
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }
    return Container(
      decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Theme.of(context).primaryColor,

      ),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween ,
        children: [

          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: DropdownButton(
              items: AllCategories().ages.map((e) =>
                  DropdownMenuItem(child: Text(e.toString(),style: TextStyle(color: Colors.white)), value: e,)).toList(),
              onChanged: (s){
                setState(() {
                  age=int.parse(s.toString());
                });
              },

              value:age ,

              dropdownColor: Theme.of(context).primaryColorDark,



            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('العمر',style:  TextStyle(color: Theme.of(context).textTheme.subtitle1!.color, fontSize:height*.02),),
          ),
        ],
      ),
    );
  }

  Widget signupSex(){
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }
    return Container(

    //  height: 100,
      decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(borderRadius),
        color: Theme.of(context).primaryColor
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Column(
            children: [
              Row(
                children: [
                  Radio(value: 'ذكر',
                   // activeColor: Colors.white,
                    groupValue: sex,
                    onChanged: (value){setState(() {sex=value.toString();});debugPrint(sex);},



                    fillColor: MaterialStateProperty.all(Colors.white),



                  ),
                  Text('ذكر',style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize:height*.015 ))
                ],
              ),


              Row(
                children: [
                  Radio(value:'انثى', groupValue: sex, onChanged: (value){ setState(() {sex=value.toString();});debugPrint(sex);},


                    fillColor: MaterialStateProperty.all(Colors.white),
                  ),

                  Text('انثى',style:Theme.of(context).textTheme.subtitle1!.copyWith(fontSize:height*.015 ))
                ],
              ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Text('الجنس',style:Theme.of(context).textTheme.subtitle1!.copyWith(fontSize:height*.020 )),
          ),

        ],
      ),
    );//sex
  }

  double lat=0;
  double long=0;
  bool locationGot=false;
  
  Widget getMyLocation(BuildContext context){
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }
  return InkWell(
      onTap: ()async{

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

        setState(() {
          lat=_locationData.latitude!;
          long=_locationData.longitude!;
        });
        if(lat!=0){setState(() {locationGot=true;});}


      },


      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 10),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color:locationGot?Theme.of(context).primaryColor:Theme.of(context).primaryColorLight
        ),
        child:locationGot?

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.done,color: Colors.white,),
            Text('تم إضافه العنوان',style:  TextStyle(color: Theme.of(context).textTheme.subtitle1!.color, fontSize:height*.015)),
          ],
        )

            : Text('إضافه العنوان',style:  TextStyle(color: Theme.of(context).textTheme.subtitle1!.color, fontSize:height*.015)),
        alignment: Alignment.center,
      ));
  }





  Widget signupButton(){
    var authProvider=Provider.of<AuthProvider>(context,listen: false);
    var fireProvider=Provider.of<FireProvider>(context,listen: false);

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }

    return   Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      child:

      InkWell(
          onTap: ()async{
            if(sex==null){MyFlush().showFlush(context: context, text: 'من فضلك ادخل الجنس ');return;}
            if(long==0){MyFlush().showFlush(context: context, text: 'من فضلك أضف العنوان ');return;}

            if(!myKey.currentState!.validate()){return;}
            else{
              MyIndicator().loading(context);
              myKey.currentState!.save();}
            authProvider.auth();
            if (picked==null){
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('اختر صوره')));return;}
            else {
              if (await authProvider.register()) {
                if (!await fireProvider.uploadImageCrop(imageFileCrop:  imageFile!,pickedCrop:  picked!)) {
                  Navigator.pop(context);
                  debugPrint('uploadError');
                  return;
                }
                else {
                  if (await UserInfoo().addUser(
                      UserInfoo(
                          name: name,
                          phone: phone,
                          email: email,
                          photo: fireProvider.imageUrlCrop,
                          uid: authProvider.user!.uid,
                          photoLoc: fireProvider.photoLocCrop,
                          sex: sex,
                         // governorate:governorate ,
                          city: city,
                          age: age,
                         lat: lat,
                         long: long,
                         //maritalStatus:status


                      ))) {
                    // Navigator.pushNamed(context, VerifyScreen1.route,);
                    authProvider.logIn();
                    Navigator.pushNamedAndRemoveUntil(context, Home.route, (route) => false);

                  }
                  else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(
                        content: Text(authProvider.error!)));
                  }
                }
              }
              else {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(authProvider.error!))
                );
              }
            }


          },
          child: Container(
            width: 300,
            height: 50,
            decoration: BoxDecoration(
              color:Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.circular(5),
             // border: Border.all(color: backColor2,width: .3),

            ),
            child:  Center(child: Text('انشاء حساب',style: Theme.of(context).textTheme.subtitle2!,)),


          )
      ),//SIGNUPButton

    );
  }


}

class MySignUpTextField extends StatelessWidget {

  double borderWidth = 0;
  Color borderColor = Colors.black.withOpacity(0);
  Color fillColor = Colors.white.withOpacity(1);
  double borderRadus = 5;

  //TextStyle inputTextStyle=TextStyle(color: Colors.white, fontSize:16,);
  //TextStyle labelTextStyle=TextStyle(color: backColor2, fontSize:16);




  TextEditingController? myController ;
  final String label;
  final Icon icon;
  final bool obsecure;
  final TextInputType input;


  final String? Function(String?) vFuntion;
  final  String? Function(String?) sFuntion;

  //Function ontapFunction;

  MySignUpTextField({Key? key,
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
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }
    return TextFormField(
      style:  TextStyle(color: Theme.of(context).textTheme.subtitle1!.color, fontSize:height*.02),
      decoration: InputDecoration(
          fillColor:Theme.of(context).primaryColor,





          filled: true,
          isCollapsed: true,
          contentPadding: const EdgeInsets.all(10),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: label,
          labelStyle:  TextStyle(color: Theme.of(context).textTheme.subtitle1!.color, fontSize:height*.02),
          prefixIcon: icon,
         // suffixIcon: Icon(Icons.remove_red_eye_outlined),




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
      textInputAction: TextInputAction.go,
      keyboardType: input,
      enabled: true,
    cursorColor: Colors.white,
    // autovalidateMode:  AutovalidateMode.onUserInteraction,



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

