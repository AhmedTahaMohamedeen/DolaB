

import 'dart:async';
import 'dart:math';

import 'package:adminappp/Screens/User/user_order/userOrders.dart';
import 'package:adminappp/Screens/User/user_shopping_cart/ShoppingCart.dart';
import 'package:adminappp/constants/MyIndicator.dart';
import 'package:adminappp/constants/My_Flush.dart';
import 'package:adminappp/constants/Order.dart';
import 'package:adminappp/constants/productInfo.dart';
import 'package:adminappp/constants/userInfo.dart';
import 'package:adminappp/providers/fireProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class ShoppingCartItem extends StatefulWidget {
  final Product product;

  const ShoppingCartItem({Key? key, required this.product}) : super(key: key);

  @override
  _ShoppingCartItemState createState() => _ShoppingCartItemState();
}

class _ShoppingCartItemState extends State<ShoppingCartItem> {

  var count = 0;

  List<String> images = [];

  getImages() {
    List<String> images1 = [];
    images1.add(widget.product.imageUrl!);
    if (widget.product.imageUrl1 != 'none') {
      images1.add(widget.product.imageUrl1!);
    }
    if (widget.product.imageUrl2 != 'none') {
      images1.add(widget.product.imageUrl2!);
    }
    if (widget.product.imageUrl3 != 'none') {
      images1.add(widget.product.imageUrl3!);
    }
    if (widget.product.imageUrl4 != 'none') {
      images1.add(widget.product.imageUrl4!);
    }
    setState(() {
      images = images1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        MyIndicator().loading(context);
        Navigator.pop(context);
        // Navigator.push(context, MaterialPageRoute(builder: (context) => UserProductView(product:widget.product, ),));
      },
      child: Material(
        color: Theme.of(context).cardColor,
        elevation: 1,
        borderRadius: BorderRadius.circular(10),

        child: Stack(children: [


          Positioned(
            top:50,
            bottom: 50,
            left: 0,right: 0,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(widget.product.imageUrl!),
                    fit: BoxFit.contain,
                  )),
            ),
          ), //image
          Positioned(
            top: 10,
            right: 10,
            child: InkWell(
                onTap: () async {
                  var myId =
                      Provider.of<FireProvider>(context, listen: false).myId;
                  if (await Product().deleteShoppingCartProduct(
                      productId: widget.product.productId!, uid: myId!)) {
                    MyFlush().showFlush(context: context, text: 'تم الحذف');
                    Navigator.pushNamed(context, UserShoppingCart.route);
                  }
                },
                child: Material(
                  color:Theme.of(context).cardColor ,
                  elevation: 1000,
                  borderRadius: BorderRadius.circular(5),
                  shadowColor: Theme.of(context).primaryColor,
                  child: Icon(
                    Icons.close_sharp,
                    color: Theme.of(context).primaryColor,
                  ),
                )),
          ),

          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              color: Colors.black.withOpacity(0),
              height: 50,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Material(
                          color: Theme.of(context).cardColor,
                          elevation: 2,
                          shadowColor: Theme.of(context).primaryColorDark,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Text(
                                  widget.product.price.toString(),
                                  style: TextStyle(fontSize: 14,color: Theme.of(context).primaryColor,fontWeight: FontWeight.w700),
                                )




                              ],
                            ),
                          ),
                        ), //price
                        MaterialButton(
                          onPressed: () async {
                            getImages();
                            print(images.length);
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                backgroundColor:  Theme.of(context).cardColor,
                                elevation: 1,
                                child: MakeOrder(
                                  images: images,
                                  product: widget.product,
                                ),
                              ),
                            );
                          },



                          color: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.delivery_dining,color: Theme.of(context).cardColor,  ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    'أطلب الأن',
                                    style: TextStyle(fontSize: 10,color: Theme.of(context).cardColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class MakeOrder extends StatefulWidget {
  final List<String> images;
  final Product product;

  MakeOrder({Key? key, required this.images, required this.product})
      : super(key: key);

  @override
  _MakeOrderState createState() => _MakeOrderState();
}

class _MakeOrderState extends State<MakeOrder> {
  int? selectedSizeIndex;
  String? selectedSize;

  int? selectedImageIndex;
  String? selectedImage;
  int? selectedQuantity = 1;
  List<int> quantityList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  UserInfoo? userInfo;
  LatLng orderLatLng = LatLng(0, 0);
  bool personalLocationAdded = false;
  bool mapLocationAdded = false;

  getUserInfo() async {
    // var uid = Provider.of<AuthProvider>(context, listen: false).user!.uid;
    var fire=Provider.of<FireProvider>(context,listen:false );

    // var userInfoo1 = await UserInfoo().getUserInfo(uid);
    var userInfoo1 = await UserInfoo().getUserInfo(fire.myId!);
    setState(() {
      userInfo = userInfoo1;
    });
  }

  choosePhoto() {
    if (widget.images.length == 1) {
      setState(() {
        selectedImage = widget.images[0];
        selectedImageIndex = 0;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
    choosePhoto();
  }

  @override
  Widget build(BuildContext context) {
    return userInfo == null
        ? Container()
        : SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(  ),
        child: Column(
          children: [
            Material(
              color: Theme.of(context).primaryColor,
              shadowColor: Theme.of(context).primaryColor,
              elevation: 1000,
              child: SizedBox(
                height: 50,
                width:600,
                child: Center(child: Text('طلب',style: TextStyle(color: Theme.of(context).cardColor,fontWeight: FontWeight.w900,fontSize: 16))),
              ),
            ),
            Container(
              //width: 300,
              height: 200,
              decoration: BoxDecoration(color: Theme.of(context).primaryColorLight.withOpacity(.2)),
              child: widget.images.length == 0
                  ? Container()
                  : GridView.builder(
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    setState(() {
                      selectedImageIndex = index;
                      selectedImage = widget.images[index];
                    });
                  },
                  child: Container(
                    // width: 100,
                    // height: 100,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 5,
                          color: index == selectedImageIndex
                              ?  Theme.of(context).primaryColor
                              : Colors.white.withOpacity(0),
                        ),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              widget.images[index],
                              scale: 1),
                          fit: BoxFit.contain,
                        )),
                  ),
                ),
                itemCount: widget.images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                  // widget.images.length>2?3:widget.images.length
                  3,
                  mainAxisExtent: 100,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Theme.of(context).primaryColorLight.withOpacity(.2)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        setState(() {
                          selectedSizeIndex = index;
                          selectedSize = widget.product.sizes![index];
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Container(
                          width: 50,
                          height: 50,
                          transformAlignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: index == selectedSizeIndex
                                  ? Theme.of(context).primaryColorDark
                                  : Theme.of(context).primaryColorLight,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text('${widget.product.sizes![index]}',style: TextStyle(color: Theme.of(context).cardColor,fontSize: 10)),
                          alignment: Alignment.center,
                        ),
                      )),
                  itemCount: widget.product.sizes!.length,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(

              decoration: BoxDecoration(color: Theme.of(context).primaryColorLight.withOpacity(.2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15, left: 10),
                    child: DropdownButton(
                      items: quantityList
                          .map((e) => DropdownMenuItem(
                        child: Text(e.toString()),
                        value: e,
                      ))
                          .toList(),
                      onChanged: (v) {
                        setState(() {
                          selectedQuantity = int.parse(v.toString());
                        });
                      },
                      value: selectedQuantity,
                      style: TextStyle(
                          color:  Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      dropdownColor:  Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                      iconEnabledColor:  Theme.of(context).primaryColorDark,
                      elevation: 20,
                      focusColor:  Theme.of(context).primaryColorDark,
                      underline: SizedBox(),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      'الكميه',style: TextStyle(color: Theme.of(context).primaryColorDark),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  userInfo == null ? Text('') : Text('${userInfo!.name}',style: TextStyle(color: Theme.of(context).primaryColorDark)),
                  Text(' :   الاسم',style: TextStyle(color: Theme.of(context).primaryColorDark)),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  userInfo == null ? Text('') : Text('${userInfo!.phone}',style: TextStyle(color: Theme.of(context).primaryColorDark)),
                  Text(' :   رقم الموبايل',style: TextStyle(color: Theme.of(context).primaryColorDark)),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    locationPress(context);
                  },
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor

                    ),
                    child: mapLocationAdded
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.radio_button_checked_sharp,
                          color: Theme.of(context).cardColor,
                          size: 20,
                        ),
                        Text(
                          'تمت إضافه العنون عى الخريطه  ',
                          style: TextStyle(
                              color:Theme.of(context).cardColor, fontSize: 10),
                        ),
                      ],
                    )
                        : Row(
                      children: [
                        Icon(
                          Icons.circle_outlined,
                          color: Theme.of(context).cardColor,
                          size: 20,
                        ),
                        Text(
                          'تحديد العنوان على الخريطه',
                          style:
                          TextStyle(color: Theme.of(context).cardColor, fontSize: 10),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                  ),
                ), //mapAddress
                InkWell(
                  onTap: () async {
                    setState(() {
                      orderLatLng = LatLng(userInfo!.lat!, userInfo!.long!);
                      personalLocationAdded = true;
                      mapLocationAdded = false;
                    });
                    print(orderLatLng.toString());
                  },
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor),
                    child: personalLocationAdded
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.radio_button_checked_sharp,
                          color: Theme.of(context).cardColor,
                          size: 20,
                        ),
                        Text(
                          'تمت إضافه العنون الشخصى  ',
                          style: TextStyle(
                              color: Theme.of(context).cardColor, fontSize: 10),
                        ),
                      ],
                    )
                        : Row(
                      children: [
                        Icon(
                          Icons.circle_outlined,
                          color: Theme.of(context).cardColor,
                          size: 20,
                        ),
                        Text(
                          'إضافه العنوان الشخصى',
                          style:
                          TextStyle(color: Theme.of(context).cardColor, fontSize: 10),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                  ),
                ), //personalAddress
              ],
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                if (selectedImage == null) {
                  MyFlush().showFlush(
                      context: context, text: 'اختر صوره الطلب من فضلك');
                  return;
                }
                if (selectedSize == null) {
                  MyFlush().showFlush(
                      context: context, text: 'اختر المقاس  من فضلك');
                  return;
                }
                if (orderLatLng == LatLng(0, 0)) {
                  MyFlush().showFlush(
                      context: context, text: 'اختر العنوان  من فضلك');
                  return;
                }
                var uid = Provider.of<FireProvider>(context, listen: false).myId;
                int ranId = Random().nextInt(1000000);
                if (await Order().addOrder(
                    order: Order(
                        adminId: widget.product.userId,
                        userId: uid,
                        status: orderStatus.newOrder.toString(),
                        long: orderLatLng.longitude,
                        lat: orderLatLng.latitude,
                        productID: widget.product.productId,
                        orderId: ranId.toString(),
                        orderTime: Timestamp.now(),
                        price: widget.product.price,
                        name: userInfo!.name,
                        phone: userInfo!.phone,
                        size: selectedSize,
                        photoUrl: selectedImage,
                        quantity: selectedQuantity,
                        receivedTime: null,
                        deliveryTime: null,
                        acceptationTime: null,
                        whoCancelOrder: null
                      //orderDeleted:false,

                    ))) {
                  print('order added');
                  Navigator.pushNamed(context, UserOrders.route);
                } else {
                  print('خطأ');
                }
              },
              child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColorDark),
                alignment: Alignment.center,
                child: Text('طلب الان',style: TextStyle(color: Theme.of(context).cardColor),),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  locationPress(BuildContext context) async {
    // MyFlush().showFlush(context: context, text: 'loading');
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        Navigator.pop(context);
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        Navigator.pop(context);
        return;
      }
    }

    _locationData = await location.getLocation();
    debugPrint(_locationData.toString());
    LatLng latLng1 = LatLng(_locationData.latitude!, _locationData.longitude!);

    await getStoreLocation(
        backLatLng: await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateOrderLocation(latLng: latLng1))));

    debugPrint(orderLatLng.longitude.toString());
  }

  getStoreLocation({required LatLng backLatLng}) async {
    setState(() {
      orderLatLng = backLatLng;
      if (backLatLng.longitude == 0) {
        setState(() {
          mapLocationAdded = false;
        });
      } else {
        setState(() {
          mapLocationAdded = true;
          personalLocationAdded = false;
        });
      }
      print(orderLatLng.toString());
    });
    //30.5926082, 31.5227502
    //30.62816316031992, 31.511389799416065
  }
}

