
import 'package:adminappp/Screens/User/user_order/user_order_helper.dart';
import 'package:adminappp/constants/MyIndicator.dart';
import 'package:adminappp/constants/Order.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';




class AdminOrderItem extends StatefulWidget {

  final Order order;
  const AdminOrderItem({
    Key? key, required this.order,


  }) : super(key: key);



  @override
  _AdminOrderItemState createState() => _AdminOrderItemState();
}
class _AdminOrderItemState extends State<AdminOrderItem> {


  Order? order;

  getOrder()async{
    var order1=await Order().getOrderInfo(orderId:widget.order.orderId! );
    setState(() {
      order=order1;
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

    if(order!=null){return InkWell(

      onTap: ()async{


      },

      child: Stack(
          children: [
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
                            child: AdminOrderDialog(
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
            order!.whoCancelOrder==null?
            Positioned(
              left: 0,top: 0,

              child: InkWell(
                onTap: ()async{
                  showDialog(
                    context: context,
                    builder: (context) =>
                        Dialog(

                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                SizedBox(height: 30,),
                                Text(' هل تريد الغاء الطلب؟'),
                                SizedBox(height: 50,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: ()async{
                                        await Order().adminCancelOrder(order: order!);
                                        Navigator.pop(context);
                                        getOrder();
                                      },
                                      child: Container(
                                        width: 100,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius: BorderRadius.circular(20)
                                        ),

                                        child: Text('إلغاء الطلب'),
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: 100,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(.5),
                                            borderRadius: BorderRadius.circular(20)
                                        ),

                                        child: Text('رجوع'),
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                        ),);
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


            )
                : SizedBox()





          ]
      ),

    );}
    else{return
     myShimmer(color: Theme.of(context).primaryColor);


    }




  }

  Widget AdminOrderActions({required Order order}){
    var deliveryDay;
    getDeliveryDay(){
      if(order.deliveryTime?.toDate().day==DateTime.now().day){setState(() {deliveryDay='اليوم';});}
      if(order.deliveryTime?.toDate().compareTo(DateTime.now())==1){setState(() {deliveryDay='غداََ';});}
      else{setState(() {deliveryDay='${order.deliveryTime?.toDate().year}-${order.deliveryTime?.toDate().month}-${order.deliveryTime?.toDate().day} ';});}
    }

    if(order.status==orderStatus.newOrder.toString()){
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child:InkWell(
                onTap: ()async{
                  if(await Order().adminRefuseOrder(order:widget. order)){
                    print('المنتج غير متاح');
                    getOrder();

                    //  Navigator.popAndPushNamed(context, AdminOrders.route);


                  }},
                child: Container(
                  width: 80,height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Text(' غير متاح '),
                ),
              )
          ),//غير متاح
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child:InkWell(
                onTap: ()async{
                  if(await Order().adminAcceptOrder(order:widget. order)){
                    print('تم أكيد الطلب بنجاح');
                    getOrder();
                    // Navigator.popAndPushNamed(context, AdminOrders.route);

                  }
                },
                child: Container(
                  width: 80,height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Text('تأكيد الطلب'),
                ),
              )
          ),//تأكيد الطلب




        ],
      );}//admin
    if(order.status==orderStatus.adminRefuse.toString()){
      getDeliveryDay();

      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal:  3.0),
              child:

              Text('المنتج غير متاح', style: TextStyle(fontSize: 12,color: Colors.white))
          ),



        ],
      );
    }//admin
    if(order.status==orderStatus.adminAccept.toString()){
      getDeliveryDay();

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal:  3.0),
                  child:

                  Text(deliveryDay, style: TextStyle(fontSize: 12,color: Colors.white))
              ),

              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(': وقت التسليم ',style: TextStyle(color: Colors.white),),
              ),

            ],
          ),
          InkWell(
            onTap: ()async{
              if(await Order().adminGiveOrderToDeliveryMan(order: order)){
                print('تم التسليم الى الطيار');
                getOrder();
                // Navigator.popAndPushNamed(context, AdminOrders.route);

              }

            },
            child: Container(
              width: 100,height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.orange,
              ),
              child: Text(' التسليم الى الطيار',style: TextStyle(fontSize: 10),),
              alignment: Alignment.center,
            ),
          )
        ],
      );
    }//admin
    if(order.status==orderStatus.adminGiveOrderToDeliveryMan.toString()){
      getDeliveryDay();

      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal:  3.0),
              child:

              Text(deliveryDay, style: TextStyle(fontSize: 12,color: Colors.white))
          ),

          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(': وقت التسليم ',style: TextStyle(color: Colors.white),),
          ),

        ],
      );
    }//deliveryMan
    if(order.status==orderStatus.DeliveryManReceivedOrderFromAdmin.toString()){
      getDeliveryDay();

      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal:  3.0),
              child:

              Text(deliveryDay, style: TextStyle(fontSize: 12,color: Colors.white))
          ),

          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(': وقت التسليم ',style: TextStyle(color: Colors.white),),
          ),

        ],
      );
    }//deliveryMan

    if(order.status==orderStatus.DeliveryManHasArrived.toString()){
      getDeliveryDay();
      return
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal:  3.0),
                child:

                Text(deliveryDay, style: TextStyle(fontSize: 12,color: Colors.white))
            ),

            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(': وقت التسليم ',style: TextStyle(color: Colors.white),),
            ),

          ],
        );
    }//user


    if(order.status==orderStatus.UserReceivedOrder.toString()){
      getDeliveryDay();
      return
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal:  3.0),
                    child:

                    Text('${order.receivedTime?.toDate().hour}:${order.receivedTime?.toDate().minute}  ${order.receivedTime?.toDate().year}-${order.receivedTime?.toDate().month}-${order.receivedTime?.toDate().day}',


                        style: TextStyle(fontSize: 12,color: Colors.white))
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(': تم التسليم ',style: TextStyle(color: Colors.white),),
                ),


              ],
            ),
            Container(
              height: 40,width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.done_all,color: Colors.green,),
                  Icon(Icons.done_all,color: Colors.green,),

                ],
              ),
            )
          ],
        );

    }
    if(order.status==orderStatus.userRefuseOrder  .toString()){
      getDeliveryDay();
      return
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal:  3.0),
                    child:
                    /* order.deliveryTime?.toDate().day==DateTime.now().day
                    ?Text('اليوم',style: TextStyle(color: Colors.white),)
               : Text('${order.deliveryTime?.toDate().year}-${order.deliveryTime?.toDate().month}-${order.deliveryTime?.toDate().day} ',
                  style: TextStyle(fontSize: 8,color: Colors.white),),*/
                    Text('${order.receivedTime?.toDate().hour}:${order.receivedTime?.toDate().minute}  ${order.receivedTime?.toDate().year}-${order.receivedTime?.toDate().month}-${order.receivedTime?.toDate().day}',


                        style: TextStyle(fontSize: 12,color: Colors.white))
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(': تم الرفض ',style: TextStyle(color: Colors.white),),
                ),


              ],
            ),
            Container(
              height: 40,width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.close,color: Colors.red,),
                  Icon(Icons.close,color: Colors.red,),

                ],
              ),
            ),

          ],
        );

    }
    else{return Container();}
  }

}


