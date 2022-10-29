import 'package:adminappp/Screens/User/user_shopping_cart/ShoppingCart.dart';
import 'package:adminappp/Screens/User/edit_user/editUser.dart';
import 'package:adminappp/Screens/User/following_screen.dart';
import 'package:adminappp/Screens/User/loveScreen.dart';
import 'package:adminappp/Screens/User/user_order/userOrders.dart';
import 'package:adminappp/Screens/beginningScreens/firstScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/authProvider.dart';




///____(1)_____[LoveTile]
///____(2)_____[FollowingTile]
///____(3)_____[MyOrders]
///____(4)_____[MyShoppingCart]
///____(5)_____[DetailsAndEditTile]
///____(6)_____[LogOutTile]





class LoveTile extends StatelessWidget {
  final double localHeight;
  const LoveTile({Key? key, required this.localHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all( 4.0),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, LoveScreen.route);
        },
        child: Material(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          elevation: 3,


          child: Container(
            height: localHeight*.11,
            decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Text('المفضله',
                  style:TextStyle(fontSize: localHeight*.04,fontWeight: FontWeight.w300,color: Theme.of(context).primaryColorDark),


                ),
                Padding(
                    padding: const EdgeInsets.only(left:  20,right: 8),
                    child:// Image(image: AssetImage('assets/images/loves.png'),width: 20,height: 20,),
                    Icon(Icons.favorite_outlined,color: Colors.redAccent.withOpacity(.8),size: localHeight*.07,)
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


class FollowingTile extends StatelessWidget {
  final double localHeight;
  const FollowingTile({Key? key, required this.localHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all( 4.0),
      child: InkWell(
        onTap:()async{

          Navigator.pushNamed(context, FollowingScreen.route,);
        } ,
        child: Material(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          elevation: 3,
          child: Container(
            height: localHeight*.11,
            decoration: BoxDecoration(
              // color: Colors.white,
               borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Text('المتاجر التى أتابعها',style:TextStyle(fontSize: localHeight*.04,fontWeight: FontWeight.w300,color: Theme.of(context).primaryColorDark),),
                Padding(
                    padding: const EdgeInsets.only(left:  20,right: 8),
                    child:
                    //CircleAvatar(backgroundImage: AssetImage('assets/images/trend.png'), radius: 18,backgroundColor: Colors.blue[900],),
                    Icon(Icons.storefront,color: Theme.of(context).primaryColorDark,size: localHeight*.07,)
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


class MyOrders extends StatelessWidget {
  final double localHeight;

  const MyOrders({Key? key, required this.localHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all( 4.0),
      child: InkWell(
        onTap:()async{

          Navigator.pushNamed(context, UserOrders.route,);
        } ,
        child: Material(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          elevation: 3,
          child: Container(
            height: localHeight*.11,
            decoration: BoxDecoration(

               borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Text('طلباتى',style:TextStyle(fontSize: localHeight*.04,fontWeight: FontWeight.w300,color: Theme.of(context).primaryColorDark),),
                Padding(
                    padding: const EdgeInsets.only(left:  20,right: 8),
                    child:
                    //CircleAvatar(backgroundImage: AssetImage('assets/images/trend.png'), radius: 18,backgroundColor: Colors.blue[900],),
                    Icon(Icons.delivery_dining,color: Theme.of(context).primaryColorDark,size: localHeight*.07,)
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


class MyShoppingCart extends StatelessWidget {
  final double localHeight;

  const MyShoppingCart({Key? key, required this.localHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all( 4.0),
      child: InkWell(
        onTap:()async{

          Navigator.pushNamed(context, UserShoppingCart.route,);
        } ,
        child: Material(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          elevation: 3,
          child: Container(
            height: localHeight*.11,
            decoration: BoxDecoration(
              // color: Colors.white,
               borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Text('سله التسوق',style:TextStyle(fontSize: localHeight*.04,fontWeight: FontWeight.w300,color: Theme.of(context).primaryColorDark),),
                Padding(
                    padding: const EdgeInsets.only(left:  20,right: 8),
                    child:
                    //CircleAvatar(backgroundImage: AssetImage('assets/images/trend.png'), radius: 18,backgroundColor: Colors.blue[900],),

                    Icon(Icons.shopping_cart,color: Theme.of(context).primaryColorDark,size: localHeight*.07,)

                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


class DetailsAndEditTile extends StatelessWidget {
  final double localHeight;
  const DetailsAndEditTile({Key? key, required this.localHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all( 4.0),
      child: InkWell(
        onTap:()async{

          Navigator.pushNamed(context, EditUserInfo.route, );
        } ,
        child: Material(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          elevation: 3,
          child: Container(
            height: localHeight*.11,
            decoration: BoxDecoration(
              //   color: Colors.white,
               borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Text(' بيانات المستحدم',style:TextStyle(fontSize: localHeight*.04,fontWeight: FontWeight.w300,color: Theme.of(context).primaryColorDark)),
                Padding(
                    padding: const EdgeInsets.only(left:  20,right: 8),
                    child:Icon(Icons.settings,color: Theme.of(context).primaryColorDark,size: localHeight*.07,)
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LogOutTile extends StatelessWidget {
  final double localHeight;
  const LogOutTile({Key? key, required this.localHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.all( 4.0),
      child: InkWell(
        onTap:()async{
          var auth=Provider.of<AuthProvider>(context,listen: false);
          await auth.logout();
          Navigator.pushNamedAndRemoveUntil(context, FirstScreen.route, (route) => false);
        } ,
        child: Material(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          elevation: 3,
          child: Container(
            height: localHeight*.11,
            decoration: BoxDecoration(
              // color: Colors.white,
               borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Text('تسجيل الخروج',style:TextStyle(fontSize: localHeight*.04,fontWeight: FontWeight.w300,color: Theme.of(context).primaryColorDark),),
                Padding(
                    padding: const EdgeInsets.only(left:  20,right: 8),
                    child:Icon(Icons.logout,color: Theme.of(context).primaryColorLight,size: localHeight*.07,)
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}





