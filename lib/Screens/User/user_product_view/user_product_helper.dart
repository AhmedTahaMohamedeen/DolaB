


import 'dart:io';

import 'package:adminappp/Screens/Chat_screens/User/User_chat.dart';
import 'package:adminappp/Screens/Show_Photo.dart';
import 'package:adminappp/Screens/User/user_product_view/user_product_view.dart';
import 'package:adminappp/Screens/strangers/stranger_store_profile/stranger_store_profile.dart';
import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/My_Flush.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/deviceInfo.dart';
import 'package:adminappp/constants/followInfo.dart';
import 'package:adminappp/constants/love.dart';
import 'package:adminappp/constants/productInfo.dart';
import 'package:adminappp/providers/fireProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

///  1___[UserProductViewAppBar]   ///[AddProductToCart]
///
///  2___[ProductImage]
///
///  3___[LikesAndChat] ///  [myLikeButton]
///
///  4___[PriceAndDate]
///
///  5___[PageName]
///
///  6___[DetailsAndSizes]
///
///  7___[ProductItem]






class UserProductViewAppBar extends StatelessWidget {
  final Product product;
  const UserProductViewAppBar({Key? key, required this.product}) : super(key: key);

  @override
   build(BuildContext context) {
    return   SliverAppBar(
      floating: true,
      toolbarHeight: 40,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      automaticallyImplyLeading: true,
      elevation: 1,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back_outlined,
            color: Theme.of(context)
                .appBarTheme
                .iconTheme!
                .color),
      ),
      actions: [
          AddProductToCart(product: product),
        SizedBox(width: 5),
      ],
    );
  }

}
class AddProductToCart extends StatelessWidget {
  final Product product;
  const AddProductToCart({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo) {
      double? localHeight = deviceInfo.localHeight;
      double? localWidth = deviceInfo.localWidth;
      double? screenHeight = deviceInfo.screenHeight;
      double? screenWidth = deviceInfo.screenWidth;

      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: InkWell(
          onTap: () async {
            var myId = Provider.of<FireProvider>(context, listen: false).myId;
            if (await Product()
                .addProductToShoppingCart(uid: myId!, product: product)) {
              MyFlush()
                  .showFlush(context: context, text: 'تمت الاضافه الى السله');
            }
          },
          child: Material(
            borderRadius: BorderRadius.circular(0),
            color: Colors.white,
            elevation: 2,
            child: Container(
              // width: localHeight!*3,

              height: localHeight,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),


              ),

              child: Icon(Icons.add_shopping_cart_outlined,
                  color: Theme.of(context).primaryColor, size: localHeight! * .6),
              alignment: Alignment.center,
            ),
          ),
        ),
      );
    });
  }
}


class ProductImage extends StatefulWidget {
  final Product product;

  final double localHeight;

  const ProductImage(
      {required this.product,

        required this.localHeight});

  @override
  _ProductImageState createState() => _ProductImageState();
}
class _ProductImageState extends State<ProductImage> {
  int current = 0;
  List imagesList = [];

