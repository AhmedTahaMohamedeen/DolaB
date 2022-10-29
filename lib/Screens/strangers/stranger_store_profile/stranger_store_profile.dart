// ignore_for_file: file_names, avoid_debugPrint

import 'package:adminappp/Screens/Chat_screens/User/User_chat.dart';

import 'package:adminappp/Screens/strangers/stranger_store_profile/stranger_store_profile_helper.dart';
import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/Categories.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/followInfo.dart';
import 'package:adminappp/constants/productInfo.dart';
import 'package:adminappp/providers/fireProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/MyIndicator.dart';
import '../../../constants/deviceInfo.dart';

class StrangerStore extends StatefulWidget {
  static const String route = '/StrangerStore';
  final Admin admin;

  const StrangerStore({Key? key, required this.admin}) : super(key: key);

  @override
  _StrangerStoreState createState() => _StrangerStoreState();
}

class _StrangerStoreState extends State<StrangerStore> {
  GlobalKey _globalKey = GlobalKey();
  Admin? admin = Admin();
  bool all = true;
  List<Product> storeProducts = [];

  addView() async {
    var myId = Provider.of<FireProvider>(context, listen: false).myId;
    await Admin().addViewer(admin: widget.admin, userId: myId!);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

    addView();
  }

  getData() async {
    var StoreProducts1 = await Product().getMyProducts(widget.admin.adminId!);

    setState(() {
      storeProducts = StoreProducts1;
      admin = widget.admin;
    });
  }

