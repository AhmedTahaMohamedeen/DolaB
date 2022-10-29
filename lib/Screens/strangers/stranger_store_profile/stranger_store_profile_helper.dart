
import 'package:adminappp/Screens/Chat_screens/User/User_chat.dart';
import 'package:adminappp/Screens/User/user_product_view/user_product_view.dart';
import 'package:adminappp/Screens/strangers/strangerAlbumScreen.dart';
import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/Categories.dart';
import 'package:adminappp/constants/MyIndicator.dart';
import 'package:adminappp/providers/fireProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/constantss.dart';
import '../../../constants/followInfo.dart';
import '../../../constants/productInfo.dart';



/// (1)____[StrangerMessageIcon]
/// (1)____[StrangerStoreAlbumsItem]
/// (1)____[StrangerStoreItem]
/// (1)____[StrangerMessageIcon]
/// (1)____[StrangerMessageIcon]

class StrangerMessageIcon extends StatefulWidget {

  final Admin admin;
  final Color iconsColor;

  const StrangerMessageIcon({  required this.admin, required this.iconsColor});
  @override
  _StrangerMessageIconState createState() => _StrangerMessageIconState();
}
class _StrangerMessageIconState extends State<StrangerMessageIcon> {
  Duration myDuration=Duration(milliseconds: 300);
  double chatTop=0;
  double whatsTop=0;
  double phoneTop=0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [




        AnimatedPositioned(
          top: chatTop,
          duration: myDuration,
          child: InkWell(
            child: Container(
              height:40,
              width:40,

              decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.iconsColor.withOpacity(.7),
                  image: DecorationImage(image:
                  AssetImage('assets/images/newChat.png'),scale: 15
                  )
              ),
            ),
            borderRadius: BorderRadius.circular(20),
            onTap: ()async{Navigator.push(context,MaterialPageRoute(builder: (context) => UserChat(adminId: widget.admin.adminId!) ),);},

            hoverColor: Colors.red,
            splashColor: Colors.yellow,


          ),
        ),//chat
        AnimatedPositioned(
          top: whatsTop,
          duration: myDuration,
          child: InkWell(

            child: Container(
              height: 40,
              width: 40,

              decoration:  BoxDecoration(
                  shape: BoxShape.circle,color: widget.iconsColor.withOpacity(.7),
                  image: DecorationImage(image:
                  AssetImage('assets/images/whatsapp.png'),scale: 15,)
              ),
            ),

            borderRadius: BorderRadius.circular(20),
            onTap: ()async{
              await launch('whatsapp://send?phone=+2${widget.admin.phone}');
            },

            hoverColor: Colors.red,
            splashColor: Colors.yellow,


          ),
        ),//whatsapp
        AnimatedPositioned(
          top: phoneTop,
          duration: myDuration,
          child: InkWell(

            child: Container(
              height: 40,
              width: 40,

              decoration:  BoxDecoration(
                  shape: BoxShape.circle,color: widget.iconsColor.withOpacity(.7),
                  image: DecorationImage(image:
                  AssetImage('assets/images/phone.png'), scale: 15,)
              ),
            ),

            borderRadius: BorderRadius.circular(20),
            onTap: ()async{
              await launch('tel:+2${widget.admin.phone}');

            },

            hoverColor: Colors.red,
            splashColor: Colors.yellow,


          ),
        ),//phone
        Positioned(
          left: 0,top: 0,
          child: InkWell(

            child: Container(
              height:40,
              width:40,
              //  foregroundDecoration: BoxDecoration(color: widget.buttonColor,shape: BoxShape.circle),

              decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.iconsColor,
                  boxShadow: [BoxShadow(color: widget.iconsColor)],
                  image: DecorationImage(image:
                  AssetImage('assets/images/storeChat.png'),
                      scale: 25
                  )
              ),
            ),

            borderRadius: BorderRadius.circular(20),
            onTap: (){
              if(chatTop==0){setState(() {chatTop=55;whatsTop=110;phoneTop=165;});}
              else{
                setState(() {
                  chatTop=0;whatsTop=0;phoneTop=0;
                });
              }



            },




          ),
        ),


      ],
    );
  }
}





class StrangerStoreAlbumsItem extends StatefulWidget {

  final String category;
  final List<Product> storeProducts;
  final Admin admin;

  const StrangerStoreAlbumsItem({Key? key, required this.category, required this.storeProducts, required this.admin}) : super(key: key);