class AdminOrderDialog extends StatefulWidget {
  final Order order;
  AdminOrderDialog({Key? key, required this.order}) : super(key: key);

  @override
  _AdminOrderDialogState createState() => _AdminOrderDialogState();
}

class _AdminOrderDialogState extends State<AdminOrderDialog> {
  Order? order;


  getOrder()async{
    var order1=await Order().getOrderInfo(orderId:widget.order.orderId! );
    setState(() {
      order=order1;
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
    if (order==null) {
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
              OrderDetails(order:order!),
              AdminOrderActions(order: order!),
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

  Widget AdminOrderActions({required Order order}){
    var deliveryDay;
    getDeliveryDay(){
      if(order.deliveryTime?.toDate().day==DateTime.now().day){setState(() {deliveryDay='اليوم';});}
      if(order.deliveryTime?.toDate().compareTo(DateTime.now())==1){setState(() {deliveryDay='غداََ';});}
      else{setState(() {deliveryDay='${order.deliveryTime?.toDate().year}-${order.deliveryTime?.toDate().month}-${order.deliveryTime?.toDate().day} ';});}
    }

   var textStyle=TextStyle(color: Theme.of(context).cardColor);
    var box=BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(10));

    if(order.status==orderStatus.newOrder.toString()){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child:InkWell(
                onTap: ()async{
                  if(await Order().adminRefuseOrder(order:widget. order)){
                    print('المنتج غير متاح');
                    getOrder();

                    //  Navigator.popAndPushNamed(context, AdminOrders.route);


                  }},
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: box,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text(' غير متاح ',style: textStyle,),
                  ),
                ),
              )
          ),//غير متاح
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child:InkWell(
                onTap: ()async{
                  if(await Order().adminAcceptOrder(order:widget. order)){
                    print('تم أكيد الطلب بنجاح');
                    getOrder();
                    // Navigator.popAndPushNamed(context, AdminOrders.route);

                  }
                },
                child: Container(
                height: 40,
                  alignment: Alignment.center,
                  decoration: box,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text('تأكيد الطلب',style: textStyle,),
                  ),
                ),
              )
          ),//تأكيد الطلب




        ],
      );}//admin
    if(order.status==orderStatus.adminRefuse.toString()){
      getDeliveryDay();

      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal:  3.0),
              child:

              Text('المنتج غير متاح', style: TextStyle(fontSize: 12,color:Theme.of(context).primaryColorDark))
          ),



        ],
      );
    }//admin
    if(order.status==orderStatus.adminAccept.toString()){
      getDeliveryDay();

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal:  3.0),
                  child:

                  Text(deliveryDay, style: TextStyle(fontSize: 12,color: Theme.of(context).primaryColor))
              ),

              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(': وقت التسليم ',style: TextStyle(color: Theme.of(context).primaryColorDark),),
              ),

            ],
          ),
          InkWell(
            onTap: ()async{
              if(await Order().adminGiveOrderToDeliveryMan(order: order)){
                print('تم التسليم الى الطيار');
                getOrder();
                // Navigator.popAndPushNamed(context, AdminOrders.route);

              }

            },
            child: Container(
             height: 40,
              decoration: box,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(' التسليم الى الطيار',style: textStyle,),
              ),
              alignment: Alignment.center,
            ),
          )
        ],
      );
    }//admin



    if(order.status==orderStatus.adminGiveOrderToDeliveryMan.toString()){
      getDeliveryDay();

      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal:  3.0),
              child:

              Text(deliveryDay, style: TextStyle(fontSize: 12,color: Colors.white))
          ),

          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(': وقت التسليم ',style: TextStyle(color: Colors.white),),
          ),

        ],
      );
    }//deliveryMan
    if(order.status==orderStatus.DeliveryManReceivedOrderFromAdmin.toString()){
      getDeliveryDay();

      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal:  3.0),
              child:

              Text(deliveryDay, style: TextStyle(fontSize: 12,color: Colors.white))
          ),

          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(': وقت التسليم ',style: TextStyle(color: Colors.white),),
          ),

        ],
      );
    }//deliveryMan
    if(order.status==orderStatus.DeliveryManHasArrived.toString()){
      getDeliveryDay();
      return
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal:  3.0),
                child:

                Text(deliveryDay, style: TextStyle(fontSize: 12,color: Colors.white))
            ),

            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(': وقت التسليم ',style: TextStyle(color: Colors.white),),
            ),

          ],
        );
    }//user


    if(order.status==orderStatus.UserReceivedOrder.toString()){
      getDeliveryDay();
      return
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal:  3.0),
                    child:

                    Text('${order.receivedTime?.toDate().hour}:${order.receivedTime?.toDate().minute}  ${order.receivedTime?.toDate().year}-${order.receivedTime?.toDate().month}-${order.receivedTime?.toDate().day}',


                        style: TextStyle(fontSize: 12,color: Colors.white))
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(': تم التسليم ',style: TextStyle(color: Colors.white),),
                ),


              ],
            ),
            Container(
              height: 40,width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.done_all,color: Colors.green,),
                  Icon(Icons.done_all,color: Colors.green,),

                ],
              ),
            )
          ],
        );

    }
    if(order.status==orderStatus.userRefuseOrder  .toString()){
      getDeliveryDay();
      return
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal:  3.0),
                    child:
                    /* order.deliveryTime?.toDate().day==DateTime.now().day
                    ?Text('اليوم',style: TextStyle(color: Colors.white),)
               : Text('${order.deliveryTime?.toDate().year}-${order.deliveryTime?.toDate().month}-${order.deliveryTime?.toDate().day} ',
                  style: TextStyle(fontSize: 8,color: Colors.white),),*/
                    Text('${order.receivedTime?.toDate().hour}:${order.receivedTime?.toDate().minute}  ${order.receivedTime?.toDate().year}-${order.receivedTime?.toDate().month}-${order.receivedTime?.toDate().day}',


                        style: TextStyle(fontSize: 12,color: Colors.white))
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(': تم الرفض ',style: TextStyle(color: Colors.white),),
                ),


              ],
            ),
            Container(
              height: 40,width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.close,color: Colors.red,),
                  Icon(Icons.close,color: Colors.red,),

                ],
              ),
            ),

          ],
        );

    }
    if(order.status==orderStatus.cancelOrder  .toString()){

      return
        Container(
          height: 40,width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.close,color: Colors.red,),
              Icon(Icons.close,color: Colors.red,),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(' تم إلغاء الطلب ',style: TextStyle(color: Colors.white),),
              ),

            ],
          ),
        );

    }
    else{return SizedBox();}
  }

}