class CreateOrderLocation extends StatefulWidget {
  final LatLng latLng;

  const CreateOrderLocation({Key? key, required this.latLng}) : super(key: key);

  @override
  _CreateOrderLocationState createState() => _CreateOrderLocationState();
}

class _CreateOrderLocationState extends State<CreateOrderLocation> {
  Completer<GoogleMapController> _controller = Completer();

  LatLng myLatLng = LatLng(0, 0);

  initialLatLng() {
    setState(() {
      myLatLng = widget.latLng;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(


      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Container(
                child: Stack(
                  children: [myMap(), myNotice()],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [saveButton(), closeButton()],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget myMap() {
    return GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: CameraPosition(
        target: widget.latLng,
        zoom: 18.4746,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      onTap: (L) {
        setState(() {
          myLatLng = L;
        });
      },
      markers: [
        Marker(
          markerId: MarkerId('m'),
          position: myLatLng,
        )
      ].toSet(),
    );
  }

  Widget myNotice() {
    return Positioned(
      top: 20,
      left: 20,
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width * .8,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColorDark.withOpacity(.8),

            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ملاحظه', style: TextStyle(color: Colors.white)),
                Icon(
                  Icons.info,
                  color: Colors.white,
                  size: 20,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                children: [
                  Text(
                    '  قم بتحديد مكان التوصيل ',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Text(
                    '  بواسطه النقر على  مكان التوصيل على الخريطه',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget saveButton() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            if (myLatLng.longitude != 0) {
              Navigator.pop(context, myLatLng);
            } else {
              MyFlush().showFlush(
                  context: context, text: 'قم بالنقر على موقع متجرك');
            }
          },
          child: Container(
              alignment: Alignment.center,
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'حفظ',
                style: TextStyle(color: Colors.white),
              )),
        ),
      ),
    );
  }

  Widget closeButton() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.pop(context, myLatLng);
          },
          child: Container(
              alignment: Alignment.center,
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'إغلاق',
                style: TextStyle(color: Colors.white),
              )),
        ),
      ),
    );
  }
}