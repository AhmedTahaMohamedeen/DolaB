import 'package:adminappp/Screens/User/user_order/user_order_helper.dart';
import 'package:adminappp/constants/MyIndicator.dart';
import 'package:adminappp/constants/Order.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/providers/fireProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryScreen extends StatefulWidget {
  static const String route = '/DeliveryScreen';

  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  _DeliveryScreenState createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  List<Order> AdminOrders = [];

  getAdminOrders() async {
    var adminId = Provider.of<FireProvider>(context, listen: false).myId;
    var orders1 = await Order().adminGetOrders(adminId: adminId!);
    setState(() {
      AdminOrders = orders1;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAdminOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Delivery'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  print(index);
                  return DeliveryOrderItem(
                    order: AdminOrders[index],
                  );
                },
                childCount: AdminOrders.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeliveryOrderItem extends StatefulWidget {
  final Order order;

  const DeliveryOrderItem({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  _DeliveryOrderItemState createState() => _DeliveryOrderItemState();
}

class _DeliveryOrderItemState extends State<DeliveryOrderItem> {
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
    if (order != null) {
      return InkWell(
        onTap: () async {},
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10)
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 200,
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
              height: 200,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: Text(
                          widget.order.quantity.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          ':العدد ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ), //العدد
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: Text(
                          widget.order.size!,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          ':المقاس ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ), //المقاس
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('L.E',
                          style: TextStyle(color: Colors.white, fontSize: 10)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: Text(
                          widget.order.price.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          ':السعر ',
                          style: TextStyle(color: Colors.white),
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
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          ':حاله الطلب ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ), //حاله الطلب
                  DeliveryOrderActions(order: order!)
                ],
              ),
            ),
          ),
        ]),
      );
    } else {
      return myShimmer(color: Theme.of(context).primaryColor);
    }
  }

  Widget DeliveryOrderActions({required Order order}) {
    var deliveryDay;
    getDeliveryDay() {
      if (order.deliveryTime?.toDate().day == DateTime.now().day) {
        setState(() {
          deliveryDay = 'اليوم';
        });
      }
      if (order.deliveryTime?.toDate().compareTo(DateTime.now()) == 1) {
        setState(() {
          deliveryDay = 'غداََ';
        });
      } else {
        setState(() {
          deliveryDay =
              '${order.deliveryTime?.toDate().year}-${order.deliveryTime?.toDate().month}-${order.deliveryTime?.toDate().day} ';
        });
      }
    }

    if (order.status == orderStatus.adminRefuse.toString()) {
      getDeliveryDay();

      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Text('المنتج غير متاح',
                  style: TextStyle(fontSize: 12, color: Colors.white))),
        ],
      );
    } //admin
    if (order.status == orderStatus.adminAccept.toString()) {
      getDeliveryDay();

      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Text(deliveryDay,
                  style: TextStyle(fontSize: 12, color: Colors.white))),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              ': وقت التسليم ',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    } //admin
    if (order.status == orderStatus.adminGiveOrderToDeliveryMan.toString()) {
      getDeliveryDay();

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Text(deliveryDay,
                      style: TextStyle(fontSize: 12, color: Colors.white))),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  ': وقت التسليم ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () async {
              if (await Order()
                  .deliveryManReceivedOrderFromAdmin(order: order)) {
                print('تم استلام الطلب من المحل');
                getOrder();
                // Navigator.popAndPushNamed(context, AdminOrders.route);

              }
            },
            child: Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).primaryColorDark,
              ),
              child: Text(
                'استلمت الطلب من المحل',
                style: TextStyle(fontSize: 10,color: Theme.of(context).cardColor),
              ),
              alignment: Alignment.center,
            ),
          )
        ],
      );
    } //deliveryMan
    if (order.status ==
        orderStatus.DeliveryManReceivedOrderFromAdmin.toString()) {
      getDeliveryDay();

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Text(deliveryDay,
                      style: TextStyle(fontSize: 12, color: Colors.white))),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  ': وقت التسليم ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () async {
              if (await Order().deliveryManHasArrived(order: order)) {
                print('الطيار وصل');
                getOrder();
                // Navigator.popAndPushNamed(context, AdminOrders.route);

              }
            },
            child: Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).primaryColorDark,
              ),
              child: Text(
                'الطيار وصل العنوان',
                style: TextStyle(fontSize: 10,color: Theme.of(context).cardColor),
              ),
              alignment: Alignment.center,
            ),
          )
        ],
      );
    } //deliveryMan
    if (order.status == orderStatus.DeliveryManHasArrived.toString()) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Text(
                      '${order.deliveryTime?.toDate().year}-${order.deliveryTime?.toDate().month}-${order.deliveryTime?.toDate().day} ',
                      style: TextStyle(fontSize: 12, color: Colors.white))),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  ': وقت التسليم ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () async {
              if (await Order().deliveryManDeliveredOrderToUser(order: order)) {
                print('delivered');
                getOrder();
                // Navigator.popAndPushNamed(context, AdminOrders.route);

              }
            },
            child: Container(
              width: 100,
              height: 30,
              child: Text(
                'تم تسليم الطلب',
                style: TextStyle(fontSize: 10, color: Theme.of(context).cardColor),
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.circular(20)),
              alignment: Alignment.center,
            ),
          )
        ],
      );
    } //DeliveryMan

    if (order.status == orderStatus.UserReceivedOrder.toString()) {
      getDeliveryDay();
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Text(
                      '${order.receivedTime?.toDate().hour}:${order.receivedTime?.toDate().minute}  ${order.receivedTime?.toDate().year}-${order.receivedTime?.toDate().month}-${order.receivedTime?.toDate().day}',
                      style: TextStyle(fontSize: 12, color: Colors.white))),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  ': تم التسليم ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          Container(
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
              ],
            ),
          )
        ],
      );
    }
    if (order.status == orderStatus.userRefuseOrder.toString()) {
      getDeliveryDay();
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child:
                      /* order.deliveryTime?.toDate().day==DateTime.now().day
                    ?Text('اليوم',style: TextStyle(color: Colors.white),)
               : Text('${order.deliveryTime?.toDate().year}-${order.deliveryTime?.toDate().month}-${order.deliveryTime?.toDate().day} ',
                  style: TextStyle(fontSize: 8,color: Colors.white),),*/
                      Text(
                          '${order.receivedTime?.toDate().hour}:${order.receivedTime?.toDate().minute}  ${order.receivedTime?.toDate().year}-${order.receivedTime?.toDate().month}-${order.receivedTime?.toDate().day}',
                          style: TextStyle(fontSize: 12, color: Colors.white))),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  ': تم الرفض ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          Container(
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
              ],
            ),
          ),
        ],
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
                ' تم إلغاء الطلب ',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }


}
