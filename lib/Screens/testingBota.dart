




import 'package:adminappp/constants/MyIndicator.dart';

import 'package:flutter/material.dart';



class BotaTest extends StatefulWidget {
  static const String route='/botaTest';
  const BotaTest({Key? key}) : super(key: key);

  @override
  _BotaTestState createState() => _BotaTestState();
}

class _BotaTestState extends State<BotaTest> {




  @override
  Widget build(BuildContext context) {

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
       height=MediaQuery.of(context).size.width;
       width=MediaQuery.of(context).size.height;
    }




    return Scaffold(

      appBar: AppBar(),

      body:myShimmer(color: Theme.of(context).primaryColor)



    );}


//Color(0xff4E2718)
//Color(0xff935A7D)
//Color(0xff0099AB)





}





//launch('whatsapp://send?phone=0127157960')
//launch('tel:tel') //tel=+105556121
//launch('tel:tel') //tel=+105556121

