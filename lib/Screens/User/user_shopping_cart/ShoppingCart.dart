

import 'package:adminappp/Screens/User/user_shopping_cart/user_shopping_cart_helper.dart';


import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/productInfo.dart';

import 'package:adminappp/providers/fireProvider.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';



class UserShoppingCart extends StatefulWidget {
  static const String route = '/UserShoppingCart';

  const UserShoppingCart({Key? key}) : super(key: key);

  @override
  _UserShoppingCartState createState() => _UserShoppingCartState();
}

class _UserShoppingCartState extends State<UserShoppingCart> {
  GlobalKey _UserShoppingCartGlobalKey = GlobalKey();
  List<Product> products = [];
  double totalPrice = 0;

  getShoppingCartProducts(BuildContext context) async {
    var myId = Provider.of<FireProvider>(context, listen: false).myId;
    var products1 = await Product().getShoppingProducts(uid: myId!);
    double totalPrice1 = 0;
    for (var product in products1) {
      setState(() {
        totalPrice1 = totalPrice1 + product.price!;
      });
    }
    setState(() {
      products = products1;
      totalPrice = totalPrice1;
    });
    print(products.length);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShoppingCartProducts(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('سله التسوق'),
        elevation: 1,
        shadowColor: Theme.of(context).primaryColor,
      ),
      body: products.isEmpty
          ? Center(
              child: Text('empty'),
            )
          : Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
                CustomScrollView(


                  slivers: [

                    SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          print(index);
                          return
                            ShoppingCartItem(product: products[index],);



                        },
                        childCount: products.length
                        ,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .7,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 1,
                      ),
                    ),



                  ],
                ),


                MyFloating(
                  myLoc1: myLoc.none,
                  floatingColor: Theme.of(context)
                      .floatingActionButtonTheme
                      .backgroundColor,
                ),







                /*  Positioned(
            bottom: 50,right: 10,
            child: InkWell(
              onTap: (){
                DateTime time=DateTime.now();
                var day=time.toUtc();
                print(day);
                print(DateTime.now());
                print(DateTime.now());
              },
              child: Container(
                width: 100,height: 50,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('$totalPrice'),
                        Text('L.E'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [

                        Icon(Icons.delivery_dining),
                        Text('طلب الكل'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )*/
              ],
            ),
    );
  }
}