  @override
  _StrangerStoreAlbumsItemState createState() => _StrangerStoreAlbumsItemState();
}

class _StrangerStoreAlbumsItemState extends State<StrangerStoreAlbumsItem> {


  @override
  Widget build(BuildContext context) {


    List<Product> categoryProductList=
    widget.category==allWord?
    widget.storeProducts
        :
    widget.storeProducts.where((element) => element.category==widget.category).toList()
    ;

    return


      // categoryProductList.length==0?Container():

      LayoutBuilder(
          builder:  (context,constraints) {

            var localHeight=constraints.maxHeight;
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>StrangerAlbumScreen(admin:widget.admin,products:categoryProductList ,category: widget.category) ,));
              },
              child: Stack(

                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      //color: Colors.white.withOpacity(.1)
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: localHeight*.35,
                    top: 0,right: 0,
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
                        localHeight*.35
                        // 45
                        ,
                        // alignment: Alignment.center,
                        // color: Colors.blue,

                        //   color: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text( widget.category,
                              style: TextStyle(
                                  fontSize:  localHeight*.11,
                                  color: Colors.white,fontWeight: FontWeight.bold),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,

                            ),
                            Text( '${categoryProductList.length.toString()} منتج' ,
                              style: TextStyle(
                                  fontSize:  localHeight*.070,
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
}///album






class StrangerStoreItem extends StatefulWidget {

  final Product product;
  final Admin admin;

  const StrangerStoreItem({
    Key? key,

    required this.product, required this.admin,
  }) : super(key: key);



  @override
  _StrangerStoreItemState createState() => _StrangerStoreItemState();
}
class _StrangerStoreItemState extends State<StrangerStoreItem> {






  @override
  Widget build(BuildContext context) {



    return LayoutBuilder(
        builder: (context,constraints) {

          var width=constraints.maxWidth;
          var height=constraints.maxHeight;


          return InkWell(

            onTap: ()async{


              Navigator.push(context, MaterialPageRoute(builder: (context) => UserProductView(product:widget.product,admin: widget.admin, ),));



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





}///all





class StrangerStoreMessageIcon extends StatelessWidget {

  final Color followButtonColor;
  final Color unFollowButtonColor;
  final double localHeight;
  final Admin admin;
  const StrangerStoreMessageIcon({Key? key, required this.followButtonColor, required this.unFollowButtonColor, required this.localHeight, required this.admin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 2,
      color: unFollowButtonColor,
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => Dialog(
                elevation: 1,
                backgroundColor: Colors.black,
                alignment: Alignment.center,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  width: localHeight * 6,
                  height: localHeight * 6,
                  decoration: BoxDecoration(
                      color: unFollowButtonColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0),
                        elevation: 3,
                        child: InkWell(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserChat(
                                      adminId: admin.adminId!)),
                            );
                          },
                          child: Container(
                            width: localHeight * 6,
                            height: localHeight * 1.1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: followButtonColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                    image: AssetImage(
                                        'assets/images/newChat.png'),
                                    height: localHeight * .7,
                                    width: localHeight * .7),
                                Text('بدأ محادثه',
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(.7),
                                        fontSize: localHeight * .35)),
                              ],
                            ),
                          ),
                        ),
                      ), //chat
                      Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0),
                        elevation: 3,
                        child: InkWell(
                          onTap: () async {
                            await launch(
                                'whatsapp://send?phone=+2${admin.phone}');
                          },
                          child: Container(
                            width: localHeight * 6,
                            height: localHeight * 1.1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: followButtonColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                    image: AssetImage(
                                        'assets/images/whatsapp.png'),
                                    height: localHeight * .7,
                                    width: localHeight * .7),
                                Text('رساله واتساب',
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(.7),
                                        fontSize: localHeight * .35)),
                              ],
                            ),
                          ),
                        ),
                      ), //whatsApp
                      Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0),
                        elevation: 3,
                        child: InkWell(
                          onTap: () async {
                            await launch('tel:+2${admin.phone}');
                          },
                          child: Container(
                            width: localHeight * 6,
                            height: localHeight * 1.1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: followButtonColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                    image: AssetImage(
                                        'assets/images/phone.png'),
                                    height: localHeight * .7,
                                    width: localHeight * .7),
                                Text('إتصال ',
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(.7),
                                        fontSize: localHeight * .35)),
                              ],
                            ),
                          ),
                        ),
                      ), //call
                    ],
                  ),
                ),
              ));
        },
        child: Container(
          width: localHeight * 1.15,
          height: localHeight,
          decoration: BoxDecoration(
            color: followButtonColor.withOpacity(.2),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Image(
              image: AssetImage('assets/images/contact.png'),
              width: localHeight * .5,
              height: localHeight * .5),
        ),
      ),
    );
  }
}

