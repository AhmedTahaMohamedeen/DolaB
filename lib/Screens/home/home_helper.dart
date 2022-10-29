




import 'package:adminappp/Screens/User/user_product_view/user_product_helper.dart';
import 'package:adminappp/Screens/User/user_product_view/user_product_view.dart';
import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/productInfo.dart';
import 'package:adminappp/helper_methods/helper_methods1.dart';
import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeItem extends StatefulWidget {

  final Product product;
  final Admin admin;
  const HomeItem({
    Key? key,

    required this.product, required this.admin
  }) : super(key: key);



  @override
  _HomeItemState createState() => _HomeItemState();
}
class _HomeItemState extends State<HomeItem> {





  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    duration=HelperMethods.getDuration(product: widget.product);

  }



  @override
  Widget build(BuildContext context) {



    return LayoutBuilder(
        builder: (context,constraints) {

          var width=constraints.maxWidth;
          var height=constraints.maxHeight;

          return InkWell(
            splashColor: Colors.transparent,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,


            onTap: ()async{


              Navigator.push(context, MaterialPageRoute(builder: (context) => UserProductView(product:widget.product,admin: widget.admin, ),));



            },

            child: Stack(
                children: [
                   Container(
                     decoration:
                     BoxDecoration(
                         borderRadius: BorderRadius.circular(5),
                         color:  Theme.of(context).primaryColorLight.withOpacity(.3),
                        // image: DecorationImage(image: CachedNetworkImageProvider('https://images.unsplash.com/photo-1475965894430-b05c9d13568a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80'), fit: BoxFit.cover)

                      // boxShadow: [BoxShadow(color: Colors.black,blurRadius: 50,spreadRadius: 50)]


                     ),




                   ).blurred(
                     blur: 10,
                     colorOpacity:.7,
                     blurColor: Colors.white,
                     borderRadius: BorderRadius.circular(5),

                   )
                      ,

                  Positioned(
                      top: 5,
                      right: 5,
                      left: 0,

                      child: Container(
                        height: height*0.1,
                        width: width,


                        child: _storePhoto(),)


                  ),//storePhoto

                  Positioned(
                    top:
                    height*0.11


                    ,
                    left: 0,
                    right: 0,
                    bottom: height*.05,
                    child:_productImage() ,
                  ),//image

                  /*  Positioned(
                    bottom: 0,right: 0,left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight:  Radius.circular(0),
                        ),
                       // color: Colors.white.withOpacity(.1)
                      ),
                      height:
                      //60
                      height*0.15


                      ,

                      child: Column(
                        children: [


                          Container(
                            height: height*0.05,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex:2,
                                  child:  Padding(
                                    padding: const EdgeInsets.only(left: 2.0),
                                    child:
                                    _price()
                                    //HomePrice(product: widget.product,)
                                    ,
                                  )//price,
                                ),//price

                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 2.0),
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



                          Padding(
                            padding: const EdgeInsets.symmetric( horizontal: 5.0),
                            child: Container(
                              width: width,
                                height:
                                height*.09975
                              ,
                              child: Text(
                                widget.product.details!

                                ,
                                style: TextStyle(
                                    color: Theme.of(context).primaryTextTheme.subtitle1!.color!,
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
                  ),//likes,details*/
                  Positioned(
                    bottom: 5,right: 5,left: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight:  Radius.circular(0),
                        ),
                        // color: Colors.white.withOpacity(.1)
                      ),
                      height:

                      height*0.06


                      ,

                      child:           Column(
                        children: [
                          Divider(
                            thickness: height*.001,
                            color: Theme.of(context).primaryColorLight,
                            height: height*.00025,
                          ),
                          Container(
                            height: height*0.05,


                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    flex:2,
                                    child:  Padding(
                                      padding: const EdgeInsets.only(left: 2.0),
                                      child:
                                      _price()
                                      //HomePrice(product: widget.product,)
                                      ,
                                    )//price,
                                ),//price

                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 2.0),
                                    child:
                                    _likes()
                                    // HomeLikes(product: widget.product,)
                                    ,
                                  ),
                                )//likes

                              ],
                            ),
                          ),
                        ],
                      ),//price&likes
                    ),
                  ),//likes

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

                          :SizedBox()
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
                    color: Theme.of(context).primaryColor,
                    size:
                    // 15
                    height*.5


                    ,


                  ),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        width: height*2.5,
                        //color: Colors.red,
                        //alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(widget.admin.name!,style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize:

                              //height*.33
                              height*.33,


                            ),
                              overflow: TextOverflow.ellipsis
                              ,),
                            Text(

                              // widget.product.date!.toDate().toString()
                              duration



                              ,style: TextStyle(
                                color: Theme.of(context).primaryColorLight,
                                fontSize: height*.21

                            ),),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:  3.0),
                      child: Container(
                        width:  height*.9,
                        height:  height*.9,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            //   border: Border.all(color: Theme.of(context).primaryColor, width: .5,style: BorderStyle.solid),
                            boxShadow: [BoxShadow(
                                color: Theme.of(context).primaryTextTheme.bodyText1!.color!,
                                spreadRadius: 1,
                                blurRadius: 1
                            )],
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  widget.admin.photoUrl!,
                                ),
                                fit: BoxFit.fill,

                                filterQuality: FilterQuality.high



                            )
                        ),
                        // foregroundDecoration: BoxDecoration(color: Colors.black.withOpacity(.1), shape: BoxShape.circle,),
                      ),
                    ),

                  ],
                ),

              ],
            );
          }
      );
  }

  String duration='none';


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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.product.likes!.toString()




                  ,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:Theme.of(context).primaryColor,
                    fontSize: height*.6,



                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Icon(Icons.favorite,color: Colors.red.shade300,size: height*.75,),
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
                    '${
                        widget.product.price!.toString()

                    }'

                    ,
                    style: Theme.of(context).primaryTextTheme.subtitle1!.copyWith(  fontSize: height*.6,),
                  ),
                  Text(' L.E ' ,
                      style:Theme.of(context).primaryTextTheme.subtitle1!.copyWith(  fontSize: height*.6,)),
                  CircleAvatar(
                    child: Image(
                      image: AssetImage('assets/images/sale3.png'),),
                    backgroundColor: Colors.white.withOpacity(0),
                    radius:
                    //8
                    height*.4,
                  ),
                  Text(
                    '${
                        widget.product.priceBeforeSale!.toString()

                    } L.E '

                    ,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color:Theme.of(context).primaryTextTheme.subtitle1!.color,
                        fontSize:height*.35
                        // MediaQuery.of(context).size.height*.01
                        ,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Theme.of(context).primaryTextTheme.subtitle1!.color!.withOpacity(.5),
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
                  style: Theme.of(context).primaryTextTheme.subtitle1!.copyWith(  fontSize: height*.6,),
                ),
                Text(' L.E ',
                    style:Theme.of(context).primaryTextTheme.subtitle1!.copyWith(  fontSize: height*.5,)
                )

              ],
            ),
          );
        }
    );}
  }


}