  @override
  Widget build(BuildContext context) {
    /* Color Color1=Color(0xff592C1C);
    Color Color2=Color(0xffF2B199);
    Color Color3=Color(0xff8C3F46);
    Color Color4=Color(0xff3C5659);
    Color Color5=Color(0xff8C5042);
    Color Color6=Color(0xffD98D30);
    Color Color7=Color(0xffA65221);
    Color Color8=Color(0xff9F3044);
    Color Color9=Color(0xff26110C);
    Color Color10=Color(0xffD9597B);
    Color Color11=Color(0xffD984BB);
    Color Color12=Color(0xffF2B5A7);
    Color Color13=Color(0xffF2600C);*/
    Color _backgroundColor = Colors.black;
    Color floatingColor = backColor1;
    Color buttonColor = backColor1;

    Color iconsColor = Color(0xff592C1C);
    Color followButtonColor = Color(0xff8C5042);
    Color unFollowButtonColor = Color(0xff592C1C);
    if (widget.admin.storeSex == 'رجالى') {
      _backgroundColor = menColor1;
      floatingColor = menColor2;
      buttonColor = menColor2;
      unFollowButtonColor = menColor2.withOpacity(.4);
      followButtonColor = menColor1;
      iconsColor = menColor2;
    } else if (widget.admin.storeSex == 'حريمى') {
      _backgroundColor = womenColor1.withOpacity(.2);
      floatingColor = womenColor2.withOpacity(.5);
      buttonColor = womenColor1.withOpacity(.5);
      unFollowButtonColor = womenColor1.withOpacity(.3);
      followButtonColor = womenColor1.withOpacity(.2);
      iconsColor = womenColor1.withOpacity(.5);
    } else {
      _backgroundColor = kidsColor.withOpacity(.1);
      floatingColor = kidsColor2;
      buttonColor = kidsColor.withOpacity(.2);
      unFollowButtonColor = kidsColor.withOpacity(.2);
      followButtonColor = kidsColor.withOpacity(.1);
      iconsColor = kidsColor.withOpacity(.8);
    }

    return Scaffold(
      backgroundColor: _backgroundColor,
      primary: false,
      body: InfoWidget(builder: (context, deviceInfo) {
        double? screenHeight = deviceInfo.screenHeight;
        double? screenWidth = deviceInfo.screenWidth;
        if (deviceInfo.orientation == Orientation.landscape) {
          screenWidth = deviceInfo.screenHeight;
          screenHeight = deviceInfo.screenWidth;
        }
        return Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),

            Positioned(
              //width:screenWidth ,
              // height: screenHeight,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    toolbarHeight: 40,
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
                  ),




                  SliverList(
                    delegate: SliverChildListDelegate.fixed(
                      [
                        StrangerStoreCoverAndDetails(
                          admin: widget.admin,
                          localHeight: screenHeight! * .275,
                          screenWidth: screenWidth!,
                          backgroundColor: _backgroundColor,
                          screenHeight: screenHeight,

                        ),
                        SizedBox(
                          height: 10,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            StrangerStoreFollow(
                                followButtonColor: followButtonColor,
                                unFollowButtonColor: unFollowButtonColor,
                                localHeight: screenHeight * .05,admin: widget.admin),
                            SizedBox(width: 10),
                            StrangerStoreLocationIcon(
                              followButtonColor: followButtonColor,
                              unFollowButtonColor: unFollowButtonColor,
                              localHeight: screenHeight * .05,admin: widget.admin,),
                            SizedBox(width: 10),
                            StrangerStoreMessageIcon(
                              followButtonColor: followButtonColor,
                              unFollowButtonColor: unFollowButtonColor,
                              localHeight: screenHeight * .05,
                              admin: widget.admin,
                            ),
                          ],
                        ),

                      ],
                    ),
                  ), //cover



                  SliverList(
                      delegate: SliverChildListDelegate.fixed([
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: screenHeight * .055,
                     padding: EdgeInsets.symmetric(horizontal: 30),
                      //color: Colors.white.withOpacity(.1),
                      child: Row(
                        children: [
                          _allButton(
                              buttonColor: buttonColor,
                              localHeight: screenHeight * .055),
                          _albumButton(
                              buttonColor: buttonColor,
                              localHeight: screenHeight * .055),
                        ],
                      ),
                    ),
                        SizedBox(height: 20,),
                  ])), //all  album
                  SliverList(
                      delegate: admin!.storeSex == kids && !all
                          ? SliverChildListDelegate.fixed([
                              SizedBox(height: 10),
                              Container(
                                height: screenHeight * .055,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(child: SizedBox()),
                                    _boysButton(
                                        buttonColor: buttonColor,
                                        localHeight: screenHeight * .055),
                                    _girlsButton(
                                        buttonColor: buttonColor,
                                        localHeight: screenHeight * .055),
                                    Expanded(child: SizedBox()),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                            ])
                          : SliverChildListDelegate.fixed([
                              SizedBox(),
                            ])),

                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    sliver: admin!.name == null
                        ? SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return myShimmer(
                                    color: Theme.of(context).primaryColor);
                              },
                              childCount: 4,
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: .5,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 30,
                              // mainAxisExtent: 400
                            ),
                          )
                        : mySliverGrid(deviceInfo: deviceInfo),
                  ),

                  SliverList(
                      delegate: SliverChildListDelegate.fixed([
                    SizedBox(
                      height: 40,
                    ),
                  ])),
                ],
              ),
            ),
            //  backButton(context),

            MyFloating(
              key: _globalKey,
              floatingColor: floatingColor,
              myLoc1: myLoc.none,
            )
          ],
        );
      }),
    );
  }

  bool isBoys = true;
  bool isGirls = false;

  SliverGrid mySliverGrid({required DeviceInfo deviceInfo}) {
    if (all) {
      return SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          return StrangerStoreItem(
            product: storeProducts[index],
            admin: admin!,
          );
        }, childCount: storeProducts.length),
        gridDelegate: deviceInfo.orientation == Orientation.landscape ||
                deviceInfo.deviceType == DeviceType.Tablet
            ? SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 30,
                // mainAxisExtent: 400
              )
            : SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: .8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 40,
                // mainAxisExtent: 400
              ),
      );
    }

    if (!all && admin!.storeSex != kids) {
      return SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return StrangerStoreAlbumsItem(
              admin: admin!,
              storeProducts: storeProducts,
              category: AllCategories().allTypeCategoriesAll[admin!.storeType]![
                  admin!.storeSex]![index],
            );
          },
          childCount: AllCategories()
              .allTypeCategoriesAll[admin!.storeType]![admin!.storeSex]!
              .length,
        ),
        gridDelegate: deviceInfo.orientation == Orientation.landscape ||
                deviceInfo.deviceType == DeviceType.Tablet
            ? SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 30,
                // mainAxisExtent: 400
              )
            : SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: .8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 40,
                // mainAxisExtent: 400
              ),
      );
    } else {
      return SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return StrangerStoreAlbumsItem(
              admin: admin!,
              storeProducts: isBoys
                  ? storeProducts
                      .where((product) => product.kidsSex == boys)
                      .toList()
                  : storeProducts
                      .where((product) => product.kidsSex == girls)
                      .toList(),
              category: isBoys
                  ? AllCategories()
                      .allTypeCategoriesAll[admin!.storeType]![boys]![index]
                  : AllCategories()
                      .allTypeCategoriesAll[admin!.storeType]![girls]![index],
            );
          },
          childCount: isBoys
              ? AllCategories()
                  .allTypeCategoriesAll[admin!.storeType]![boys]!
                  .length
              : AllCategories()
                  .allTypeCategoriesAll[admin!.storeType]![girls]!
                  .length,
        ),
        gridDelegate: deviceInfo.orientation == Orientation.landscape ||
                deviceInfo.deviceType == DeviceType.Tablet
            ? SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 30,
                // mainAxisExtent: 400
              )
            : SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: .8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 40,
                // mainAxisExtent: 400
              ),
      );
    }
  }




  Widget _allButton({required Color buttonColor, required double localHeight}) {
    return Expanded(
      child: Material(
        elevation: 2,
        color: Colors.white.withOpacity(0),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft:  Radius.circular(20),


        ),
        child: InkWell(
            onTap: () {
              setState(() {
                all = true;
              });
            },
            child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.elasticOut,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft:  Radius.circular(20),


                  ),
                  color: all ? buttonColor : Colors.white.withOpacity(0),
                ),
                child: Text(
                  'الكل',
                  style: TextStyle(
                      color: Colors.white, fontSize: localHeight * .3),
                ))),
      ),
    );
  }

  Widget _albumButton(
      {required Color buttonColor, required double localHeight}) {
    return Expanded(
      child: Material(
        color: Colors.white.withOpacity(0),
        elevation: 2,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight:  Radius.circular(20),
        ),
        child: InkWell(
            onTap: () {
              setState(() {
                all = false;
              });
            },
            child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.elasticInOut,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight:  Radius.circular(20),
                  ),
                  color: !all ? buttonColor : Colors.white.withOpacity(0),
                ),
                child: Text(
                  'ألبوم',
                  style: TextStyle(
                      color: Colors.white, fontSize: localHeight * .3),
                ))),
      ),
    );
  }

  Widget _boysButton(
      {required Color buttonColor, required double localHeight}) {
    return Expanded(
      child: Material(
        elevation: 1,
        color: Colors.white.withOpacity(0),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30), topLeft: Radius.circular(30)),
        child: InkWell(
            onTap: () {
              setState(() {
                isBoys = true;
                isGirls = false;
              });
            },
            child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.elasticOut,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                  color: isBoys ? buttonColor : Colors.white.withOpacity(0),
                ),
                child: Text(
                  'أولاد',
                  style: TextStyle(
                      color: Colors.white, fontSize: localHeight * .3),
                ))),
      ),
    );
  }

  Widget _girlsButton(
      {required Color buttonColor, required double localHeight}) {
    return Expanded(
      child: Material(
        color: Colors.white.withOpacity(.005),
        elevation: 1,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
        child: InkWell(
            onTap: () {
              setState(() {
                isBoys = false;
                isGirls = true;
              });
            },
            child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.elasticInOut,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  color: isGirls ? buttonColor : Colors.white.withOpacity(0),
                ),
                child: Text(
                  'بنات',
                  style: TextStyle(
                      color: Colors.white, fontSize: localHeight * .3),
                ))),
      ),
    );
  }
}
