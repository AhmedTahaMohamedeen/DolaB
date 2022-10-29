import 'package:flutter/material.dart';

class LightTheme{



  static const Color primaryColor=Color(0xFF5C9DF2);
  static const Color primaryColorLight=Color(0xFF94BDF2);
  static const Color primaryColorDark=Color(0xFF0D65D9);
  static const Color backGroundColor=Color(0xFFFFFFFF);
  static const Color scaffoldBackgroundColor=Color(0xFFFFFFFF);
  static const Color canvasColor=Color(0xFF0D0D0D);
  static const Color cardColor=Color(0xFFFFFFFF);



  static const AppBarTheme appBarTheme=AppBarTheme(
    backgroundColor: backGroundColor,
    actionsIconTheme: IconThemeData(color: Colors.black,),
    iconTheme: IconThemeData(color: primaryColor,),
    toolbarTextStyle:TextStyle() ,
    titleTextStyle: TextStyle(color: primaryColor),
    shadowColor: Colors.black,
    centerTitle: true,//reverse colors???? contact photo
  );


  static const String fontFamily='ReemKufii';
  static const Color darkText = Color(0xFF323E40);
  static const Color darkerText = Color(0xFF0D0D0D);
  static const Color lightText = Color(0xFFf3f4f6);
  static const Color lighterText = Color(0xFFFFFFFF);

  static const TextStyle headline1P = TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500, fontSize: 30, letterSpacing: 0.4, color: darkerText,);
  static const TextStyle headline2P = TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500, fontSize:28, letterSpacing: 0.4, color: darkerText,);
  static const TextStyle headline3P = TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.bold, fontSize: 26, letterSpacing: 0.4, color: darkerText,);
  static const TextStyle headline4P = TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500, fontSize: 24, letterSpacing: 0.4, color: darkerText,);
  static const TextStyle headline5P = TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500, fontSize: 22, letterSpacing: 0.27, color: darkerText,);
  static const TextStyle headline6P = TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500, fontSize: 20, letterSpacing: 0.18, color: darkerText,);
  static const TextStyle subtitle1P = TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w400, fontSize: 18, letterSpacing: -0.04, color: darkText,);
  static const TextStyle subtitle2P = TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w400, fontSize: 16, letterSpacing: -0.04, color: darkText,);
  static const TextStyle bodyText1P = TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w300, fontSize: 14, letterSpacing: -0.05, color: darkText,);
  static const TextStyle bodyText2P = TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w300, fontSize: 12, letterSpacing:  0.2,   color: darkText,);
  static const TextStyle captionP   = TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w200, fontSize: 10, letterSpacing:  0.2,   color: lightText, );


  static const TextStyle headline1 = TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500, fontSize: 30, letterSpacing: 0.4, color: lighterText,);
  static const TextStyle headline2 = TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500, fontSize:28, letterSpacing: 0.4, color: lighterText,);
  static const TextStyle headline3 = TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500, fontSize: 26, letterSpacing: 0.4, color: lighterText,);
  static const TextStyle headline4 = TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500, fontSize: 24, letterSpacing: 0.4, color: lighterText,);
  static const TextStyle headline5 = TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500, fontSize: 22, letterSpacing: 0.27, color: lighterText,);
  static const TextStyle headline6 = TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500, fontSize: 20, letterSpacing: 0.18, color: lighterText,);
  static const TextStyle subtitle1 = TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w400, fontSize: 18, color: lightText,);
  static const TextStyle subtitle2 = TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w400, fontSize: 16, color: lightText,);
  static const TextStyle bodyText1 = TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w400, fontSize: 14, color: lightText,);
  static const TextStyle bodyText2 = TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w400, fontSize: 12, color: lightText,);
  static const TextStyle caption   = TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w400, fontSize: 10, color: lightText, );

  static TextTheme textTheme  = const TextTheme(
    headline1:headline1 ,
    headline2: headline2,
    headline3: headline3,
    headline4: headline4,
    headline5: headline5,
    headline6: headline6,

    subtitle1: subtitle1,
    subtitle2: subtitle2,

    caption: caption,

    bodyText1: bodyText1,
    bodyText2: bodyText2,









  );
  static TextTheme PrimaryTextTheme  = const TextTheme(
    headline1:headline1P ,
    headline2: headline2P,
    headline3: headline3P,
    headline4: headline4P,
    headline5: headline5P,
    headline6: headline6P,

    subtitle1: subtitle1P,
    subtitle2: subtitle2P,

    caption: captionP,

    bodyText1: bodyText1P,
    bodyText2: bodyText2P,









  );

  static IconThemeData  iconThemeData= IconThemeData(color: Colors.white,);

  static FloatingActionButtonThemeData floatingActionButtonThemeData=  FloatingActionButtonThemeData(backgroundColor: primaryColorLight);

  static DialogTheme dialogTheme =DialogTheme(backgroundColor: primaryColor);

  static RadioThemeData radioThemeData= RadioThemeData(fillColor:MaterialStateProperty.all(primaryColorDark), );

}