// ignore_for_file: avoid_debugPrint

import 'package:adminappp/Screens/beginningScreens/verify2.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/providers/authProvider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyScreen1 extends StatefulWidget {
  static const  String route='/VerifyScreen1';

  const VerifyScreen1({Key? key}) : super(key: key);

  @override
  _VerifyScreen1State createState() => _VerifyScreen1State();
}

class _VerifyScreen1State extends State<VerifyScreen1> {

  bool pressed=false;
  @override
  void initState() {
    pressed=false;
    super.initState();
  }
  @override


  @override
  Widget build(BuildContext context) {
    var authProvider=Provider.of<AuthProvider>(context,listen: false);
    return Scaffold(
      backgroundColor: color_bl,
      appBar: AppBar(
        backgroundColor: color_bl,
        title: Text('Step-1',style: TextStyle(color: color_y),
        ),
      ),

      body: Column(
        crossAxisAlignment:CrossAxisAlignment.center ,


        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20,left: 20),
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(.3),width: 3),
                  color: Colors.white.withOpacity(.1),
                  borderRadius: BorderRadius.circular(20)

              ),
              child: Column(
                children: [
                  Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border:
                        Border.all(color: Colors.black.withOpacity(.3),width: 1),
                        color: Colors.black.withOpacity(.0),
                        borderRadius: BorderRadius.circular(10)

                    ),
                    child: Icon(Icons.info_outline,color: color_r,),

                  ),
                  const Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Text('you need to verify your Email by sending a link to your email press "send link"'
                      ,style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),

            ),
          ),
          const SizedBox(height: 50,),
          Ebotton(
            onpressed: (){
              if(pressed==false){  authProvider.getPref(); authProvider.sendLink();}
              else{debugPrint('sent');}

              //pressed==false? authProvider.sendLink():debugPrint('sent');
              setState(() {
                pressed=true;
              });

            },
            child:const Text('send-link',style: TextStyle(color: Colors.black),),
            backgroundcolor:pressed?Colors.white.withOpacity(.3): color_y,
            padding: 20,
            borderRadius: 20,
            borderColor: Colors.white.withOpacity(0),


          ),
          const SizedBox(height: 10,),

          const SizedBox(height: 100,),
          Ebotton(
            onpressed: (){
              if (pressed)
              {

                authProvider.auth();
                authProvider.logIn();
                Navigator.pushNamed(context, VerifyScreen2.route);


              }

            },
            child:const Text('next step',style:  TextStyle(color: Colors.black),),
            backgroundcolor:pressed?color_y:Colors.white.withOpacity(.3) ,
            padding: 20,
            borderRadius: 20,
            borderColor: Colors.white.withOpacity(0),


          ),




        ],
      ),
    );
  }
}
