import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/HomeScreen.dart';
class PhoneLogin extends StatefulWidget {
  static  const  String route='/PhoneLogin';
  const PhoneLogin({Key? key}) : super(key: key);

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  GlobalKey<FormState>myKey=GlobalKey<FormState>();

  String? phone;
  String? message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ListView(
          children: [
            SizedBox(height: 200,),
            Form(
              key: myKey,
              child: Column(
                children: [
                  MyPhoneLoginTextFormField(
                    icon: Icon(Icons.phone),
                    input: TextInputType.phone,
                    label: 'phone',
                    sFuntion: (s){setState(() {phone=s;});},
                    vFuntion: (v){if(v==null){return 'enter your phone number';}},
                  ),


                ],
              ),
            ),
            SizedBox(height: 200,),
            InkWell(

              onTap: ()async{
                if(!myKey.currentState!.validate()){return ;}
                else{
                  myKey.currentState!.save();
                  print(phone);
                Provider.of<AuthProvider>(context,listen: false).authWithPhone0(phone:phone!,context: context);


                }





              },
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text('register'),
                color: Colors.green,
                ),
              ),
            SizedBox(height: 200,),

            InkWell(

              onTap: ()async{
               //await Provider.of<AuthProvider>(context,listen: false).auth5();






              },
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text('get info'),
                color: Colors.green,
              ),
            ),


          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Provider.of<AuthProvider>(context,listen: false).logout();
        },
      ),
    );
  }
}











class MyPhoneLoginTextFormField extends StatelessWidget {

  double borderWidth = .50;
  Color borderColor = Colors.black;
  Color fillColor = Colors.white.withOpacity(1);
  double borderRadus = 5;

  TextStyle inputTextStyle=TextStyle(color: Colors.black, fontSize:16);
  TextStyle labelTextStyle=TextStyle(color: backColor2, fontSize:16);




  TextEditingController? myController ;
  final String label;
  final Icon icon;
  final bool obsecure;
  final TextInputType input;


  final String? Function(String?) vFuntion;
  final  String? Function(String?) sFuntion;

  //Function ontapFunction;

  MyPhoneLoginTextFormField({Key? key,
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
    return TextFormField(
      style: inputTextStyle,
      decoration: InputDecoration(
          fillColor:fillColor,





          filled: false,
          isCollapsed: true,
          contentPadding: const EdgeInsets.all(10),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: label,
          labelStyle: labelTextStyle,
          prefixIcon: icon,
          // prefixIconColor: Colors.white,



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