
import 'package:adminappp/constants/MyIndicator.dart';
import 'package:adminappp/constants/deviceInfo.dart';
import 'package:flutter/material.dart';
import '../admin_order/AdminOrders.dart';

import '../adminAlbumsScreen.dart';
import '../admin_product_view/adminProductView.dart';
import 'package:adminappp/Screens/Admin/store_properties/store_properties.dart';
import 'package:adminappp/Screens/Chat_screens/Admin/Admin_messages.dart';
import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/Categories.dart';

import 'package:adminappp/constants/productInfo.dart';

import 'package:cached_network_image/cached_network_image.dart';


///(1)_____[Orders]
///(2)_____[StoreMessagesIcon]
///(3)_____[StoreProfileIcon]
///(4)_____[MyStoreAlbumsItem]
///(5)_____[MyStoreItem]
///(6)_____[AdminStatistics]
///(7)_____[]
///(8)_____[]




class Orders extends StatelessWidget {
  final Color iconsColor;
  const Orders({Key? key, required this.iconsColor}) : super(key: key);


  @override
  Widget build(BuildContext context){
    return LayoutBuilder(
        builder: (context,constraints) {

          var localHeight=constraints.maxHeight;
          return InkWell(
            onTap: (){
              Navigator.pushNamed(context, AdminOrders.route);

            },
            child:  Container(
              height: localHeight*.9,
              width: localHeight*.9,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: widget.iconsColor,
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(.4),blurRadius: 5)]
              ),
              child: Icon(Icons.shopping_cart,
                  color: Colors.white,


                  size: localHeight*.4),
            ),
          );
        }
    );
  }
}


class StoreMessagesIcon extends StatelessWidget {
  final Color iconsColor;
  const StoreMessagesIcon({Key? key, required this.iconsColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder:  (context,constraints) {

          var localHeight=constraints.maxHeight;
          return Padding(
            padding: const EdgeInsets.only(left:  8.0),
            child: InkWell(
              onTap: (){
                Navigator.pushNamed(context, AdminMessages.route);

              },
              child:  Container(
                height: localHeight*.8,
                width: localHeight*.8,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    //color:widget.iconsColor,
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(.4),blurRadius: 5)]
                ),
                child: Icon(Icons.message,color: Colors.white,size: localHeight*.4),
              ),
            ),
          );
        }
    );
  }
}





class StoreProfileIcon extends StatefulWidget {
  final Admin admin;
  const StoreProfileIcon({Key? key, required this.admin}) : super(key: key);

  @override
  State<StoreProfileIcon> createState() => _StoreProfileIconState();
}
class _StoreProfileIconState extends State<StoreProfileIcon> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder:  (context,constraints) {

          var localHeight=constraints.maxHeight;
          return InkWell(
            onTap: ()
            {
              Navigator.pushNamed(context, StoreProperties.route);
            },
            child: Container(
              height: localHeight*1,
              width: localHeight*1,

              margin: EdgeInsets.all(5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:  DecorationImage(image:  CachedNetworkImageProvider(widget.admin.photoUrl!), fit:BoxFit.contain),
                  color: Colors.white.withOpacity(.5),
                  border: Border.all(color: Colors.white.withOpacity(.5),width: .5)
                // boxShadow: [BoxShadow(color: Colors.black.withOpacity(.4),blurRadius: 5)]
              ),
              // child: Icon(Icons.more_vert,color: Colors.black,size: 18,),
            ),
          );
        }
    );
  }
}





class MyStoreAlbumsItem extends StatefulWidget {

  final String category;
  final List<Product> myProducts;

  const MyStoreAlbumsItem({Key? key, required this.category, required this.myProducts}) : super(key: key);

  @override
  _MyStoreAlbumsItemState createState() => _MyStoreAlbumsItemState();
}
class _MyStoreAlbumsItemState extends State<MyStoreAlbumsItem> {


