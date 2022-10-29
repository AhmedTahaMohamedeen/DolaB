
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/AdminInfo.dart';
import '../../constants/MyIndicator.dart';
import '../../constants/constantss.dart';
import '../../constants/deviceInfo.dart';
import '../../constants/productInfo.dart';
import '../../providers/fireProvider.dart';
import 'admin_product_view/adminProductView.dart';








class AdminAlbumScreen extends StatefulWidget {
  static const  String route='/AdminAlbumScreen';
  final String category;
  final List<Product> myProducts;
  const AdminAlbumScreen({Key? key, required this.category, required this.myProducts}) : super(key: key);

  @override
  _AdminAlbumScreenState createState() => _AdminAlbumScreenState();
}

class _AdminAlbumScreenState extends State<AdminAlbumScreen> {
  Admin? admin;
  List<Product> products=[];

  getProducts()async{
    var myId=Provider.of<FireProvider>(context,listen: false).myId;
    List<Product> allProducts1=await Product().getMyProducts(myId!);

    if(widget.category=='الكل'){setState(() {products=widget.myProducts;});}
    else{
      List<Product> products1=widget.myProducts.where((element) => element.category==widget.category).toList();
      setState(() {
        products=products1;
      });
    }


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        title: Text(widget.category,style: TextStyle(color: Theme.of(context).appBarTheme.titleTextStyle!.color,fontSize: 24),),
        centerTitle: true,
        elevation: 0,

      ),

      body:InfoWidget(
          builder: (context,deviceInfo) {
            return Stack(
              children: [
                products.length==0?myShimmer(color: Theme.of(context).primaryColor):

                CustomScrollView(
                  slivers: [

                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      sliver:
                      SliverGrid(
                        delegate:

                        SliverChildBuilderDelegate(
                              (context,index){

                            return   MyProductItem(product: products[index], admin:Admin());
                          },
                          childCount:products.length ,


                        )



                        ,
                        gridDelegate:deviceInfo.orientation==Orientation.portrait? SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2  ,
                          childAspectRatio:.9,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 30,
                          // mainAxisExtent: 400
                        )


                            :SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:4  ,
                          childAspectRatio:1,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 30,
                          // mainAxisExtent: 400
                        ),





                      )
                      ,


                    ),


                  ],
                ),
                MyFloating(myLoc1: myLoc.StoreProfile,floatingColor: Theme.of(context).scaffoldBackgroundColor,)

              ],
            );
          }
      ),


    );
  }
}



class MyProductItem extends StatefulWidget {

  final Product product;
  final Admin admin;
  const MyProductItem({
    Key? key,

    required this.product, required this.admin
  }) : super(key: key);



