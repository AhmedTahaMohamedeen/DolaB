
// ignore_for_file: file_names, avoid_debugPrint


import 'package:adminappp/Screens/User/user_shopping_cart/ShoppingCart.dart';
import 'package:adminappp/Screens/User/loveScreen.dart';
import 'package:adminappp/Screens/User/user_order/userOrders.dart';
import 'package:adminappp/Screens/User/user_profile/user_profile_helper.dart';
import 'package:adminappp/Screens/beginningScreens/firstScreen.dart';
import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/deviceInfo.dart';
import 'package:adminappp/constants/followInfo.dart';
import 'package:adminappp/constants/productInfo.dart';
import 'package:adminappp/constants/userInfo.dart';
import 'package:adminappp/providers/authProvider.dart';
import 'package:adminappp/providers/fireProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../testingBota.dart';
import '../edit_user/editUser.dart';

import '../following_screen.dart';





class UserProfileScreen extends StatefulWidget {
  static const  String route='/UserProfileScreen';

  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {


  List<Product> myProducts=[];
UserInfoo? userInfo;
List<Admin> admins=[];




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      primary: true,
      appBar: AppBar(elevation: 0),

      body: InfoWidget(
        builder: (context,deviceInfo) {
          print(deviceInfo.deviceType.toString());
          print(deviceInfo.orientation.toString());

          double? screenHeight=deviceInfo.screenHeight;
          double? screenWidth=deviceInfo.screenWidth;
          if(deviceInfo.orientation==Orientation.landscape){
            screenWidth=deviceInfo.screenHeight;
            screenHeight=deviceInfo.screenWidth;
          }
          return Stack(
            children:
            [
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: screenHeight!*.04,),
                        _photo(screenHeight: screenHeight),
                        SizedBox(height: screenHeight*.025,),
                        _name(screenHeight: screenHeight),
                        const SizedBox(height: 1,),
                        _phone(screenHeight: screenHeight)


                      ],
                    ),

                     SizedBox(height:  screenHeight*.05,),
                    Material(
                      color: Theme.of(context).cardColor,
                      elevation: 100,
                      child: Container(
                        height:  screenHeight*.45,

                        child: Column(
                          children: [
                            LoveTile(localHeight: screenHeight*.45),
                            FollowingTile(localHeight: screenHeight*.45),
                            MyOrders(localHeight: screenHeight*.45),
                            MyShoppingCart(localHeight: screenHeight*.45),
                            DetailsAndEditTile(localHeight: screenHeight*.45),
                            LogOutTile(localHeight: screenHeight*.45),




                          ],
                        ),
                      ),
                    ),






                  ],
                ),
              ),





              MyFloating( myLoc1: myLoc.none,)



            ],
          );
        }
      ),


      //floatingActionButton: FloatingActionButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => BotaTest(),));},),





    );
  }


Widget _photo({required double screenHeight }){
    return
      Material(
        type: MaterialType.circle,
        elevation: 30,
        color: Theme.of(context).cardColor,
        child: Container(

          height: screenHeight*.2,
          width: screenHeight*.2,
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).cardColor,width: 3),
              shape: BoxShape.circle,
              image:  DecorationImage(image: CachedNetworkImageProvider(userInfo!.photo!),fit: BoxFit.fill)
          ),
        ),
      );
}
Widget _name({required double screenHeight }){
    return
      Text(

        '${userInfo!.name}'
        ,
        style:  TextStyle(
            fontSize:  screenHeight*.025,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColorDark),)//name
     ;
}
Widget _phone({required double screenHeight }){
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.phone,color: Theme.of(context).primaryColorDark,size:  screenHeight*.025),
          Text('${userInfo!.phone}  ',
            style:  TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize:  screenHeight*.015),
          ),

        ],
      )
     ;
}





  @override
  void initState() {
    super.initState();
    getUserInfo();


  }
  getUserInfo()async{
    setState(() {userInfo=Provider.of<FireProvider>(context,listen: false).myUserInfo;});
  }








}
