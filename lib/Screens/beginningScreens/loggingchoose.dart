// ignore_for_file: file_names

import 'package:adminappp/constants/constantss.dart';
import 'package:flutter/material.dart';

import 'LoginScreen.dart';
class LoggingChoosesScreen extends StatefulWidget {
  static const  String route='/LoggingChoosesScreen';

  const LoggingChoosesScreen({Key? key}) : super(key: key);
  @override
  _LoggingChoosesScreenState createState() => _LoggingChoosesScreenState();
}

class _LoggingChoosesScreenState extends State<LoggingChoosesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body:
      Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration:const  BoxDecoration(
              // color: color_r,
              //  image: DecorationImage(image: AssetImage('assets/images/c.jpg'))
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              // color: Colors.black.withOpacity(.5),
                gradient: LinearGradient(
                    begin:  Alignment.topCenter,end:  Alignment.bottomCenter,
                    colors: [


                      //  Colors.black.withOpacity(.8),
                      // Colors.black.withOpacity(.7),
                      // Colors.black.withOpacity(.6),
                      // Colors.black.withOpacity(.5),
                      //  Colors.black.withOpacity(.4),
                      // Colors.black.withOpacity(.3),
                      //  Colors.black.withOpacity(.2),
                      Colors.black.withOpacity(.1),
                      Colors.black.withOpacity(.2),
                      Colors.black.withOpacity(.3),
                      Colors.black.withOpacity(.3),
                      Colors.black.withOpacity(.4),
                      Colors.black.withOpacity(.5),
                      Colors.black.withOpacity(.6),
                      Colors.black.withOpacity(.7),
                      Colors.black.withOpacity(.8),
                      Colors.black.withOpacity(.9),
                      Colors.black.withOpacity(1),


                    ]
                )
            ),
          ),
          Positioned(
              bottom: 100,
              left: 50,

              child: SizedBox(
                width: 300,
                height: 300,
                //color: color_y,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, LoginScreen.route);
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: 300,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(.2),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.white,width: .3)
                              ),
                              child:const  Center(child: Text('login with Email',style: TextStyle(color: Colors.white),)),


                            ),
                            Positioned(
                                bottom: 10,
                                left: 5,


                                child: CircleAvatar(
                                  backgroundImage:const  AssetImage('assets/images/email.png',),
                                  backgroundColor: Colors.black.withOpacity(0),
                                  radius: 15,


                                ))
                          ],
                        )
                    ),//Email
                    InkWell(
                        child: Stack(
                          children: [
                            Container(
                              width: 300,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: color_bl,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child:const  Center(child: Text('Google',style: TextStyle(color: Colors.white),)),


                            ),
                            Positioned(
                                bottom: 10,
                                left: 5,


                                child: CircleAvatar(
                                  backgroundImage:const  AssetImage('assets/images/google.png',),
                                  backgroundColor: Colors.black.withOpacity(0),
                                  radius: 15,


                                ))
                          ],
                        )
                    ),//google

                    InkWell(
                        child: Stack(
                          children: [
                            Container(
                              width: 300,
                              height: 50,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.blue.withOpacity(.1),
                                        Colors.blue.withOpacity(.2),
                                        Colors.blue.withOpacity(.3),
                                        Colors.blue.withOpacity(.4),
                                        Colors.blue.withOpacity(.5),
                                        Colors.blue.withOpacity(.6),
                                      ]
                                  ),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child:const  Center(child: Text('facebook',style: TextStyle(color:Colors.white),)),


                            ),
                            Positioned(
                                bottom: 10,
                                left: 5,


                                child: CircleAvatar(
                                  backgroundImage:const  AssetImage('assets/images/facebook3.png',),

                                  backgroundColor: Colors.black.withOpacity(0),
                                  radius: 15,


                                ))
                          ],
                        )
                    ),//facebook

                    InkWell(
                        onTap: (){
                          // Navigator.pushNamed(context, SignUpScreen.route);
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: 300,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(.2),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.white,width: .3)
                              ),
                              child:const  Center(child: Text('phone number',style: TextStyle(color: Colors.white),)),


                            ),
                            Positioned(
                                bottom: 10,
                                left: 5,


                                child:
                                Container(
                                  height: 30,width: 30,
                                  decoration:const  BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage('assets/images/phone.png',),fit: BoxFit.contain
                                      ),
                                      shape: BoxShape.circle
                                  ),

                                )





                            )
                          ],
                        )
                    ),//phone





                  ],
                ),

              )
          ),


        ],



      ),




    );
  }
}