  @override
  _MyProductItemState createState() => _MyProductItemState();
}
class _MyProductItemState extends State<MyProductItem> {
  //var count=0;
  //bool liked=false;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();



  }



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

            child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color:Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight:  Radius.circular(20),
                        topLeft:   Radius.circular(20),
                        topRight:   Radius.circular(20),

                      ),
                      // border: Border.symmetric(vertical: BorderSide(color: Colors.white,width: 1)),
                        boxShadow: [BoxShadow(color:Theme.of(context).cardColor.withOpacity(.2),spreadRadius: .3,blurRadius: 10)]



                    ),

                  ),




                  widget.admin.name==null?SizedBox()
                      :Positioned(
                      top: 0,
                      right: 0,
                      left: 0,

                      child: Container(
                        height: height*0.1,
                        width: width,


                        child: _storePhoto(),)


                  ),//storePhoto




                  Positioned(
                    top:
                    widget.admin.name==null?0
                        :
                    height*0.1


                    ,
                    left: 0,
                    right: 0,
                    bottom: height*.15,
                    child:_productImage() ,
                  ),//image



                  Positioned(
                    bottom: 0,right: 0,left: 0,
                    child: Container(
                      height: height*0.15 ,

                      child: Column(
                        children: [


                          Container(
                            height: widget.admin.name==null?height*0.14 :height*0.05,

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    flex:3,
                                    child:  Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child:
                                      _price()
                                      //HomePrice(product: widget.product,)
                                      ,
                                    )//price,
                                ),//price

                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 4.0),
                                    child:
                                    _likes()
                                    // HomeLikes(product: widget.product,)
                                    ,
                                  ),
                                )//likes

                              ],
                            ),
                          ),//price&likes
                          Divider(
                            thickness: height*.00025,
                            color: Theme.of(context).cardColor,
                            height: height*.00025,
                          ),



                          widget.admin.name==null?SizedBox():
                          Padding(
                            padding: const EdgeInsets.symmetric( horizontal: 5.0),
                            child: Container(
                              width: width,
                              height: height*.09975 ,
                              child: Text(
                                widget.product.details!

                                ,
                                style: TextStyle(
                                    color: Theme.of(context).cardColor.withOpacity(.5),
                                    overflow: TextOverflow.ellipsis,
                                    fontSize:  height*.025

                                ),
                                maxLines: 2,
                                textAlign: TextAlign.center,



                              ),
                            ),
                          )//details



                        ],
                      ),
                    ),
                  ),//likes,details



                  Positioned(
                    top:  height*0.0875,
                    left: 0,
                    child:  Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child:
                      widget.product.sale!?
                      CircleAvatar(
                        child: Image(
                          image: AssetImage('assets/images/sale.png'),
                        ),
                        radius:
                        height*0.05
                        ,
                        backgroundColor: Colors.white.withOpacity(0),
                      )

                          :Container()
                      ,
                    ),
                  ),//saleTop





                ]
            ),

          );
        }
    );




  }

  _storePhoto(){
    return
      LayoutBuilder(
          builder: (context,constraints) {

            // var width=constraints.maxWidth;
            var height=constraints.maxHeight;



            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.more_horiz,
                    color: Theme.of(context).cardColor.withOpacity(.5),
                    size:
                    // 15
                    height*.5


                    ,


                  ),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        width: height*2,
                        // color: Colors.red,
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(widget.admin.name!,style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontSize: height*.33,
                                fontWeight: FontWeight.bold

                            ),
                              overflow: TextOverflow.ellipsis
                              ,),
                            Text(

                              // widget.product.date!.toDate().toString()
                              text



                              ,style: TextStyle(
                                color:Theme.of(context).cardColor.withOpacity(.5),
                                fontSize: height*.21

                            ),),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:  3.0),
                      child: Container(
                        width:  height,
                        height:  height,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white,width: .5,style: BorderStyle.solid),
                            boxShadow: [BoxShadow(
                                color: Colors.black.withOpacity(.5),
                                spreadRadius: 1,
                                blurRadius: 1
                            )],
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  widget.admin.photoUrl!,
                                ),fit: BoxFit.fill)
                        ),
                        foregroundDecoration: BoxDecoration(
                            color: Colors.black.withOpacity(.1),
                            shape: BoxShape.circle
                        ),
                      ),
                    ),

                  ],
                ),

              ],
            );
          }
      );
  }

  String text='none';
  _datePreview({required Product product}){



    if(product.date==null){
      print(product.date);

      return;
    }
    else{




      DateTime date=product.date!.toDate();
      // Duration duration=date.difference(Timestamp.now().toDate()).abs();
      Duration duration=Timestamp.now().toDate().difference(date).abs();


      int min=duration.inMinutes;
      int hour=duration.inHours;
      int day =duration.inDays.abs();
      int month =
      (day/30 .abs()).round();





      if(day==0&&hour==0)
      {

        if(min==0){setState(() {text='الآن';});}
        else if(min==1){setState(() {text='من دقيقه';});}
        else if(min==2){setState(() {text='من دقيقتان';});}
        else if(2<min&&min<11){setState(() {text='من'   ' ${min} '   'دقائق';});}
        else if(10<min&&min<60){setState(() {text='من'   ' ${min} '   'دقيقه';});}


      }


      else if(day==0&&hour!=0){

        if(hour==1){setState(() {text='من ساعه';});}
        else if(hour==2){setState(() {text='من ساعتين';});}
        else if(hour>2&&hour<11){setState(() {text='من'    ' ${hour} '   'ساعات';});}
        else if(hour>10&&hour<24){setState(() {text='من'   ' ${hour} '   'ساعه';});}
      }

      else if(day!=0){
        if(day==1){setState(() {text='أمس';});}
        else if(day==2){setState(() {text='من يومين';});}
        else if(day>2&&day<11){setState(() {text='من'    ' ${day} '   'أيام';});}
        else  if(day>10&&day<30){setState(() {text='من'  ' ${day} '   'يوم';});}
        else if(day>=30){

          if(day>=30&&day<60){setState(() {text='من شهر واحد';});}
          else if(day>=60&&day<250){setState(() {text='من'  ' ${month} '   'شهور';});}
        }

      }


      else if(day>=250){
        setState(() {text=

        '${widget.product.date!.toDate().day}/${widget.product.date!.toDate().month}/${widget.product.date!.toDate().year}'
        ;});
      }
      else{setState(() {
        text='none';
      });}





    }

    print(text);

  }

  _productImage(){
    return
      Container(

        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0),

            image: DecorationImage(
              image: CachedNetworkImageProvider(widget.product.imageUrl!,),

              fit: BoxFit.contain,)
        ),)//image

        ;
  }
  _likes(){

    return LayoutBuilder(
        builder: (context,constraints) {
          // var width=constraints.maxWidth;
          var height=constraints.maxHeight;


          return Container(
            //  color: Colors.red.withOpacity(.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.product.likes!.toString()



                  ,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:Theme.of(context).textTheme.bodySmall!.color!.withOpacity(.5),
                    fontSize:
                    //12
                    height*.6


                    ,

                    // fontFamily: 'Pacifico'

                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Icon(Icons.favorite,color: Colors.red.shade300,size: height*.5,),
                )
              ],
            ),
          );
        }
    );
  }

  _price(){

    if(widget.product.sale!){
      return LayoutBuilder(
          builder: (context,constraints) {

            //  var width=constraints.maxWidth;
            var height=constraints.maxHeight;

            return Container(

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  Text(
                    '${widget.product.price!.toString()}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:Theme.of(context).textTheme.bodySmall!.color!.withOpacity(.8),
                        fontSize: height*.5,
                        fontFamily: Theme.of(context).textTheme.bodySmall!.fontFamily

                    ),
                  ),
                  Text(
                    ' L.E '

                    ,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:Theme.of(context).textTheme.bodySmall!.color!.withOpacity(.5),
                      fontSize: height*.50,
                    ),
                  ),
                  CircleAvatar(
                    child: Image(
                      image: AssetImage('assets/images/sale3.png'),),
                    backgroundColor: Colors.white.withOpacity(0),
                    radius:
                    //8
                    height*.2,
                  ),
                  Text(
                    '${
                        widget.product.priceBeforeSale!.toString()

                    } L.E '

                    ,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color:Theme.of(context).textTheme.bodySmall!.color!.withOpacity(.5),
                        fontSize:height*.35
                        // MediaQuery.of(context).size.height*.01
                        ,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.grey,
                        decorationStyle: TextDecorationStyle.double

                    ),
                  ),





                ],
              ),
            );
          }
      );
    }

    else{ return  LayoutBuilder(
        builder: (context,constraints) {
          // var width=constraints.maxWidth;
          var height=constraints.maxHeight;

          return Container(


            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${ widget.product.price!.toString()}'

                  ,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:Theme.of(context).textTheme.bodySmall!.color!.withOpacity(.8),
                      fontSize: height*.6,
                      fontFamily: Theme.of(context).textTheme.bodySmall!.fontFamily

                  ),
                ),
                Text(
                  ' L.E '

                  ,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:Theme.of(context).textTheme.bodySmall!.color!.withOpacity(.5),
                    fontSize: height*.5,

                  ),
                ),

              ],
            ),
          );
        }
    );}
  }


}
