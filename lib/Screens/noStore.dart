// ignore_for_file: file_names

import 'package:adminappp/constants/constantss.dart';
import 'package:flutter/material.dart';

import 'createStore.dart';
class NoStore extends StatefulWidget {
  static const  String route='/NoStore';

  const NoStore({Key? key}) : super(key: key);

  @override
  _NoStoreState createState() => _NoStoreState();
}

class _NoStoreState extends State<NoStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 3,


      ),

      body: Center(
        child: Column(
          children: [
            Text('ليس لديك متجر ',style: TextStyle(fontSize: 40,color: Theme.of(context).canvasColor),),
            SizedBox(height: 130,),
            Text('هل تريد إنشاء متجرك الخاص؟',style: TextStyle(fontSize: 12,color: Theme.of(context).primaryColorDark)),
            SizedBox(height: 10,),
           InkWell(
             onTap: (){
               Navigator.pushNamed(context, CreateStore.route);
             },
             child: Container(
               height: 50,
               width: 200,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10),
                 color: Theme.of(context).primaryColorDark,
                 boxShadow: [BoxShadow(color: Colors.black,blurRadius: 1)]

               ),
               alignment: Alignment.center,
               child: Text('إنشاء متجر',style: TextStyle(fontSize: 16,color: Theme.of(context).cardColor)),
             ),
           )
          ],
        ),
      ),
    );
  }
}
