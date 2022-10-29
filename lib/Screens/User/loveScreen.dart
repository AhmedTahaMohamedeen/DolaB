import 'package:adminappp/Screens/home/HomeScreen.dart';
import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/love.dart';
import 'package:adminappp/constants/productInfo.dart';
import 'package:adminappp/providers/authProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/MyIndicator.dart';
import '../../providers/fireProvider.dart';
import 'user_product_view/user_product_view.dart';
class LoveScreen extends StatefulWidget {
  static const  String route='/LoveScreen';
  const LoveScreen({Key? key}) : super(key: key);

  @override
  _LoveScreenState createState() => _LoveScreenState();
}

class _LoveScreenState extends State<LoveScreen> {
  List<Product>? loveProducts;

  getLoves()async{
    var myId = Provider.of<FireProvider>(context, listen: false).myId;
    List<Product> loveProducts1=await Love().getLoveProducts(userId: myId!);
    setState(() {

      loveProducts=loveProducts1;
    });
    var x1;
    var x2;

    var s1;
    var s2;

    if(x1!='none'){s1='good';}
    if (x2!='none'){s2="good1";}

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoves();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('المفضله'),



      ),
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
        width:MediaQuery.of(context).size.width ,
           // color: Colors.white.withOpacity(.5),
          ),


          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomScrollView(

              slivers: [



                loveProducts==null?SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                        (context,index){
                      return
                       Center(child: myShimmer(color: Theme.of(context).primaryColor),);},
                    childCount: 4,

                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio:.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 1,
                  ),

                )
                :

                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                        (context,index){
                      return
                        LoveItem(product:loveProducts![index],);},
                    childCount: loveProducts!.length,

                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio:1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),

                )

              ],
            ),
          ),
          MyFloating(myLoc1: myLoc.none,floatingColor: null ,)


        ],
      ),
    );
  }
}

class LoveItem extends StatefulWidget {

  final Product product;
  const LoveItem({
    Key? key,

    required this.product
  }) : super(key: key);



  @override
  _LoveItemState createState() => _LoveItemState();
}
class _LoveItemState extends State<LoveItem> {





  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }



  @override
  Widget build(BuildContext context) {

    return InkWell(

      onTap: ()async{


        Navigator.push(context, MaterialPageRoute(builder: (context) => UserProductView(product:widget.product,admin: Admin(), ),));

      },

      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
            color: Colors.black.withOpacity(.1),
            image: DecorationImage(image: CachedNetworkImageProvider(widget.product.imageUrl!),
              fit: BoxFit. contain,)
        ),),

    );




  }



}
