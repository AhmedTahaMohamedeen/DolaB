
import 'package:adminappp/Screens/User/user_order/user_order_helper.dart';
import 'package:adminappp/Screens/adminOrdersScreen.dart';
import 'package:adminappp/Screens/deliveryScreen.dart';
import 'package:adminappp/constants/Order.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/providers/fireProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserOrders extends StatefulWidget {
  static const String route = '/UsersOrders';

  const UserOrders({Key? key}) : super(key: key);

  @override
  _UserOrdersState createState() => _UserOrdersState();
}

class _UserOrdersState extends State<UserOrders> {
  List<Order> orders = [];

  getOrders() async {
    var myId = Provider.of<FireProvider>(context, listen: false).myId;
    var orders1 = await Order().userGetOrders(userId: myId!);
    setState(() {
      orders = orders1;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              title: Text('طلباتى'),

            ),
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  print(index);

                  return UserOrderItem(
                    order: orders[index],
                  );
                },
                childCount: orders.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            ),
          ],
        ),
        MyFloating(
          myLoc1: myLoc.none,
          floatingColor:
              Theme.of(context).floatingActionButtonTheme.backgroundColor,
        ),
      ],
    ));
  }
}