class StrangerStoreLocationIcon extends StatelessWidget {
  final Color followButtonColor;
  final Color unFollowButtonColor;
  final double localHeight;
  final Admin admin;
  const StrangerStoreLocationIcon({Key? key, required this.followButtonColor, required this.unFollowButtonColor, required this.localHeight, required this.admin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 2,
      color: unFollowButtonColor,
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => Dialog(
                backgroundColor: Colors.black,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  //side: BorderSide(color: Colors.white,width: 1)
                ),
                alignment: Alignment.center,
                child: Container(
                  width: localHeight * 5,
                  height: localHeight * 5,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: followButtonColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'سوف يتم الآن فتح الموقع بواسطه google maps؟',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: localHeight * 0.35),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(10),
                            color: followButtonColor,
                            shadowColor: Colors.black,
                            child: InkWell(
                              onTap: () async {
                                if ( admin.lat != 0) {
                                  await launch(
                                      'https://www.google.com/maps/search/?api=1&query=${ admin.lat},${ admin.long}');
                                }
                                Navigator.pop(context);
                              },
                              child: SizedBox(
                                width: localHeight * 2,
                                height: localHeight,

                                // alignment: Alignment.center,
                                child: Center(
                                  child: Text('فتح',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: localHeight * 0.35),
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.rtl),
                                ),
                              ),
                            ),
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(10),
                            color: followButtonColor,
                            elevation: 2,
                            shadowColor: Colors.black,
                            child: InkWell(
                              onTap: () async {
                                Navigator.pop(context);
                              },
                              child: SizedBox(
                                width: localHeight * 2,
                                height: localHeight,
                                child: Center(
                                  child: Text('رجوع',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: localHeight * 0.35),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ));
        },
        child: Container(
          width: localHeight * 1.15,
          height: localHeight,
          decoration: BoxDecoration(
            color: followButtonColor.withOpacity(.2),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Image(
              image: AssetImage('assets/images/googleLocation.png'),
              height: localHeight * .5,
              width: localHeight * .5),
        ),
      ),
    );
  }
}

class StrangerStoreFollow extends StatefulWidget {
  final Color followButtonColor;

  final Color unFollowButtonColor;
  final double localHeight;
  final Admin admin;
  const StrangerStoreFollow({Key? key, required this.followButtonColor, required this.localHeight, required this.admin, required this.unFollowButtonColor}) : super(key: key);

  @override
  State<StrangerStoreFollow> createState() => _StrangerStoreFollowState();
}

