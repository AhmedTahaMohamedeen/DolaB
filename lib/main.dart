
// ignore_for_file: avoid_debugPrint, use_function_type_syntax_for_parameters, non_constant_identifier_names

import 'package:adminappp/providers/authProvider.dart';
import 'package:adminappp/providers/fireProvider.dart';
import 'package:adminappp/routes.dart';
import 'package:adminappp/theme/light_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/home/HomeScreen.dart';
import 'Screens/beginningScreens/firstScreen.dart';
import 'Screens/beginningScreens/loadingScreen.dart';



void main()async {
  WidgetsBinding widgetsBinding =WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight ]);





  Auth auth=Auth();

  SharedPreferences pref=await SharedPreferences.getInstance();
  bool? login=pref.getBool('login');

  String screen;

  if (login==null||login==false)   {screen=FirstScreen.route;  FlutterNativeSplash.remove();}
  else{
    auth.email=pref.getString('email')!;
    auth.password= pref.getString('password')!;

    if(await auth.logIn() )

                           {
                             //bota.auth();




                         //  if( bota.user!.emailVerified){
                             screen=Home.route;
                          // } else{screen=VerifyScreen1.route;}
                           }

    else
    {screen=FirstScreen.route;}






  }

  FlutterNativeSplash.remove();
     runApp(
      MultiProvider(
          providers: [
             ChangeNotifierProvider(create: (_) => AuthProvider(),),
            ChangeNotifierProvider(create: (_) => FireProvider(),),
          ],


          child:MyApp(screen:screen,)



      ));
}

class MyApp extends StatefulWidget {
  final String screen;
   const MyApp({Key? key, required this.screen}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

bool done=false;
func()async{
  var fire=Provider.of<FireProvider>(context,listen: false);
if(await fire.getMyUserInfo(context: context)){
  FlutterNativeSplash.remove();

}
else{}




}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    func();

  }
  @override
  Widget build(BuildContext context) {
   // func();




  return MaterialApp(

    debugShowCheckedModeBanner: false,
    routes: routes,
    color: Colors.white,

    initialRoute:
    widget.screen,
    //FirstScreen.route
    //LoginScreen.route
    // Home.route





theme: ThemeData(

    appBarTheme: LightTheme.appBarTheme,


    textTheme:LightTheme.textTheme ,
  primaryTextTheme: LightTheme.PrimaryTextTheme,
  iconTheme:LightTheme. iconThemeData,


  scaffoldBackgroundColor:LightTheme.scaffoldBackgroundColor,
  backgroundColor: LightTheme.backGroundColor,
  primaryColor: LightTheme.primaryColor,
  primaryColorDark: LightTheme.primaryColorDark,
  primaryColorLight: LightTheme.primaryColorLight,
  canvasColor: LightTheme.canvasColor,
   cardColor: LightTheme.cardColor,




radioTheme:LightTheme.radioThemeData,


  floatingActionButtonTheme:  LightTheme.floatingActionButtonThemeData,

  dialogTheme:LightTheme.dialogTheme






),




    themeMode: ThemeMode.light,





    darkTheme: ThemeData(
      scaffoldBackgroundColor: Colors.black,
                                  appBarTheme: AppBarTheme(
                                    backgroundColor: Colors.black.withOpacity(.5),
                                    actionsIconTheme: IconThemeData(color: Colors.white.withOpacity(.5),),
                                    iconTheme: IconThemeData(color: Colors.white.withOpacity(.5),),
                                    toolbarTextStyle:TextStyle() ,
                                    titleTextStyle: TextStyle(color: Colors.white,),
                                      shadowColor: Colors.white,
                                    centerTitle: false,//reverse colors????
                                  ),





                textTheme:TextTheme(
                          bodySmall: TextStyle(color: Colors.white ),
                          titleMedium: TextStyle(color: Colors.white, ),) ,



        primaryColor: Colors.black,
      canvasColor: Colors.white,
      cardColor: Colors.white,
      //shadowColor: Colors.white,




        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.blue),


      iconTheme: IconThemeData(color: Colors.white.withOpacity(.8)),


        dialogBackgroundColor: Colors.black




    ),







  );



  }
}