  makeList() {
    List<String> x0 = [];
    List<String> x1 = [];
    List<String> x2 = [];
    List<String> x3 = [];
    List<String> x4 = [];
    List<String> x5 = [];
    setState(() {
      x0.add(widget.product.imageUrl!);
      setState(() {
        x1 = x0;
      });
    });
    if (widget.product.imageUrl1 != 'none') {
      setState(() {
        x1.add(widget.product.imageUrl1!);
        x2 = x1;
      });
    } else {
      setState(() {
        x2 = x1;
      });
    }
    if (widget.product.imageUrl2 != 'none') {
      setState(() {
        x2.add(widget.product.imageUrl2!);
        x3 = x2;
      });
    } else {
      setState(() {
        x3 = x2;
      });
    }

    if (widget.product.imageUrl3 != 'none') {
      setState(() {
        x3.add(widget.product.imageUrl3!);
        x4 = x3;
      });
    } else {
      setState(() {
        x4 = x3;
      });
    }

    if (widget.product.imageUrl3 != 'none') {
      setState(() {
        x4.add(widget.product.imageUrl4!);
        x5 = x4;
      });
    } else {
      setState(() {
        x5 = x4;
      });
    }
    setState(() {
      imagesList = x5;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makeList();
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo) {
      double? localHeight = deviceInfo.localHeight;
      double? localWidth = deviceInfo.localWidth;
      double? screenHeight = deviceInfo.screenHeight;
      double? screenWidth = deviceInfo.screenWidth;

      return Material(
        borderRadius: BorderRadius.circular(20),
        color:Colors.white,
        elevation: 5,
        child: Stack(
          children: [
            PageView.builder(
              itemCount: imagesList.length,
              onPageChanged: (s) {
                setState(() {
                  current = s;
                });
              },
              controller: PageController(
                initialPage: current,
              ),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, ShowPhoto.route,
                        arguments: imagesList[current]);
                  },
                  child: imagesList.length == 0
                      ? Text('loading')
                      : Stack(
                    children: [
                      Container(
                        height: localHeight,
                        width: localWidth,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                imagesList[current]),
                            fit: BoxFit.contain,
                            scale: 100,
                          ),

                          // borderRadius: BorderRadius.circular(50)
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        // left:0 ,
                        // right: 0,
                        child: Container(
                          //  color: Colors.black.withOpacity(.1),
                          width: screenWidth,
                          height: localHeight! * .1,

                          child: imagesList.length == 1
                              ? Container()
                              : Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: imagesList
                                  .map((e) => Padding(
                                padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 5.0),
                                child: Container(
                                  width:
                                  imagesList.indexOf(e) ==
                                      current
                                      ? localHeight * .1
                                      : localHeight * .05,
                                  height:
                                  imagesList.indexOf(e) ==
                                      current
                                      ? localHeight * .1
                                      : localHeight * .05,
                                  decoration: BoxDecoration(
                                    // color: Colors.red,
                                      borderRadius:
                                      BorderRadius.circular(
                                          10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Theme.of(context).primaryColor,
                                            blurRadius: 10)
                                      ],
                                      image: DecorationImage(
                                        image:
                                        CachedNetworkImageProvider(
                                            e),
                                        fit: BoxFit.contain,
                                      )
                                    //

                                  ),
                                ),
                              ))
                                  .toList()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: widget.product.sale!
                    ? CircleAvatar(
                  child: Image(
                    image: AssetImage('assets/images/sale.png'),
                  ),
                  radius: localHeight! * .08,
                  backgroundColor: Colors.white.withOpacity(0),
                )
                    : Container(),
              ),
            ), //saleTop
          ],
        ),
      );
    });
  }

  Widget _share(BuildContext context) {
    return InkWell(
      onTap: () async {
        final imageUrl = imagesList[current]!;
        final url = Uri.parse(imageUrl);
        final response = await http.get(url);
        final bytes = response.bodyBytes;
        final temp = await getTemporaryDirectory();
        final path = '${temp.path}/image.jpg';
        File(path).writeAsBytesSync(bytes);

        await Share.shareFiles([path], text: '');
        Navigator.pop(context);
      },
      child: Container(
          width: MediaQuery.of(context).size.width * .5,
          height: 25,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            'مشاركه',
            style: TextStyle(
              color: Colors.white,
            ),
          )),
    );
  }
}