class _StrangerStoreFollowState extends State<StrangerStoreFollow> {
  @override
  Widget build(BuildContext context) {
    if (isFollow) {
      return Material(
        color: Colors.white.withOpacity(0),
        type: MaterialType.button,
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () async {
            var myId = Provider.of<FireProvider>(context, listen: false).myId;
            setState(() {
              isFollow = false;
            });
            if (await Follow()
                .removeFollow(userId: myId!, admin: widget.admin)) {
              debugPrint('follow removed');
            } else {
              return;
            }
          },
          child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 8),
              height: widget.localHeight,
              width: widget.localHeight * 4,
              // margin: EdgeInsets.symmetric(horizontal: 8),

              decoration: BoxDecoration(
                color: widget.followButtonColor,

                borderRadius: BorderRadius.circular(10),
                //  boxShadow: [BoxShadow(color: Colors.black.withOpacity(.4),spreadRadius: .1,blurRadius: 10)]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/images/follow.png'),
                    height: widget.localHeight * .35,
                    width: widget.localHeight * .35,
                  ),
                  Text(
                    'تمت المتابعه',
                    style: TextStyle(
                        color: Colors.white, fontSize: widget.localHeight * .3),
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
        ),
      );
    } else {
      return Material(
        elevation: 2,
        color: Colors.white.withOpacity(0),
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () async {
            var myId = Provider.of<FireProvider>(context, listen: false).myId;
            setState(() {
              isFollow = true;
            });
            if (await Follow().addNewFollow(
              userId: myId!,
              admin: widget.admin,
            )) {
              debugPrint('follow ');
            } else {
              return;
            }
          },
          child: Container(
              alignment: Alignment.center,
              height: widget.localHeight,
              width: widget.localHeight * 4,
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: widget.unFollowButtonColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Image(image: AssetImage('assets/images/addfollow.png'), height: 15, width: 15,),
                  Text(
                    'متابعه',
                    style: TextStyle(
                        color: Colors.white, fontSize:widget. localHeight * .3),
                  ),
                ],
              )),
        ),
      );
    }
  }

  bool isFollow = false;

  checkIsFollow() async {
    var myId = Provider.of<FireProvider>(context, listen: false).myId;
    var follow = await Follow()
        .checkFollow(userId: myId!, adminId: widget.admin.adminId!);
    setState(() {
      isFollow = follow;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIsFollow();
  }
}


class StrangerStoreCoverAndDetails extends StatelessWidget {
  final double localHeight;
  final double screenWidth;
  final double screenHeight;
  final Color backgroundColor;
  final Admin admin;
  const StrangerStoreCoverAndDetails({Key? key, required this.localHeight, required this.admin, required this.screenWidth, required this.backgroundColor, required this.screenHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [

        Stack(
          children: [
            Material(
              color: backgroundColor,
              elevation: 30,
              shadowColor: Colors.black,
              borderRadius: BorderRadius.circular(50),
              child: Container(
                height: screenHeight * .275,
                width: screenWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
            _cover(context:context ),
            //cover

            _followAndViews(context: context),
            _photo(context: context),
            //circle photo
          ],
        ),
        Column(
          children: [
            _name(context: context),
            //name

            SizedBox(height: screenHeight * .02 ),
            _typeAndSex(context: context),
            //type&sex
            _address(context: context),
            //address
          ],
        ),





       //follow
      ],
    );
  }


  _name({required BuildContext context}) {
    return Container(
      height: localHeight * .22,

      alignment: Alignment.center,
      child: admin  .name == null
          ? myShimmer(color: Theme.of(context).primaryColor)
          : Text(
        admin.name!  ,
        style: TextStyle(
          color: Colors.white,
          fontSize: localHeight * .12,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    ) //name
        ;
  }

  _typeAndSex({required BuildContext context}) {
    return Container(
      height: localHeight * .13,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          admin  .storeType == null
              ? myShimmer(color: Theme.of(context).primaryColor)
              : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '${admin  .storeType}/${admin  .storeSex}',
              style: TextStyle(
                color: Colors.white,
                fontSize: localHeight * .05,
                // fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Icon(
            Icons.store_mall_directory_outlined,
            size: localHeight * .08,
            color: Colors.white.withOpacity(.5),
          )
        ],
      ),
    ) //type&sex
        ;
  }

  _address({required BuildContext context}) {
    return Container(
        height: localHeight * .1,
        // color: Colors.black.withOpacity(.5),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            admin.city == null
                ? Text('')
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                '${admin.city}/${admin.department}',
                style: TextStyle(
                  color: backColor2,
                  fontSize: localHeight * .05,
                  // fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Icon(
              Icons.location_on_outlined,
              color: Colors.white.withOpacity(.5),
              size: localHeight * .1,
            )
          ],
        )) //address
        ;
  }







  Widget _photo({required BuildContext context}) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(),
          admin.photoUrl == null
              ? Container()
              : Container(
            width: localHeight * .5,
            height: localHeight * .5,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(admin.photoUrl!),
                    fit: BoxFit.fill)),
          ),
          SizedBox(),
        ],
      ),
    );
  }

  Widget _followAndViews({required BuildContext context}) {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          height: localHeight * .23,
          //color: Colors.white.withOpacity(.3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      //Text('590',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
                      admin.followers == null
                          ? Text('0',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: localHeight * .06))
                          : Text(
                        admin.followers.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: localHeight * .06),
                      ),

                      Text(
                        'المتابعين',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w100,
                            fontSize: localHeight * .05),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
              Expanded(
                child: Column(
                  children: [
                    admin.views == null
                        ? Text('0',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: localHeight * .06))
                        : Text(
                      admin.views.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: localHeight * .06),
                    ),
                    Text(
                      'المشاهدات',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                          fontSize: localHeight * .05),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _cover({required BuildContext context}) {
    return Container(
      height: localHeight * .76,
      width: MediaQuery.of(context).size.width,
      child: admin.photoUrlCover == null
          ? Center(
        child: myShimmer(color: Theme.of(context).primaryColor),
      )
          : Image(
        image: CachedNetworkImageProvider(admin.photoUrlCover!),
        fit: BoxFit.fill,
      ),
    );
  }
}