  @override
  Widget build(BuildContext context) {


    List<Product> categoryProductList=
    widget.category==allWord?
    widget.myProducts
        :
    widget.myProducts.where((element) => element.category==widget.category).toList()
    ;

    return


      // categoryProductList.length==0?Container():

      LayoutBuilder(
          builder:  (context,constraints) {

            var localHeight=constraints.maxHeight;
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>AdminAlbumScreen(category:widget.category,myProducts: widget.myProducts) ,));
              },
              child: Stack(

                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      // color: Colors.white.withOpacity(.1)
                    ),
                  ),
                  Positioned(
                    left: 0,bottom: localHeight*.24,top: 0,right: 0,
                    child:

                    categoryProductList.length==0?


                    Material(
                      color: Colors.white.withOpacity(0),
                      borderRadius: BorderRadius.circular(20),
                      elevation: 6,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.05),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white,width: .1),

                        ),
                        alignment: Alignment.center,
                        child: Text('فارغ',
                          style: TextStyle(
                              color: Colors.white.withOpacity(.5),
                              fontSize: localHeight*.08
                          ),

                        ),
                      ),
                    )




                        :

                    Container(


                        decoration: BoxDecoration(
                          //  color: Colors.green,
                          borderRadius: BorderRadius.circular(20),

                        ),
                        child: Material(
                          borderRadius:  BorderRadius.circular(20),
                          elevation: 5,
                          color: Colors.white.withOpacity(0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Expanded(
                                        child:Container(
                                          margin: EdgeInsets.all(.5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
                                            image: DecorationImage(
                                                image:

                                                CachedNetworkImageProvider(
                                                    categoryProductList.length>=2?categoryProductList[1].imageUrl!
                                                        :categoryProductList[0].imageUrl!


                                                ),fit: BoxFit.fill



                                            ),

                                            // color: Colors.red
                                          ),

                                        )
                                    ),
                                    Expanded(
                                        child:Container(
                                          margin: EdgeInsets.all(.5),


                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(bottomLeft:  Radius.circular(20)),
                                            image: DecorationImage(
                                                image:

                                                CachedNetworkImageProvider(
                                                    categoryProductList.length>=3?categoryProductList[2].imageUrl!
                                                        :categoryProductList[0].imageUrl!

                                                ),fit: BoxFit.fill



                                            ),
                                            // color: Colors.yellow,
                                          ),

                                        )
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    margin: EdgeInsets.all(.5),


                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(bottomRight:  Radius.circular(20), topRight:    Radius.circular(20),),
                                      image: DecorationImage(
                                          image:

                                          CachedNetworkImageProvider(categoryProductList[0].imageUrl!),fit: BoxFit.fill



                                      ),

                                      //  color: Colors.teal,
                                    ),


                                  ))

                            ],
                          ),
                        )



                    ),
                  ),//image

                  Positioned(
                      right: 0,bottom: 0,left: 0,
                      child: Container(
                        height:
                        localHeight*.24
                        // 45
                        ,
                        // alignment: Alignment.center,
                        // color: Colors.blue,

                        //   color: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text( widget.category,
                              style: TextStyle(
                                  fontSize:  localHeight*.072,
                                  color: Colors.white,fontWeight: FontWeight.bold),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,

                            ),
                            Text( '${categoryProductList.length.toString()} منتج' ,
                              style: TextStyle(
                                  fontSize:  localHeight*.050,
                                  color: Colors.white.withOpacity(.7)),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,

                            ),

                          ],
                        ),)),
                ],
              ),
            );
          }
      );
  }
}

class MyStoreItem extends StatefulWidget {

  final Product product;

  const MyStoreItem({
    Key? key,

    required this.product,
  }) : super(key: key);



  @override
  _MyStoreItemState createState() => _MyStoreItemState();
}
class _MyStoreItemState extends State<MyStoreItem> {






  @override
  Widget build(BuildContext context) {



    return LayoutBuilder(
        builder: (context,constraints) {

          var width=constraints.maxWidth;
          var height=constraints.maxHeight;


          return InkWell(

            onTap: ()async{


              Navigator.push(context, MaterialPageRoute(builder: (context) => AdminProductView(product:widget.product, ),));



            },

            child: _productImage(),

          );
        }
    );




  }





  _productImage(){
    return
      Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 3,
        color: Colors.white.withOpacity(0),
        child: Container(

          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0),
              borderRadius: BorderRadius.circular(20),


              image: DecorationImage(
                image: CachedNetworkImageProvider(widget.product.imageUrl!,),

                fit: BoxFit.fill
                ,)
          ),),
      )//image

        ;
  }





}



class AdminStatistics extends StatelessWidget {
  final Color color;
  final Admin admin;
  const AdminStatistics({Key? key, required this.color, required this.admin}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InfoWidget(builder: (context, deviceInfo) {
      double? localHeight = deviceInfo.localHeight;
      double? localWidth = deviceInfo.localWidth;
      double? screenHeight = deviceInfo.screenHeight;
      double? screenWidth = deviceInfo.screenWidth;
      if (deviceInfo.orientation == Orientation.landscape) {
        screenWidth = deviceInfo.screenHeight;
        screenHeight = deviceInfo.screenWidth;
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            borderRadius: BorderRadius.circular(20),
            color: color,
            elevation: 5,
            child: Container(
              height: screenHeight! * .15,
              width: screenWidth! * .6,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                //  borderRadius: BorderRadius.circular(20),
                // color:color,
                //  boxShadow: [BoxShadow(color: Colors.white.withOpacity(.1),spreadRadius: .5,blurRadius: .3)],
                // border: Border.all(color: Colors.white,style: BorderStyle.solid,width: .1)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       Text(
                          admin.views!.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: fontFamily),
                        ),
                        Text(
                          ':عدد الزيارات الشهريه',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('5000',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: fontFamily,
                            ),
                            textAlign: TextAlign.end),
                        Text(':عدد المتابِعين',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                            textAlign: TextAlign.end),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '10k',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: fontFamily),
                        ),
                        Text(':عدد الاعجابات',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                            textAlign: TextAlign.end),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '150',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: fontFamily),
                        ),
                        Text(':عدد المنتجات',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                            textAlign: TextAlign.end),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
String fontFamily = 'Pacifico';