List<Map<String,String>>myList=[
  {
    'url':'https://images.unsplash.com/photo-1607082350899-7e105aa886ae?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    'route':'1'
  },
  {
    'url':'https://images.unsplash.com/photo-1539949722204-22258be95aa0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    'route':'2'
  },
  {
    'url':'https://images.unsplash.com/photo-1485230895905-ec40ba36b9bc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    'route':'3'
  },
  {
    'url':'https://images.unsplash.com/photo-1531325082793-ca7c9db6a4c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    'route':'4'
  },
  {
    'url':'https://images.unsplash.com/photo-1511852365831-4c1b2b2b1325?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    'route':'5'
  },
  {
    'url':'https://images.unsplash.com/photo-1485546246426-74dc88dec4d9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169&q=80',
    'route':'6'
  },
  {
    'url':'https://images.unsplash.com/photo-1614252368727-99517bc90d7b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    'route':'7'
  },
  {
    'url':'https://images.unsplash.com/photo-1635913906376-53130718255a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    'route':'8'
  },
  {
    'url':'https://images.unsplash.com/photo-1426523038054-a260f3ef5bc9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2145&q=80',
    'route':'9'
  },

];
List<Map<String,String>>myListWomen=[
  {
    'url':'https://images.unsplash.com/photo-1483985988355-763728e1935b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    'route':'1'
  },
  {
    'url':'https://images.unsplash.com/photo-1494578379344-d6c710782a3d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    'route':'2'
  },
  {
    'url':'https://i.pinimg.com/564x/bb/e3/bd/bbe3bd2a1572fe8fb58b926f7e30a738.jpg',
    'route':'3'
  },
  {
    'url':'https://images.unsplash.com/photo-1551489186-ccb95a1ea6a3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1171&q=80',
    'route':'4'
  },
  {
    'url':'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
    'route':'5'
  },
  {
    'url':'https://images.unsplash.com/photo-1534653299134-96a171b61581?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=975&q=80',
    'route':'6'
  },
  {
    'url':'https://images.unsplash.com/photo-1529339944280-1a37d3d6fa8c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    'route':'7'
  },
  {
    'url':'https://i.pinimg.com/564x/9b/02/2c/9b022ca0e5b783db59c7e64e11573f3e.jpg',
    'route':'8'
  },
  {
    'url':'https://images.unsplash.com/photo-1619693645061-031b0585ebd7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80',
    'route':'9'
  },

];
List<Map<String,String>>myListMan=[
  {
    'url':'https://images.unsplash.com/photo-1550995694-3f5f4a7e1bd2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1171&q=80',
    'route':'1'
  },
  {
    'url':'https://i.pinimg.com/564x/c0/68/20/c0682039d3fbe0086b381d2e2097ddd3.jpg',
    'route':'2'
  },
  {
    'url':'https://i.pinimg.com/564x/16/ab/a2/16aba23878e8dbbcb16b118f58f3d0f7.jpg',
    'route':'3'
  },
  {
    'url':'https://i.pinimg.com/564x/a1/e0/53/a1e053a76bbb754f6916eb93860bb7f8.jpg',
    'route':'4'
  },
  {
    'url':'https://i.pinimg.com/564x/bc/00/ce/bc00ce970117af23f64fe4a88facd29e.jpg',
    'route':'5'
  },
  {
    'url':'https://i.pinimg.com/564x/6d/2a/42/6d2a4292ed85372f2ff1c496953371c9.jpg',
    'route':'6'
  },
  {
    'url':'https://i.pinimg.com/564x/bf/41/b1/bf41b15840178a36cfcc62d1d6d66f73.jpg',
    'route':'7'
  },
  {
    'url':'https://i.pinimg.com/564x/c2/ac/b8/c2acb8c91031c23d349f61beba335420.jpg',
    'route':'8'
  },
  {
    'url':'https://i.pinimg.com/564x/25/a8/55/25a855d7233527ed142795b09876fe35.jpg',
    'route':'9'
  },

];