class LikesAndChat extends StatelessWidget {
  final double localHeight;
  final Admin admin;
  final Product product;
  final int likes;
  const LikesAndChat({Key? key, required this.localHeight, required this.admin, required this.product, required this.likes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      color:Colors.white,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///message
            Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    child: Container(
                      height:  localHeight,
                      width:  localHeight,
                      alignment: Alignment.center,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor.withOpacity(0),
                      ),
                      child: Image(
                        image: AssetImage('assets/images/contact.png'),
                        color: Theme.of(context).primaryColorLight,
                        height:  localHeight*.5,
                        width:  localHeight*.5,

                      ),
                    ),
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            elevation: 1,
                            backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
                            alignment: Alignment.center,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              width:  localHeight * 5,
                              height:  localHeight * 5,
                              decoration: BoxDecoration(

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
                                        width:  localHeight * 5,
                                        height:  localHeight,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Image(
                                                image: AssetImage(
                                                    'assets/images/newChat.png'),
                                                height: 30,
                                                width: 30),
                                            Text('بدأ محادثه',
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(.7))),
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
                                            'whatsapp://send?phone=+2${ admin.phone}');
                                      },
                                      child: Container(
                                        width:  localHeight * 5,
                                        height:  localHeight,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Image(
                                                image: AssetImage(
                                                    'assets/images/whatsapp.png'),
                                                height: 30,
                                                width: 30),
                                            Text('رساله واتساب',
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(.7))),
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
                                        await launch(
                                            'tel:+2${ admin.phone}');
                                      },
                                      child: Container(
                                        width:  localHeight * 5,
                                        height:  localHeight,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Image(
                                                image: AssetImage(
                                                    'assets/images/phone.png'),
                                                height: 30,
                                                width: 30),
                                            Text('إتصال ',
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(.7))),
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
                  ),
                )),


            ///like button
            Expanded(
                child: myLikeButton(
                  product:  product,
                )),


            ///likes
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    /*  product==null?

                     product.likes.toString()
                        :product!.likes.toString()*/
                      likes.toString(),
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize:  localHeight * .25),
                  ),
                  Icon(
                    Icons.favorite_outlined,
                    color: Colors.red,
                    size:  localHeight * .25,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class myLikeButton extends StatefulWidget {
  final Product product;

  const myLikeButton({required this.product});

  @override
  _myLikeButtonState createState() => _myLikeButtonState();
}
class _myLikeButtonState extends State<myLikeButton> {
  var count = 0;
  bool liked = false;
  bool loveExist = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoveExist();
  }

  checkLoveExist() async {
    var myId = Provider.of<FireProvider>(context, listen: false).myId;
    bool loveExist1 = await Love()
        .checkLoveExist(userId: myId!, productId: widget.product.productId!);

    setState(() {
      loveExist = loveExist1;
    });
    print('love = $loveExist');
  }

  CrossFadeState show = CrossFadeState.showFirst;
  double x = 20;

  bool pressed = false;
  String photo = 'assets/images/heart.png';

  @override
  Widget build(BuildContext context) {
    var myId = Provider.of<FireProvider>(context, listen: false).myId;
    return InfoWidget(builder: (context, deviceInfo) {
      double? localHeight = deviceInfo.localHeight;
      double? localWidth = deviceInfo.localWidth;
      double? screenHeight = deviceInfo.screenHeight;
      double? screenWidth = deviceInfo.screenWidth;
      return InkWell(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        splashColor: Colors.transparent,

        onTap: () async {
          if (loveExist) {
            setState(() {
              liked = false;
              loveExist = false;
            });
            if (await Love()
                .removeLove(userId: myId!, product: widget.product)) {
              // setState(() {photo='assets/images/heart.png';});
              debugPrint('love removed');
            } else {
              return;
            }
          } else {
            setState(() {
              liked = true;
              loveExist = true;
            });
            if (await Love()
                .addLove(userId: myId!, product: widget.product)) {
              // setState(() {photo='assets/images/loved.png';});
              debugPrint('love added');
            } else {
              return;
            }
          }
        },
        child: Material(
          type: MaterialType.circle,

          color: Colors.white,
          elevation: 3,
          child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,


              ),
              height: localHeight!*.8,
              width: localHeight*.8,
              child: Icon(
                Icons.favorite_outlined,
                color: !loveExist
                    ? Theme.of(context).canvasColor.withOpacity(.3)
                    : Colors.red.shade300,
                size: localHeight * .4,
              )),
        ),
      );
    })



    ;
  }
}

class PriceAndDate extends StatefulWidget {
  final Product product;
  final double localHeight;
  final String duration;
  const PriceAndDate({Key? key, required this.product, required this.localHeight, required this.duration}) : super(key: key);

  @override
  State<PriceAndDate> createState() => _PriceAndDateState();
}
class _PriceAndDateState extends State<PriceAndDate> {
  @override
  Widget build(BuildContext context) {
    return
    Material(
      borderRadius: BorderRadius.circular(15),
      color:Theme.of(context).cardColor,
      elevation: 70,
      shadowColor: Theme.of(context).primaryColor,
      child: widget.product.sale!?_isSale():_isNotSale(),
    );


  }


