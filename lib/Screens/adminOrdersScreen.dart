import 'package:adminappp/Screens/Admin/admin_order/admin_order_helper.dart';
import 'package:adminappp/constants/Order.dart';
import 'package:adminappp/providers/authProvider.dart';
import 'package:adminappp/providers/fireProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Admin/admin_order/AdminOrders.dart';
class AdminOrderScreen extends StatefulWidget {
  static const route='/AdminOrderScreen';
  const AdminOrderScreen({Key? key}) : super(key: key);

  @override
  _AdminOrderScreenState createState() => _AdminOrderScreenState();
}

class _AdminOrderScreenState extends State<AdminOrderScreen> {
  List<Order>AdminOrders=[];
  getAdminOrders()async{
    var adminId=Provider.of<FireProvider>(context,listen: false).myId;
    var orders1=await Order().adminGetOrders(adminId: 'Z7ZuFzaOlsQg3repXtIvuq8BlaJ2');
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
    return Scaffold(backgroundColor: Colors.black,
      appBar: AppBar(title: Text('AdminOrders'),),
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
              childAspectRatio:.5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 1,
            ),

          ),

        ],
      ),



    );
  }
}
