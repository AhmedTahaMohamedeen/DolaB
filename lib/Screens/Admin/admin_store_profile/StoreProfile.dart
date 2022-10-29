// ignore_for_file: file_names, avoid_debugPrint

import 'package:adminappp/Screens/Admin/admin_store_profile/admin_store_profile_helper.dart';
import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/Categories.dart';
import 'package:adminappp/constants/MyIndicator.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/deviceInfo.dart';
import 'package:adminappp/constants/productInfo.dart';
import 'package:adminappp/providers/fireProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class StoreProfileScreen extends StatefulWidget {
  static const String route = '/ProfileScreen';

  const StoreProfileScreen({Key? key}) : super(key: key);

  @override
  _StoreProfileScreenState createState() => _StoreProfileScreenState();
}

class _StoreProfileScreenState extends State<StoreProfileScreen> {
  GlobalKey _globalKey = GlobalKey();
  Admin? admin;
  List<Product> myProducts = [];
  List<String>? albumList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(context);
    getMyProducts(context);
  }

  getData(context) async {
    var myId = Provider.of<FireProvider>(context, listen: false).myId;
    var admin1 = await Admin().getAdminData(myId!);

    setState(() {
      admin = admin1;
      albumList = AllCategories()
          .allTypeCategoriesAll[admin!.storeType]![admin!.storeSex]!;
    });
  }

  getMyProducts(context) async {
    var fire = Provider.of<FireProvider>(context, listen: false);

    var myProducts1 = await Product().getMyProducts(fire.myId!);
    setState(() {
      myProducts = myProducts1;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor = Colors.black;
    Color floatingColor = backColor1;
    Color buttonColor = backColor1;
    Color PageNameColor = backColor1;
    Color messageColor = backColor1;

    Color iconsColor = Color(0xff592C1C);
    Color followButtonColor = Color(0xff8C5042);
    Color unFollowButtonColor = Color(0xff592C1C);

    if (admin == null) {
      return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: myShimmer(color: Theme.of(context).primaryColor));
    } else {
      if (admin!.storeSex == men) {
        _backgroundColor = menColor1.withOpacity(.6);
        PageNameColor = menColor2;
        // messageColor=menColor2;
        floatingColor = menColor1;
        buttonColor = menColor3;
        unFollowButtonColor = menColor1;
        followButtonColor = menColor3;
        iconsColor = menColor2;
      }
      else if (admin!.storeSex == women) {
        _backgroundColor = womenColor1.withOpacity(.2);
        PageNameColor = womenColor1.withOpacity(.5);
        // messageColor=womenColor2;
        floatingColor = womenColor1.withOpacity(.5);
        buttonColor = womenColor1;
        unFollowButtonColor = womenColor1.withOpacity(1);
        followButtonColor = womenColor1.withOpacity(.3);
        iconsColor = womenColor1.withOpacity(.5);
      }
      else {
        _backgroundColor = kidsColor.withOpacity(.1);
        PageNameColor = kidsColor;
        // messageColor=kidsColor.withOpacity(.5);
        floatingColor = kidsColor2;
        buttonColor = kidsColor;
        unFollowButtonColor = kidsColor.withOpacity(.2);
        followButtonColor = kidsColor.withOpacity(.5);
        iconsColor = kidsColor.withOpacity(.7);
      }

      return InfoWidget(builder: (context, deviceInfo) {
        double? screenHeight = deviceInfo.screenHeight;
        double? screenWidth = deviceInfo.screenWidth;
        if (deviceInfo.orientation == Orientation.landscape) {
          screenWidth = deviceInfo.screenHeight;
          screenHeight = deviceInfo.screenWidth;
        }

        return Scaffold(
          backgroundColor: _backgroundColor,

          body: Stack(

            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              CustomScrollView(
                slivers: [
///  _____ [MyAppBar]
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    floating: true,
                    toolbarHeight: 50,
                    primary: true,


                    leading: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        debugPrint('press');
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    elevation: 0,
                    actions: [
                      Orders(iconsColor: iconsColor), //orders
                      StoreMessagesIcon(iconsColor: iconsColor), //messages
                      StoreProfileIcon(admin: admin!), //profile
                    ],
                  ),


 ///  _____ [Cover & photo]       [Name & statistics & All,Albums]

                  SliverList(delegate: SliverChildListDelegate.fixed([


///  _____ [Cover & photo]
                    Stack(
                      children: [
                        Container(
                          height: screenHeight! * .31,
                          width: MediaQuery.of(context).size.width,
                        ),
                        _cover(screenHeight: screenHeight),
                        _circlePhoto(screenHeight: screenHeight),
                      ],
                    ),

///  _____ [Name & statistics & All,Albums]

                    SizedBox(height: screenHeight * .01,),
                    _name(),
                    SizedBox(height: screenHeight * .01,),
                    AdminStatistics(color: _backgroundColor,admin: admin!),
                    SizedBox(height: screenHeight * .05,),
                    _buttons(buttonColor: buttonColor),
                    SizedBox(height: screenHeight * .03,),
                  ])),





 ///  _____ [Cover & photo] ______


           SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return all
                                    ? MyStoreItem(product: myProducts[index],)
                                    : MyStoreAlbumsItem(myProducts: myProducts, category: AllCategories().allTypeCategoriesAll[admin!.storeType]![admin!.storeSex]![index],);
                              },


                              childCount: all
                                  ? myProducts.length
                                  : AllCategories().allTypeCategoriesAll[admin!.storeType]![admin!.storeSex]!.length,
                            ),
                            gridDelegate: deviceInfo.orientation ==
                                        Orientation.landscape ||
                                    deviceInfo.deviceType == DeviceType.Tablet
                                ? SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: all ? 5 : 4,
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 30,
                                    // mainAxisExtent: 400
                                  )
                                : SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: all ? 4 : 2,
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 30,
                                    // mainAxisExtent: 400
                                  ),
                          ),


                  SliverList(
                      delegate: SliverChildListDelegate.fixed([
                    SizedBox(
                      height: screenHeight * .05,
                    ),
                  ])), //name
                ],
              ),
              MyFloating(
                key: _globalKey,
                myLoc1: myLoc.StoreProfile,
                floatingColor: floatingColor,
              )
            ],
          ),
        );
      });
    }
  }

  bool all = false;
  bool album = true;

  _buttons({required Color buttonColor}) {
    return InfoWidget(builder: (context, deviceInfo) {
      double? localHeight = deviceInfo.localHeight;
      double? localWidth = deviceInfo.localWidth;
      double? screenHeight = deviceInfo.screenHeight;
      double? screenWidth = deviceInfo.screenWidth;
      if (deviceInfo.orientation == Orientation.landscape) {
        screenWidth = deviceInfo.screenHeight;
        screenHeight = deviceInfo.screenWidth;
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                all = true;
                album = false;
              });
            },
            borderRadius: BorderRadius.circular(10),
            child: Material(
              color: all
                  ? buttonColor.withOpacity(.4)
                  : buttonColor.withOpacity(.05),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              elevation: 2,
              type: MaterialType.button,
              child: SizedBox(
                height: screenHeight! * .06,
                width: screenWidth! * .4,
                child: Center(
                  child: Text(
                    'الكل',
                    style: TextStyle(
                        color:
                            all ? Colors.white : Colors.white.withOpacity(.5),
                        fontWeight: FontWeight.bold,
                        fontSize: screenHeight * .017),
                    // textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ), //all
          InkWell(
            onTap: () {
              setState(() {
                all = false;
                album = true;
              });
            },
            borderRadius: BorderRadius.circular(10),
            child: Material(
              color: album
                  ? buttonColor.withOpacity(.4)
                  : buttonColor.withOpacity(.05),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              elevation: 2,
              type: MaterialType.button,
              child: SizedBox(
                height: screenHeight * .06,
                width: screenWidth * .4,
                child: Center(
                  child: Text(
                    'ألبوم',
                    style: TextStyle(
                        color:
                            album ? Colors.white : Colors.white.withOpacity(.5),
                        fontWeight: FontWeight.bold,
                        fontSize: screenHeight * .017),
                    // textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ), //album
        ],
      );
    });
  }



  Widget _circlePhoto({required double screenHeight}) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(),
          admin!.photoUrl == null
              ? myShimmer(color: Theme.of(context).primaryColor)
              : Container(
                  width: screenHeight * .13,
                  height: screenHeight * .13,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(admin!.photoUrl!),
                          fit: BoxFit.fill)),
                ),
          SizedBox(),
        ],
      ),
    );
  }

  Widget _cover({required double screenHeight}) {
    return Container(
      height: screenHeight * .25,
      width: MediaQuery.of(context).size.width,
      child: admin!.photoUrlCover == null
          ? Container(
              color: Colors.white.withOpacity(0),
            )
          : Image(
              image: CachedNetworkImageProvider(admin!.photoUrlCover!),
              fit: BoxFit.fill,
            ),
    );
  }

  Widget _name(){
    if(admin!.name == null){ return myShimmer(color: Theme.of(context).primaryColor);}
    else{ return Text(
      admin!.name!,
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w700,

      ),
      textAlign: TextAlign.center,
    );}



  }
}