 Widget _duration(){

    return  Row(
      textDirection: TextDirection.rtl,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.timer_outlined,
          color: Theme.of(context).primaryColor,
          size: widget.localHeight * .4,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            widget.duration,
            style: TextStyle(
                color: Theme.of(context)
                    .primaryTextTheme
                    .subtitle1!
                    .color!
                    .withOpacity(1),
                fontSize: widget.localHeight * .3),
            maxLines: 1,
            overflow: TextOverflow.clip,
            textAlign: TextAlign.right,
          ),
        )
      ],
    );
 }

 Widget _isSale(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${widget.product.price!.toString()}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryTextTheme.subtitle1!.color,
                  fontSize: widget.localHeight * .6,
                ),
              ),
              Text(' L.E ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).canvasColor,
                    fontSize:widget. localHeight * .4,
                  )),
              CircleAvatar(
                child: Image(
                  image: AssetImage('assets/images/sale3.png'),
                ),
                backgroundColor: Colors.white.withOpacity(0),
                radius:
                //8
                widget.localHeight * .2,
              ),
              Text(
                '${widget.product.priceBeforeSale!.toString()} L.E ',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).primaryTextTheme.subtitle1!.color,
                    fontSize:widget. localHeight * .3
                    // MediaQuery.of(context).size.height*.01
                    ,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Theme.of(context).primaryColor,
                    decorationStyle: TextDecorationStyle.double),
              ),
            ],
          ),
          _duration()
        ],
      ),
    );
 }
 Widget _isNotSale(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${widget.product.price!.toString()}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryTextTheme.subtitle1!.color,
                    fontSize:widget. localHeight * .50,
                    fontFamily:
                    Theme.of(context).textTheme.bodySmall!.fontFamily),
              ),
              Text(
                ' L.E ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize:widget. localHeight * .3,
                ),
              )
            ],
          ),
          _duration()
        ],
      ),
    );
 }
}

class PageName extends StatefulWidget {
  final Admin admin;

  final double localHeight;
  final double screenWidth;

  const PageName(
      {required this.admin,

        required this.localHeight, required this.screenWidth});

  @override
  _PageNameState createState() => _PageNameState();
}
class _PageNameState extends State<PageName> {
  @override
  Widget build(BuildContext context) {
    var MyId = Provider.of<FireProvider>(context, listen: false).myId;
    return Material(
      borderRadius: BorderRadius.circular(20),
      color:Theme.of(context).primaryColor,
      elevation: 1,

      child: Container(
        height: widget.localHeight,
        width: widget.screenWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color:Theme.of(context).primaryColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              followButton(),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StrangerStore(
                              admin: widget.admin,
                            )));
                  },

                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: widget.localHeight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  widget.admin.name!,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .color,
                                      fontSize: widget.localHeight * .25,
                                      fontWeight: FontWeight.bold),
                                  //textAlign: TextAlign.center,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      widget.admin.followers!.toString(),
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .color!
                                              .withOpacity(.5),
                                          fontSize: widget.localHeight * .18),
                                      //textAlign: TextAlign.right,
                                    ),
                                    Icon(
                                      Icons.person,
                                      size: widget.localHeight * .25,
                                      color: Theme.of(context)
                                          .iconTheme
                                          .color!
                                          .withOpacity(.5),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ), //name
                        SizedBox(width: 10),
                        Container(
                          height: widget.localHeight * .9,
                          width: widget.localHeight * .9,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Theme.of(context).canvasColor),
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      widget.admin.photoUrl!),
                                  fit: BoxFit.fill)),
                        ), //image
                      ],
                    ),
                  ),
                ),
              ), //name
            ],
          ),
        ),
      ),
    );
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

  Widget followButton() {
    return InfoWidget(
      builder: (context, deviceInfo) {
        double? localHeight = deviceInfo.localHeight;
        double? localWidth = deviceInfo.localWidth;
        double? screenHeight = deviceInfo.screenHeight;
        double? screenWidth = deviceInfo.screenWidth;
        if (isFollow) {
          return InkWell(
            onTap: () async {
              var myId = Provider.of<FireProvider>(context, listen: false).myId;
              setState(() {
                isFollow = false;
              });
              if (await Follow()
                  .removeFollow(userId: myId!, admin: widget.admin)) {
                debugPrint('follow Removed');
              } else {
                return;
              }
            },
            splashColor: color_y,
            child: Container(
                alignment: Alignment.center,
                height: localHeight! * .5,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.done_all_outlined,
                        size: localHeight * .25,
                        color: Colors.white,
                      ),
                      Text(
                        'تمت المتابعه',
                        style: TextStyle(
                            color: Colors.white, fontSize: localHeight * .2),
                      ),
                      // Icon(Icons.person_add),
                    ],
                  ),
                )),
          );
        } else {
          return InkWell(
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
            splashColor: color_y,
            child: Container(
                alignment: Alignment.center,
                height: localHeight! * .5,
                //width: 60,
                decoration: BoxDecoration(
                    color:
                    //Colors.deepOrange.withOpacity(1)
                    Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.person_add,
                        size: localHeight * .25,
                        color: Colors.white,
                      ),
                      Text(
                        'متابعه',
                        style: TextStyle(
                            color: Colors.white, fontSize: localHeight * .25),
                      ),
                    ],
                  ),
                )),
          );
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIsFollow();
  }
}



