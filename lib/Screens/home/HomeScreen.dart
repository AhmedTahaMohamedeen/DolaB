// ignore_for_file: file_names, import_of_legacy_library_into_null_safe, avoid_debugPrint




import 'package:adminappp/Screens/Chat_screens/User/user_messages.dart';
import 'package:adminappp/Screens/User/user_profile/userProfile.dart';
import 'package:adminappp/Screens/home/home_app_bar.dart';
import 'package:adminappp/Screens/home/home_helper.dart';
import 'package:adminappp/Screens/search_Screens/StoresOnMap.dart';
import 'package:adminappp/Screens/testingBota.dart';
import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/MyIndicator.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/productInfo.dart';
import 'package:adminappp/constants/userInfo.dart';
import 'package:adminappp/providers/authProvider.dart';
import 'package:adminappp/providers/fireProvider.dart';
import 'package:blur/blur.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:provider/provider.dart';
// ignore: library_prefixes
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/Categories.dart';
import '../../constants/StoreDetails.dart';
import '../../constants/deviceInfo.dart';
import '../../constants/functions.dart';
import '../User/user_shopping_cart/ShoppingCart.dart';
import '../User/user_product_view/user_product_view.dart';



class Home extends StatefulWidget {
static const  route='/Home';

  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey _globalKey=GlobalKey();

  List<Product>?allProducts;
  List<Admin>?admins;


@override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAllProducts(context);
    getAllAdmins();
  }
  getAllAdmins()async{
    var admins1=await Admin().getAllAdmins();
  setState(() {
    admins=admins1;

  });
  }

  getAllProducts(context)async{
  var fire=Provider.of<FireProvider>(context,listen:false );

  if(fire.homeProducts.isEmpty){
    await fire.getMyHomeProducts();
    setState(() {

      allProducts= (fire.homeProducts);
      allProducts!.shuffle();
    });


  }
  else{
    await fire.getMyHomeProducts();
    setState(() {
      allProducts= fire.homeProducts;
      allProducts!.shuffle();
    });
  }


    }








  @override
  Widget build(BuildContext context) {

debugPrint('build');
    return

      Scaffold(
          backgroundColor:
          Theme.of(context).scaffoldBackgroundColor
       // Colors.white
        ,




          body:
          SafeArea(
            child: Stack(
              children:[

                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.grey.withOpacity(.2),


                ),



              if (admins==null||allProducts==null||admins!.isEmpty||allProducts!.isEmpty) Center(child: myShimmer(color: Theme.of(context).primaryColor),) else Positioned(
                left: 2,
                right: 2,
                top: 0,
                bottom: 0,
                child: InfoWidget(builder: (context, deviceInfo) {
                  double? screenHeight=deviceInfo.screenHeight;
                  double? screenWidth=deviceInfo.screenWidth;
                  if(deviceInfo.orientation==Orientation.landscape){
                    screenWidth=deviceInfo.screenHeight;
                    screenHeight=deviceInfo.screenWidth;
                  }



                  return CustomScrollView(

                    slivers: [


                      MyHomeAppBar(),



                      SliverList(
                          delegate:
                          SliverChildListDelegate.fixed(
                              [
                                SizedBox(height: 10,),

                                OffersPanel(list: myList,),
                              //  SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Panel(list: myListWomen,reverse:false ),
                                    Panel(list: myListMan,reverse:true ),
                                  ],
                                ),
                                SizedBox(height: 10,),



                              ]
                          )),











                      SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                              (context,index){
                            if(index==allProducts!.length-1){getAllProducts(context);}

                            return  HomeItem(product:allProducts![index], admin: admins!.firstWhere((e) =>e.adminId==allProducts![index].userId ),);},
                          childCount: allProducts!.length,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: deviceInfo.orientation==Orientation.landscape||deviceInfo.deviceType==DeviceType.Tablet?3: 2,
                          childAspectRatio:deviceInfo.orientation==Orientation.landscape||deviceInfo.deviceType==DeviceType.Tablet?1:.5,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 30,

                        ),

                      ),


                      SliverList(delegate:  SliverChildListDelegate.fixed(
                          [
                            myShimmer(color: Theme.of(context).primaryColor),

                            SizedBox(height: 100,)
                          ]
                      ) ),






                    ],
                  );
                },)
              ),



                MyFloating(key: _globalKey,myLoc1: myLoc.home
                  , floatingColor: Theme.of(context).floatingActionButtonTheme.backgroundColor

                  ,
                ),




              ],
            ),


          ),



      );
  }





}





