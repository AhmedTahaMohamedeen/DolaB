import 'package:adminappp/constants/deviceInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';





class MyAddProductDetailsTextField extends StatelessWidget {

  double borderWidth = 1;
  Color borderColor = Colors.white.withOpacity(.3);
  Color fillColor = Colors.white.withOpacity(.1);
  double borderRadus = 5;









  final String? Function(String?) vFuntion;
  final  String? Function(String?) sFuntion;



  MyAddProductDetailsTextField({Key? key,



    required this.vFuntion,
    required this.sFuntion,






  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder= OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Theme.of(context).canvasColor.withOpacity(.1), width: 1),
    );
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

            obscureText: false,
            textInputAction: TextInputAction.newline,

            keyboardType: TextInputType.multiline,
            enabled: true,
            // minLines: 14,
            maxLines: 15,
            maxLength: 1000,

            validator:vFuntion ,
            onSaved:sFuntion ,
            textDirection:TextDirection.rtl ,
            scrollController: ScrollController(),

            selectionControls:CupertinoTextSelectionControls(),






            style: TextStyle(
                color:
                Theme.of(context).primaryColorDark
                ,
                fontSize:screenHeight!*.02 ,
                leadingDistribution: TextLeadingDistribution.even,
                textBaseline: TextBaseline.alphabetic

            ),
            decoration: InputDecoration(
                fillColor: Theme.of(context).cardColor,
                counterStyle: TextStyle(color: Theme.of(context).canvasColor,fontSize: screenHeight*.015),
                filled: true,
                isCollapsed: true,
                enabled: true,
                contentPadding:  EdgeInsets.all(screenHeight*.025),
                focusColor: Colors.yellow,
                hoverColor: Colors.red,










                enabledBorder: outlineInputBorder,
                disabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                errorBorder: outlineInputBorder,
                focusedErrorBorder: outlineInputBorder
            ),










          );
        }
    );
  }


}



class MyAddProductTextField extends StatelessWidget {






  TextEditingController? myController ;



  final TextInputType input;


  final String? Function(String?) vFuntion;
  final  String? Function(String?) sFuntion;



   MyAddProductTextField({Key? key,



    required this.vFuntion,
    required this.sFuntion,
    this.myController,
    required this.input,



  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    OutlineInputBorder outlineInputBorder= OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Theme.of(context).canvasColor.withOpacity(.3), width: 1),
    );
    return InfoWidget(
        builder: (context,deviceInfo) {
          double? screenHeight=deviceInfo.screenHeight;
          double? screenWidth=deviceInfo.screenWidth;
          print(screenHeight);
          if(deviceInfo.orientation==Orientation.landscape){
            screenWidth=deviceInfo.screenHeight;
            screenHeight=deviceInfo.screenWidth;

          }
          return TextFormField(
            style: TextStyle(color: Theme.of(context).primaryColorDark,fontSize:screenHeight!*.02 ),
            decoration: InputDecoration(
                fillColor: Theme.of(context).cardColor,
                counterStyle: TextStyle(color: Theme.of(context).canvasColor,fontSize: screenHeight*.015),



                filled: true,
                isCollapsed: true,
                enabled: true,
                contentPadding:  EdgeInsets.all(screenHeight*.02),
                floatingLabelBehavior: FloatingLabelBehavior.always,



                enabledBorder: outlineInputBorder,
                disabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                errorBorder: outlineInputBorder,
                focusedErrorBorder: outlineInputBorder
            ),

            obscureText: false,
            textInputAction: TextInputAction.done,
            keyboardType: input,
            enabled: true,
            minLines: 1,
            maxLines: 1,
            maxLength: 5,
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