class DetailsAndSizes extends StatelessWidget {
  final Product product;
  final double screenHeight;
  final double screenWidth;
  const DetailsAndSizes({Key? key, required this.product, required this.screenHeight, required this.screenWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _details(screenHeight: screenHeight,context: context),

        SizedBox(height: screenHeight * .010,),
        _mySize(screenHeight: screenHeight,context: context),
      ],
    );
  }

  Widget _mySize({required double screenHeight,required BuildContext context}) {
    return Material(
      color: Theme
          .of(context)
          .primaryColor,
      elevation: 1,
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: screenWidth,
        child: Container(
          height: screenHeight * .15,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(.02),
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 20,
                crossAxisSpacing: .05,
                childAspectRatio: .1,
                mainAxisExtent: 100,
                mainAxisSpacing: .05,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: product.sizes!.length,
              reverse: true,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) =>
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: Container(

                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme
                              .of(context)
                              .primaryColorDark,
                          border: Border.all(color: Colors.white, width: .1)),
                      child: Text(
                        product.sizes![index]
                        ,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: screenHeight * .009),
                      ),
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _details({required double screenHeight,required BuildContext context}) {
    return Material(
      color: Theme
          .of(context)
          .primaryColor,
      elevation: 3,
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: screenWidth,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            product.details!,
            style: TextStyle(
              color: Theme
                  .of(context)
                  .textTheme
                  .bodySmall!
                  .color,
              fontSize: screenHeight * .015,
              overflow: TextOverflow.clip,
            ),
            textAlign: TextAlign.start,
            maxLines: 30,
            textDirection: TextDirection.rtl,
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
    );
  }
}


class ProductItem extends StatefulWidget {
  final Product product;
  final Admin admin;

  const ProductItem({Key? key, required this.product, required this.admin})
      : super(key: key);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  //var count=0;
  //bool liked=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var width = constraints.maxWidth;
      var height = constraints.maxHeight;

      return InkWell(
        onTap: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserProductView(
                  product: widget.product,
                  admin: widget.admin,
                ),
              ));
        },
        child: Material(
          borderRadius: BorderRadius.circular(5),
          color:Colors.white,
          elevation: 3,
          child: Stack(children: [
           /* Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),)

            ),*/


            Positioned(
              top: widget.admin.name == null ? 0 : height * 0.1,
              left: 0,
              right: 0,
              bottom: height * .15,
              child: _productImage(),
            ), //image

            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: height * 0.15,
                child: Column(
                  children: [
                    Container(
                      height: widget.admin.name == null
                          ? height * 0.14
                          : height * 0.05,
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: _price()
                                //HomePrice(product: widget.product,)
                                ,
                              ) //price,
                          ), //price

                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 2.0),
                              child: _likes()
                              // HomeLikes(product: widget.product,)
                              ,
                            ),
                          ) //likes
                        ],
                      ),
                    ), //price&likes



                  ],
                ),
              ),
            ), //likes,details

            Positioned(
              top: height * 0.0875,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: widget.product.sale!
                    ? CircleAvatar(
                  child: Image(
                    image: AssetImage('assets/images/sale.png'),
                  ),
                  radius: height * 0.05,
                  backgroundColor: Colors.white.withOpacity(0),
                )
                    : Container(),
              ),
            ), //saleTop





          ]),
        ),
      );
    });
  }





  _productImage() {
    return Container(
      decoration: BoxDecoration(


          image: DecorationImage(
            image: CachedNetworkImageProvider(
              widget.product.imageUrl!,
            ),
            fit: BoxFit.contain,
          )),
    ) //image

        ;
  }

  _likes() {
    return LayoutBuilder(builder: (context, constraints) {
      // var width=constraints.maxWidth;
      var height = constraints.maxHeight;

      return Container(
        //  color: Colors.red.withOpacity(.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.product.likes!.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .color!
                    .withOpacity(.5),
                fontSize:
                //12
                height * .6,

                // fontFamily: 'Pacifico'
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Icon(
                Icons.favorite,
                color: Colors.red.shade300,
                size: height * .6,
              ),
            )
          ],
        ),
      );
    });
  }



  _price() {

      return LayoutBuilder(builder: (context, constraints) {
        // var width=constraints.maxWidth;
        var height = constraints.maxHeight;

        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${widget.product.price!.toString()}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryTextTheme.subtitle1!.color,
                    fontSize: height * .5,
                    fontFamily:
                    Theme.of(context).primaryTextTheme.subtitle1!.fontFamily),
              ),
              Text(
                ' L.E ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context)
                      .primaryTextTheme.subtitle1!
                      .color!
                      .withOpacity(.5),
                  fontSize: height * .4,
                ),
              ),
            ],
          ),
        );
      });
    }

}








