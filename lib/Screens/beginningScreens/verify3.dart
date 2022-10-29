import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/providers/authProvider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/HomeScreen.dart';
class VerifyScreen3 extends StatefulWidget {
  static const  String route='/VerifyScreen3';

  const VerifyScreen3({Key? key}) : super(key: key);

  @override
  _VerifyScreen3State createState() => _VerifyScreen3State();
}

class _VerifyScreen3State extends State<VerifyScreen3> {

  bool pressed=false;
  @override
  void initState() {
    // TODO: implement initState
    pressed=false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var authProvider=Provider.of<AuthProvider>(context,listen: false);
    return Scaffold(
      backgroundColor: color_bl,
      appBar: AppBar(
        backgroundColor: color_bl,
        title: Text('final step',style: TextStyle(color: color_y),
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
                    child: Text('please check your email and click on the link"'
                      ,style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),

            ),
          ),
          const SizedBox(height: 50,),

          const SizedBox(height: 100,),
          Ebotton(
            onpressed: (){

              authProvider.auth();
              authProvider.logIn();
              if (authProvider.user!.emailVerified){
                Navigator.pushNamedAndRemoveUntil(context, Home.route,(route)=>false);
              }
              else{
                Navigator.pushNamedAndRemoveUntil(context, VerifyScreen3.route,(route)=>false);

              }






            },
            child:const Text('finish',style: TextStyle(color: Colors.black),),
            backgroundcolor:color_y ,
            padding: 20,
            borderRadius: 20,
            borderColor: Colors.white.withOpacity(0),


          ),




        ],
      ),
    );
  }
}
