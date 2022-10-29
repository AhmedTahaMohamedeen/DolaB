

import 'dart:async';

import 'package:adminappp/Screens/Admin/admin_order/admin_order_helper.dart';
import 'package:adminappp/Screens/User/user_order/userOrders.dart';
import 'package:adminappp/constants/MyIndicator.dart';
import 'package:adminappp/constants/Order.dart';
import 'package:blur/blur.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


///  (1)______[UserOrderItem]
///  (2)______[getStatus]
///  (3)______[UserOrderDialog]
///  (4)______[ChangeOrderLocation]




class UserOrderItem extends StatefulWidget {
  final Order order;

  const UserOrderItem({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  _UserOrderItemState createState() => _UserOrderItemState();
}

class _UserOrderItemState extends State<UserOrderItem> {
  Order? order;

  getOrder() async {
    var order1 = await Order().getOrderInfo(orderId: widget.order.orderId!);
    setState(() {
      order = order1;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrder();
  }

  @override
  Widget build(BuildContext context) {
    if (order == null) {
      return myShimmer(
        color: Theme.of(context).primaryColor,
      );
    } else {
      return InkWell(
        onTap: () async {},
        child: Stack(children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Material(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).cardColor,
              elevation: 1,
              child: SizedBox(),
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 100,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(widget.order.photoUrl!),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ), //image

          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              color: Colors.black.withOpacity(0),
              height: 100,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('L.E',
                          style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
                              fontSize: 10)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: Text(
                          widget.order.price.toString(),
                          style:
                          TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          ':السعر ',
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark),
                        ),
                      ),
                    ],
                  ), //السعر
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          getStatus(order: order!),
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: 10),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          ':حاله الطلب ',
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark),
                        ),
                      ),
                    ],
                  ), //حاله الطلب

                  //  _userOrderActions(order: order!)
                  InkWell(
                    onTap: () async {
                      await getOrder();
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: UserOrderDialog(
                            order: order!,
                          ),
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                        ),

                      );
                    },
                    child: Text(
                      'التفاصيل',
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
            ),
          ),
          order!.whoCancelOrder == null
              ? Positioned(
            left: 0,
            top: 0,
            child: InkWell(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(

                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(' هل تريد الغاء الطلب؟'),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () async {
                                  await Order()
                                      .userCancelOrder(order: order!);
                                  Navigator.pop(context);
                                  getOrder();
                                },
                                child: Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius:
                                      BorderRadius.circular(20)),
                                  child: Text('إلغاء الطلب'),
                                  alignment: Alignment.center,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(.5),
                                      borderRadius:
                                      BorderRadius.circular(20)),
                                  child: Text('رجوع'),
                                  alignment: Alignment.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ),
                );
              },
              child: Material(
                color: Theme.of(context).cardColor,
                elevation: 1,
                shadowColor: Theme.of(context).primaryColorDark,
                child: Icon(
                  Icons.close,
                  size: 20,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),
          ) //cancelOrder

              : SizedBox()
        ]),
      );
    }
  }



}

String getStatus({required Order order}) {
  String status = 'جارى التحميل';
  if (order.status == orderStatus.newOrder.toString()) {
    status = 'طلب جديد';
  }
  if (order.status == orderStatus.adminAccept.toString()) {
    status = 'تم التأكيد';
  }
  if (order.status == orderStatus.adminRefuse.toString()) {
    status = 'المنتج غير متاح';
  }
  if (order.status ==
      orderStatus.DeliveryManReceivedOrderFromAdmin.toString()) {
    status = 'تم التسليم الى الطيار';
  }
  if (order.status == orderStatus.adminGiveOrderToDeliveryMan.toString()) {
    status = '...جارى التوصيل';
  }
  if (order.status == orderStatus.DeliveryManHasArrived.toString()) {
    status = 'الطيار وصل';
  }
  if (order.status == orderStatus.UserReceivedOrder.toString()) {
    status = 'تم التوصيل';
  }
  if (order.status == orderStatus.DeliveryManDeliveredOrderToUser.toString()) {
    status = 'قيد الانتهاء';
  }
  if (order.status == orderStatus.userRefuseOrder.toString()) {
    status = 'تم رفض الاستلام';
  }
  if (order.status == orderStatus.cancelOrder.toString()) {
    if (order.whoCancelOrder == 'user') {
      status = 'العميل قام بإلغاء الطلب';
    }
    if (order.whoCancelOrder == 'admin') {
      status = 'صاحب المحل قام بإلغاء الطلب';
    }
    if (order.whoCancelOrder == 'delivery') {
      status = 'الطيار قام بإلغاء الطلب';
    }
  }

  return status;
}



class UserOrderDialog extends StatefulWidget {
  final Order order;

  UserOrderDialog({Key? key, required this.order}) : super(key: key);

  @override
  _UserOrderDialogState createState() => _UserOrderDialogState();
}

class _UserOrderDialogState extends State<UserOrderDialog> {
  Order? order;

