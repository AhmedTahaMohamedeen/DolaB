// ignore_for_file: file_names, use_key_in_widget_constructors, avoid_debugdebugPrint

import 'dart:ui';

import 'package:adminappp/Screens/User/user_product_view/user_product_helper.dart';
import 'package:adminappp/constants/MyIndicator.dart';
import 'package:adminappp/helper_methods/helper_methods1.dart';

import 'package:adminappp/providers/fireProvider.dart';

import '../../../constants/deviceInfo.dart';
import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/productInfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductView extends StatefulWidget {
  static const String route = '/UserProductView';
  final Product product;
  final Admin admin;

  UserProductView({
    Key? key,
    required this.product,
    required this.admin,
  }) : super(key: key);

  @override
  _UserProductViewState createState() => _UserProductViewState();
}

class _UserProductViewState extends State<UserProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(children: [
          Positioned(
              left: 2,
              right: 2,
              top: 0,
              bottom: 0,
              child: InfoWidget(
                builder: (context, deviceInfo) {
                  print(deviceInfo.deviceType.toString());
                  print(deviceInfo.orientation.toString());
                  double? screenHeight = deviceInfo.screenHeight;
                  double? screenWidth = deviceInfo.screenWidth;
                  if (deviceInfo.orientation == Orientation.landscape) {
                    screenWidth = deviceInfo.screenHeight;
                    screenHeight = deviceInfo.screenWidth;
                  }

                  if (widget.admin.name == null && admin == null) {
                    return myShimmer(color: Theme.of(context).primaryColor);
                  } else {
                    return CustomScrollView(
                      slivers: [
                        product == null ? SliverAppBar() : UserProductViewAppBar(product: product!),


                        SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          sliver: SliverList(
                              delegate: SliverChildListDelegate.fixed([
                            SizedBox(
                                height: screenHeight! * .6,
                                width: screenWidth,
                                child: ProductImage(
                                  product: widget.product,
                                  localHeight: screenHeight * .6,
                                )),
                            SizedBox(height: screenHeight * .005,),
                            product == null || admin == null
                                ? Center(child: CircularProgressIndicator())
                                : Column(
                                    children: [
                                      SizedBox(
                                          width: screenWidth,
                                          height: screenHeight * .06,
                                          child: LikesAndChat(
                                            localHeight: screenHeight * .06,
                                            product: product!,
                                            admin: admin!,
                                            likes: likes,
                                          )), //likes

                                      SizedBox(
                                        height: screenHeight * .005,
                                      ),

                                      Container(
                                          height: screenHeight * .05,
                                          width: screenWidth,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),),
                                          child: PriceAndDate(localHeight: screenHeight * .05, product: product!, duration: duration)), //price&Date

                                      SizedBox(
                                        height: screenHeight * .005,
                                      ),

                                      Material(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                        elevation: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              PageName(
                                                  admin: admin!,
                                                  localHeight:
                                                      screenHeight * .07,
                                                  screenWidth: screenWidth!),
                                              SizedBox(
                                                height: screenHeight * .005,
                                              ),
                                              DetailsAndSizes(
                                                product: product!,
                                                screenHeight: screenHeight,
                                                screenWidth: screenWidth,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        height: screenHeight * .07,
                                      ),

                                      Container(
                                        child: Text(
                                          'المزيد من المنتجات',
                                          style: TextStyle(
                                              color:
                                                  Theme.of(context).cardColor),
                                        ),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          // color: Colors.white.withOpacity(.2)
                                        ),
                                      ), //more
                                    ],
                                  ),
                            SizedBox(
                              height: screenHeight * .04,
                            ),
                          ])),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          sliver: allProducts == null ||
                                  admins == null ||
                                  admins!.length == 0 ||
                                  allProducts!.length == 0
                              ? SliverGrid(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      return Center(
                                        child: myShimmer(
                                            color:
                                                Theme.of(context).primaryColor),
                                      );
                                    },
                                    childCount: 4,
                                  ),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: deviceInfo.orientation ==
                                            Orientation.landscape
                                        ? 4
                                        : 2,
                                    childAspectRatio: .5,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 1,
                                  ),
                                )
                              : SliverGrid(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      print('index=${index.toString()}');

                                      if (index == allProducts!.length - 1) {
                                        getAllProducts(context);
                                      }
                                      print(
                                          'allProductsLength=${allProducts!.length}');
                                      return ProductItem(
                                        product: allProducts![index],
                                        admin: Admin()
                                        //admins!.firstWhere((e) =>e.adminId==allProducts![index].userId )
                                        ,
                                      );
                                    },
                                    childCount: allProducts!.length,
                                  ),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: .7,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 15,
                                    // mainAxisExtent: 400
                                  ),
                                ),
                        )
                      ],
                    );
                  }
                },
              )),
          MyFloating(
            myLoc1: myLoc.none,
            //floatingColor: floatingColor
          )
        ]),
      ),
    );
  }

  Admin? admin;
  Product? product;
  List<Product>? allProducts;
  List<Admin>? admins;

  getAllAdmins() async {
    var admins1 = await Admin().getAllAdmins();
    setState(() {
      admins = admins1;
    });
  }

  getAllProducts(context) async {
    var fire = Provider.of<FireProvider>(context, listen: false);

    if (fire.homeProducts.isEmpty) {
      await fire.getMyHomeProducts();
      setState(() {
        allProducts = fire.homeProducts;
      });
    } else {
      await fire.getMyHomeProducts();
      setState(() {
        allProducts = fire.homeProducts;
      });
    }
  }

  int likes = 0;
  String duration = 'none';

  getAdminData() async {
    var admin1 = await Admin().getAdminData(widget.product.userId!);
    setState(() {
      admin = admin1;
    });
  }

  getProductInfo() async {
    var product1 =
        await Product().getProductInfo(productId: widget.product.productId!);
    setState(() {
      product = product1;
    });
    var myId = Provider.of<FireProvider>(context, listen: false).myId;
    await Product().addView(widget.product, myId!);

    int likes1 =
        await Product().likesNum(product1.productId!, product1.userId!);
    setState(() {
      likes = likes1;
      product = product1;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAdminData();
    getProductInfo();
    getAllProducts(context);
    getAllAdmins();
    duration = HelperMethods.getDuration(product: widget.product);
  }
}