class MessageIcon extends StatefulWidget {
  final Admin admin;
  final Color messageColor;

  const MessageIcon({required this.admin, required this.messageColor});

  @override
  _MessageIconState createState() => _MessageIconState();
}

class _MessageIconState extends State<MessageIcon> {
  Duration myDuration = Duration(milliseconds: 300);
  double chatLeft = 0;
  double whatsLeft = 0;
  double phoneLeft = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            //color:   Colors.white.withOpacity(.5),
              borderRadius: BorderRadius.circular(10)),
          child: Stack(
            children: [
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
              ),

              AnimatedPositioned(
                left: chatLeft,
                duration: myDuration,
                child: InkWell(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.messageColor.withOpacity(.6),
                        image: DecorationImage(
                            image: AssetImage('assets/images/newChat.png'),
                            scale: 15)),
                  ),
                  borderRadius: BorderRadius.circular(20),
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UserChat(adminId: widget.admin.adminId!)),
                    );
                  },
                  hoverColor: Colors.red,
                  splashColor: Colors.yellow,
                ),
              ), //chat
              AnimatedPositioned(
                left: whatsLeft,
                duration: myDuration,
                child: InkWell(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.messageColor.withOpacity(.6),
                        image: DecorationImage(
                            image: AssetImage('assets/images/whatsapp.png'),
                            scale: 15)),
                  ),
                  borderRadius: BorderRadius.circular(20),
                  onTap: () async {
                    await launch(
                        'whatsapp://send?phone=+2${widget.admin.phone}');
                  },
                  hoverColor: Colors.red,
                  splashColor: Colors.yellow,
                ),
              ), //whatsapp
              AnimatedPositioned(
                left: phoneLeft,
                duration: myDuration,
                child: InkWell(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.messageColor.withOpacity(.6),
                        image: DecorationImage(
                            image: AssetImage('assets/images/phone.png'),
                            scale: 15)),
                  ),
                  borderRadius: BorderRadius.circular(20),
                  onTap: () async {
                    await launch('tel:+2${widget.admin.phone}');
                    //  Navigator.push(context,MaterialPageRoute(builder: (context) => UserChat(adminId: widget.adminId) ),);
                  },
                  hoverColor: Colors.red,
                  splashColor: Colors.yellow,
                ),
              ), //phone
              Positioned(
                left: 0,
                bottom: 0,
                child: InkWell(
                  child: Container(
                    height: 50,
                    width: 50,
                    foregroundDecoration: BoxDecoration(
                      // color: Colors.black.withOpacity(.5),
                      // shape: BoxShape.circle
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.messageColor,
                        image: DecorationImage(
                            image: AssetImage('assets/images/storeChat.png'),
                            scale: 20)),
                  ),
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    if (chatLeft == 0) {
                      setState(() {
                        chatLeft = 55;
                        whatsLeft = 110;
                        phoneLeft = 165;
                      });
                    } else {
                      setState(() {
                        chatLeft = 0;
                        whatsLeft = 0;
                        phoneLeft = 0;
                      });
                    }
                  },
                ),
              ),
            ],
          )),
    );
  }
}