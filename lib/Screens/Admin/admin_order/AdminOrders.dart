import 'package:adminappp/Screens/Admin/admin_order/admin_order_helper.dart';
import 'package:adminappp/Screens/deliveryScreen.dart';
import 'package:adminappp/constants/Order.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/fireProvider.dart';
class AdminOrders extends StatefulWidget {
  static const  String route='/AdminOrders';

  const AdminOrders({Key? key}) : super(key: key);

  @override
  _AdminOrdersState createState() => _AdminOrdersState();
}

class _AdminOrdersState extends State<AdminOrders> {

  List<Order>AdminOrders=[];
  getAdminOrders()async{
    var myId=Provider.of<FireProvider>(context,listen: false).myId;
    var orders1=await Order().adminGetOrders(adminId: myId!);
    setState(() {
      AdminOrders=orders1;

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
          title: Text('Orders'),
          elevation: 0,
        actions: [

          InkWell(
            onTap: () {
              Navigator.pushNamed(context, DeliveryScreen.route);
            },
            child: Container(
              color: Colors.blue,
              width: 80,
              height: 50,
              alignment: Alignment.center,
              child: Text(
                'delivery',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
                  (context,index){ print(index);
                    return  AdminOrderItem(order: AdminOrders[index],);

                    },
              childCount: AdminOrders.length,

            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio:.7,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),

          ),

        ],
      ),



    );
  }
}



