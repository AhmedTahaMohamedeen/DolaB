// ignore_for_file: file_names

import 'dart:async';

import 'package:adminappp/constants/constantss.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'LoginScreen.dart';
import 'loggingchoose.dart';
import 'registerChoose.dart';
class FirstScreen extends StatefulWidget {
static const  String route='/FirstScreen';

const FirstScreen({Key? key}) : super(key: key);
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
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

            child: MyPageViewer(),
          ),
          Positioned(
              bottom: 100,
              left: 50,

              child: SizedBox(
                width: 300,
                height: 300,
                //color: color_y,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    InkWell(
                        onTap: (){

                          Navigator.pushNamed(context, LoginScreen.route);
                        },
                        child: Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white,width: .3)
                          ),
                          child:const  Center(child: Text('login',style: TextStyle(color: Colors.white),)),


                        )
                    ),//login


                    InkWell(
                        onTap: (){
                           Navigator.pushNamed(context, RegisterChoosesScreen.route);
                        },
                        child: Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white,width: .3)
                          ),
                          child:const  Center(child: Text('Register',style: TextStyle(color: Colors.white),)),


                        )
                    ),//register





                  ],
                ),

              )
          ),


        ],



      ),




    );
  }
}
class MyPageViewer extends StatefulWidget {
  const MyPageViewer({Key? key}) : super(key: key);

  @override
  _MyPageViewerState createState() => _MyPageViewerState();
}

class _MyPageViewerState extends State<MyPageViewer> {

  List<String>images=[
    'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=420&q=80',
    'https://i.pinimg.com/564x/3c/a1/82/3ca182b445583c2e34e7b68539c5d906.jpg',
    'https://i.pinimg.com/564x/f4/f2/81/f4f281ada4f48c1a1948a0124232d66a.jpg'];
  int _currentPage = 0;
  Timer? _timer;
  PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 900),
        curve: Curves.easeIn,
      );
    });
  }
  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemBuilder: (context, index) =>
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: new CachedNetworkImageProvider( images[index]),
                fit: BoxFit.cover,
              ),
            ),
          ),
      itemCount: 3,

    );
  }
}