class OrderDetails extends StatelessWidget {
  final Order order;
  const OrderDetails({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: MediaQuery.of(context).size.height * .5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                      order.photoUrl!),
                fit: BoxFit.contain,
              ),
            )),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Text(
                  order.quantity.toString(),
                style: TextStyle(
                    color: Theme.of(context).primaryColor ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                ':العدد ',
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ), //العدد
        Divider(
            height: 5,
            color: Theme.of(context).primaryColorLight,
            thickness: .5),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Text(
                  order.size!,
                style: TextStyle(
                    color: Theme.of(context).primaryColor ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                ':المقاس ',
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ), //المقاس
        Divider(
            height: 5,
            color: Theme.of(context).primaryColorLight,
            thickness: .5),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('L.E',
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 10)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Text(
                  order.price.toString(),
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                ':السعر ',
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ), //السعر
        Divider(
            height: 5,
            color: Theme.of(context).primaryColorLight,
            thickness: .5),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                getStatus(order: order),
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                ':حاله الطلب ',
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ), //حاله الطلب
        Divider(
            height: 5,
            color: Theme.of(context).primaryColorLight,
            thickness: .5),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeOrderLocation(
                          latLng: LatLng(order.lat!, order.long!),
                          orderId: order.orderId!),
                    ));
              },
              child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Text(
                    'تغيير العنوان',
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        decoration: TextDecoration.underline,fontWeight: FontWeight.w900),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                ':العنوان ',
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark),
              ),
            ),
          ],
        ), //تغيير العنون
        Divider(
            height: 5,
            color: Theme.of(context).primaryColorLight,
            thickness: .5),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Text(
                DateTime.parse(
                      order.orderTime!.toDate().toString())
                    .toString(),
                style: TextStyle(
                    color: Theme.of(context).primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                ':وقت الطلب ',
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ), //وقت الطلب
        Divider(
            height: 5,
            color: Theme.of(context).primaryColorLight,
            thickness: .5),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child:   order.acceptationTime == null
                  ? Text(
                'لم يحدد',
                style: TextStyle(
                    color:
                    Theme.of(context).primaryColor),
              )
                  : Text(
                DateTime.parse(  order.acceptationTime!
                    .toDate()
                    .toString())
                    .toString(),
                style: TextStyle(
                    color:
                    Theme.of(context).primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                ':وقت التأكيد ',
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ), //وقت التاكيد
        Divider(
            height: 5,
            color: Theme.of(context).primaryColorLight,
            thickness: .5),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child:   order.deliveryTime == null
                  ? Text(
                'لم يحدد',
                style: TextStyle(
                    color:
                    Theme.of(context).primaryColor),
              )
                  : Text(
                  order.deliveryTime!
                    .toDate()
                    .toString(),
                style: TextStyle(
                    color:
                    Theme.of(context).primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                ':وقت التوصيل المحتمل ',
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 10,fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ), //وقت التوصيل المحتمل
        Divider(
            height: 5,
            color: Theme.of(context).primaryColorLight,
            thickness: .5),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child:   order.receivedTime == null
                  ? Text(
                'لم يحدد',
                style: TextStyle(
                    color:
                    Theme.of(context).primaryColor),
              )
                  : Text(
                  order.receivedTime!
                    .toDate()
                    .toString(),
                style: TextStyle(
                    color:
                    Theme.of(context).primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                ':وقت الاستلام ',
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ), //وقت التسليم



      ],
    );
  }
}
