
// ignore_for_file: file_names, avoid_debugPrint

import 'dart:ui';

import 'package:adminappp/Screens/beginningScreens/SignupScreen.dart';
import 'package:adminappp/constants/MyIndicator.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../home/HomeScreen.dart';
class LoginScreen extends StatefulWidget {
  static const   String route='/LoginScreen';

  const  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState>myKey=GlobalKey<FormState>();
  bool visible=false;

  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }

    return Scaffold(
        backgroundColor:Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor:Theme.of(context).appBarTheme.backgroundColor,

          elevation: 5,

        ),

        body:

        SafeArea(
          child: Stack(
              children:[



                Form(
                  key: myKey,

                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView(
                      children: [
                        Text('تسجيل الدخول',style: Theme.of(context).primaryTextTheme.headline4,
                          textAlign: TextAlign.right,),


                        SizedBox(height: height*.05,),

                        MyLoginTextFormField(label:  'البريد الالكترونى',
                          icon: Icon(Icons.alternate_email_outlined,color: Theme.of(context).iconTheme.color,size: height*.02,),
                          input: TextInputType.emailAddress,
                          sFuntion: (s){setState(() {email=s;});return null;},
                          vFuntion: (String? v){if (v!.isEmpty||!v.contains('@')){return 'error email';}return null;},


                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*.025,),


                        MyPasswordTextField(label: 'كلمه السر',
                          prefIcon: Icon(Icons.vpn_key_outlined,color: Theme.of(context).iconTheme.color,size: height*.02,),
                          sufIcon: InkWell(
                            child: visible?Icon(Icons.visibility_off_outlined,color: Theme.of(context).iconTheme.color,size: height*.02,)
                                :Icon(Icons.remove_red_eye_outlined,color: Theme.of(context).iconTheme.color,size: height*.02,),
                            onTap: (){setState(() {visible=!visible;});},
                          ),
                          obsecure:visible?false: true,
                          input: TextInputType.text,

                          sFuntion:(s){setState(() {password=s;});return null;},
                          vFuntion: (String? v){if (v!.isEmpty){return 'enter password';}return null;},


                        ),
                        SizedBox(height: height*.035,),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              child:

                              Text(' نسيت كلمه السر ؟',
                                style: Theme.of(context).primaryTextTheme.subtitle1!.copyWith(fontSize: height*.018,decoration: TextDecoration.underline,color: Theme.of(context).primaryColorDark ),
                                textAlign: TextAlign.right,),
                              onTap: (){Navigator.pushNamed(context, LoginScreen.route);},
                            ),
                          ),
                        ),

                        SizedBox(height:height*.1,),

                        InkWell(
                            onTap: ()async{

                              if(myKey.currentState!.validate()){

                                MyIndicator().loading(context);
                                myKey.currentState!.save();

                                var auth=Auth();

                                auth.email=email!;
                                auth.password=password!;
                                if ( await auth.logIn())
                                {
                                  //  if ( authProvider.user!.emailVerified){
                                  Navigator.pushNamedAndRemoveUntil(context, Home.route,(route)=>false);
                                  // } else{Navigator.pushNamed(context, VerifyScreen1.route,);}
                                }
                                else{
                                  Navigator.pop(context);
                                  debugPrint('login error');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(auth.error.toString()))
                                  );
                                }


                              }
                              else{

                                return;}




                            },
                            child: UnconstrainedBox(
                              constrainedAxis: Axis. vertical,

                              child: Material(
                                color: Colors.transparent,
                                elevation: 3,
                                shadowColor: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  width: height*.3,
                                  height: height*.07,

                                  decoration: BoxDecoration(
                                  //  color:Colors.black,
                                    borderRadius: BorderRadius.circular(50),
                                    //border: Border.all(color: backColor2,width: .3),
                                     gradient: LinearGradient(
                                            colors: [

                                             Theme.of(context).primaryColorLight,
                                             Theme.of(context).primaryColor,
                                             Theme.of(context).primaryColorDark,


                                            ]
                                        ),
                                  ),
                                  child:  Center(child: Text('تسجيل الدخول',style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: height*.018))),


                                ),
                              ),
                            )
                        ),

                        SizedBox(height: height*.1,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [

                            GestureDetector(
                              child:

                              Text('إنشاء حساب جديد',
                                style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: height*.018,color: Theme.of(context).primaryColorDark, decoration: TextDecoration.underline,)


                                ),





                              onTap: (){
                                Navigator.pushNamed(context, SignUpScreen.route);
                              },



                            ),
                          //  Text("     ليس لدى حساب      ",style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: height*.015,color: Theme.of(context).canvasColor),),
                          ],),



                        SizedBox(height:height*.06,),





                      ],
                    ),
                  ),
                ),


              ]),
        ),



    );
  }


  Color iconColor=backColor2;
}

class MyLoginTextFormField extends StatelessWidget {

  double borderWidth = .50;
  Color borderColor = Colors.black.withOpacity(0);

  double borderRadus = 5;

  TextStyle labelTextStyle=TextStyle(color: backColor2, fontSize:16);




  TextEditingController? myController ;
  final String label;
  final Icon icon;
  final bool obsecure;
  final TextInputType input;


  final String? Function(String?) vFuntion;
  final  String? Function(String?) sFuntion;

  //Function ontapFunction;

  MyLoginTextFormField({Key? key,
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
    return Material(
      elevation: 2,
      shadowColor:
      Theme.of(context).primaryColor
      ,
      color: Colors.white.withOpacity(0),
      type: MaterialType.button,


      
     

      child: TextFormField(
        style: TextStyle(color: Theme.of(context).textTheme.subtitle1!.color, fontSize:height*.02),
        decoration: InputDecoration(
            fillColor:Theme.of(context).primaryColor,





            filled: true,
            isCollapsed: true,
            contentPadding: const EdgeInsets.all(10),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: label,
            labelStyle: Theme.of(context).textTheme.subtitle1!.copyWith(    fontSize:height*.02),


            prefixIcon: icon,
          //  floatingLabelAlignment:FloatingLabelAlignment.start ,




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




        validator:vFuntion ,
        onSaved:sFuntion ,
        // onTap: ontapFunction,
        controller: myController,
      ),
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