  getOrder() async {
    var order1 = await Order().getOrderInfo(orderId: widget.order.orderId!);
    setState(() {
      order = order1;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrder();
  }

  @override
  Widget build(BuildContext context) {
    if (order == null) {
      return myShimmer(color: Theme.of(context).primaryColor);
    } else {
      return Container(

        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10)
        ),
        child: SingleChildScrollView(

          child: Column(
            children: [
              Material(
                color: Theme.of(context).primaryColor,
                elevation: 0,

                borderRadius: BorderRadius.only(
                    topLeft:Radius.circular(10) ,
                    topRight:Radius.circular(10)
                ),
                child: SizedBox(
                  height: 30,
                  child: Center(
                    child: Text('تفاصيل الطلب',style: TextStyle(color: Theme.of(context).cardColor),),
                  ),
                ),

              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: OrderDetails(order:order!),
              ),

              _userOrderActions(order: order!),
              Divider(
                  height: 5,
                  color: Theme.of(context).cardColor,
                  thickness: .5),
            ],
          ),
        ),
      );
    }
  }

  Widget _userOrderActions({required Order order}) {
    /* if(order.status==orderStatus.adminGiveOrderToDeliveryMan.toString()){

      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal:  3.0),
              child:

              Text('${order.deliveryTime?.toDate().year}-${order.deliveryTime?.toDate().month}-${order.deliveryTime?.toDate().day} ', style: TextStyle(fontSize: 12,color: Colors.white))
          ),

          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(': وقت التسليم ',style: TextStyle(color: Colors.white),),
          ),

        ],
      );
    }//deliveryMan*/
    /*if(order.status==orderStatus.DeliveryManReceivedOrderFromAdmin.toString()){


      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal:  3.0),
              child:

              Text('${order.deliveryTime?.toDate().year}-${order.deliveryTime?.toDate().month}-${order.deliveryTime?.toDate().day} ', style: TextStyle(fontSize: 12,color: Colors.white))
          ),

          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(': وقت التسليم ',style: TextStyle(color: Colors.white),),
          ),

        ],
      );
    }//deliveryMan*/

    if (order.status == orderStatus.DeliveryManDeliveredOrderToUser.toString()) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () async {
              if (await Order().userReceivedOrder(order: order)) {
                print('delivered');
                getOrder();
                // Navigator.popAndPushNamed(context, AdminOrders.route);

              }
            },
            child: Container(
              width: 50,
              height: 30,
              child: Text(
                'إستلام',
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(20)),
              alignment: Alignment.center,
            ),
          ),
          InkWell(
            onTap: () async {
              if (await Order().userRefuseOrder(order: order)) {
                print('refuse');
                getOrder();
                // Navigator.popAndPushNamed(context, AdminOrders.route);

              }
            },
            child: Container(
              width: 50,
              height: 30,
              child: Text(
                'رفض',
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(20)),
              alignment: Alignment.center,
            ),
          ),
        ],
      );
    } //user

    if (order.status == orderStatus.UserReceivedOrder.toString()) {
      return Container(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.done_all,
              color: Colors.green,
            ),
            Icon(
              Icons.done_all,
              color: Colors.green,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                ' تم التسليم ',
                style: TextStyle(color: Theme.of(context).primaryColorDark),
              ),
            ),
          ],
        ),
      );
    }
    if (order.status == orderStatus.userRefuseOrder.toString()) {
      return Container(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.close,
              color: Colors.red,
            ),
            Icon(
              Icons.close,
              color: Colors.red,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                ' تم الرفض ',
                style: TextStyle(color: Theme.of(context).primaryColorDark),
              ),
            ),
          ],
        ),
      );
    }
    if (order.status == orderStatus.cancelOrder.toString()) {
      return Container(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.close,
              color: Colors.red,
            ),
            Icon(
              Icons.close,
              color: Colors.red,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                getStatus(order: order),
                style: TextStyle(color: Theme.of(context).primaryColorDark),
              ),
            ),
          ],
        ),
      );
    } else {
      return SizedBox();
    }
  }
}

class ChangeOrderLocation extends StatefulWidget {
  final LatLng latLng;
  final String orderId;

  const ChangeOrderLocation(
      {Key? key, required this.latLng, required this.orderId})
      : super(key: key);

  @override
  _ChangeOrderLocationState createState() => _ChangeOrderLocationState();
}

class _ChangeOrderLocationState extends State<ChangeOrderLocation> {
  Completer<GoogleMapController> _controller = Completer();

  LatLng myLatLng = LatLng(0, 0);

  bool locChanged = false;

  initialLatLng() {
    setState(() {
      myLatLng = widget.latLng;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialLatLng();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
          locChanged = true;
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
            boxShadow: [
              BoxShadow(color: Colors.white.withOpacity(0.3), blurRadius: 1)
            ],
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
                    '  قم بتحديد موقع متجرك ',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Text(
                    '  بواسطه النقر على  موقع المتجر على الخريطه',
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
          onTap: () async {
            if (locChanged) {
              await Order().userChangeOrderLocation(
                  orderId: widget.orderId,
                  lat: myLatLng.latitude,
                  long: myLatLng.longitude)
                  ? Navigator.pushNamed(context, UserOrders.route)
                  : print('changeLocationError');
            } else {
              Navigator.pop(context);
            }
          },
          child: Container(
              alignment: Alignment.center,
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor ,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'حفظ',
                style: TextStyle(color: Theme.of(context).cardColor),
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
            Navigator.pop(context);
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
                style: TextStyle(color: Theme.of(context).cardColor),
              )),
        ),
      ),
    );
  }
}