class OffersPanel extends StatefulWidget {
  final List<Map<String,String>> list;
  const OffersPanel({Key? key, required this.list}) : super(key: key);

  @override
  State<OffersPanel> createState() => _OffersPanelState();
}

class _OffersPanelState extends State<OffersPanel> {
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(top:0.0),
      child: SizedBox(

        height: height*.2,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(

              height: height*.2,
              width: width,
              child: CarouselSlider(
                  items: widget.list.map((e) => InkWell(
                    onTap: (){
                      // Navigator.pushNamed(context, e['route']!);
                    },
                    child: Container(
                      height: height*.2,
                      width: width*.95,
                      decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(0),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(e['url']!),
                            fit: BoxFit.cover,

                          )
                      ),

                    ),
                  )).toList(),
                  options: CarouselOptions(
                    height: height*.3 ,
                    //height: 400,

                    // aspectRatio: 16/9,
                    pageSnapping: true,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    onPageChanged: (p,k){setState(() {
                      dotIndex=p;
                    });},
                    scrollDirection: Axis.vertical,
                  )
              ),
            ),
              // Row(mainAxisAlignment: MainAxisAlignment.center, children: widget.list.map((e) => dot(color:widget.list.indexOf(e)==dotIndex?Theme.of(context).primaryColor:Colors.white )).toList(),)

          ],
        ),
      ),
    );
  }

  int dotIndex=0;
  Widget dot({required Color color}){
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: height*.002,vertical:height*.002),
      child: Material(
          type: MaterialType.circle,
          color: color,
          elevation: 2,
          shadowColor: color,

          child: Icon(Icons.circle_rounded,color: Colors.white.withOpacity(0),size: height*.013,)
      ),
    );
  }
}



class Panel extends StatefulWidget {
  final List<Map<String,String>> list;
  final bool reverse;
  const Panel  ({Key? key, required this.list, required this.reverse}) : super(key: key);

  @override
  State<Panel> createState() => _PanelState();
}

class _PanelState extends State<Panel  > {
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top:0.0),
        child: SizedBox(

          height: height*.27,
         // width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(

                height: height*.2,
                //width: width,
                child: CarouselSlider(
                    items: widget.list.map((e) => InkWell(
                      onTap: (){
                        // Navigator.pushNamed(context, e['route']!);
                      },
                      child: Container(
                        height: height*.2,
                       // width: width*.95,
                        decoration: BoxDecoration(
                            borderRadius:BorderRadius.circular(0),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(e['url']!),
                              fit: BoxFit.cover,

                            )
                        ),

                      ),
                    )).toList(),
                    options: CarouselOptions(
                      height: height*.3 ,
                      //height: 400,

                      // aspectRatio: 16/9,
                      pageSnapping: true,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,

                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,

                      onPageChanged: (p,k){setState(() {
                        dotIndex=p;
                      });},
                      scrollDirection: Axis.horizontal,
                      reverse: widget.reverse,

                    )
                ),
              ),
            //  Row(mainAxisAlignment: MainAxisAlignment.center, children: widget.list.map((e) => dot(color:widget.list.indexOf(e)==dotIndex?Theme.of(context).primaryColor:Colors.white )).toList(),)

            ],
          ),
        ),
      ),
    );
  }

  int dotIndex=0;
  Widget dot({required Color color}){
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: height*.002,vertical:height*.002),
      child: Material(
          type: MaterialType.circle,
          color: color,
          elevation: 2,
          shadowColor: color,

          child: Icon(Icons.circle_rounded,color: Colors.white.withOpacity(0),size: height*.013,)
      ),
    );
  }
}