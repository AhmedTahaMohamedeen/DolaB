
// ignore_for_file: file_names, use_key_in_widget_constructors, avoid_debugPrint

import 'dart:io';

import 'package:adminappp/Screens/User/user_product_view/user_product_helper.dart';
import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/MyIndicator.dart';
import 'package:adminappp/helper_methods/helper_methods1.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../constants/Categories.dart';
import '../../../constants/deviceInfo.dart';
import '../../../providers/fireProvider.dart';
import '../../Show_Photo.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/productInfo.dart';
import 'package:flutter/material.dart';

import '../PeopleLikes.dart';
import '../admin_store_profile/StoreProfile.dart';
import '../edit_product/editProductScreen.dart';

class AdminProductView extends StatefulWidget {
  static const String route='/AdminProductView';
  final Product product;
  //final Admin admin;

  const AdminProductView({Key? key, required this.product,
   // required this.admin
  }) : super(key: key);


  @override
  _AdminProductViewState createState() => _AdminProductViewState();
}

class _AdminProductViewState extends State<AdminProductView> {
  GlobalKey _globalKey=GlobalKey();
  Admin? admin;
  Product? product;
int? likes;
int? views;
  String duration='none';
  getAdminData()async{
   // var userId=Provider.of<AuthProvider>(context,listen: false).user!.uid;
    var admin1=await Admin().getAdminData(widget.product.userId!);
    setState(() {admin=admin1;});
  }
  getProductInfo()async{
    var product1=await Product().getProductInfo(productId: widget.product.productId!);
    setState(() {
      product=product1;

    });



  }

  getLikesAndViews()async{
  int likes1= await  Product().likesNum(widget.product.productId!, widget.product.userId!);
  int views1= await  Product().viewsNum(widget.product.productId!, widget.product.userId!);
  setState(() {
    likes=likes1;
    views=views1;

  });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAdminData();
    getProductInfo();
    getLikesAndViews();
    duration = HelperMethods.getDuration(product: widget.product);

  }


  @override
  Widget build(BuildContext context) {



Color floatingColor =backColor1;

Color pageColor =backColor1;

if (admin==null){
  return
    Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: myShimmer(color: Theme.of(context).primaryColor),
      ),
    );
}

else{

  return InfoWidget(
    builder: (context,deviceInfo) {
      print(deviceInfo.deviceType.toString());
      print(deviceInfo.orientation.toString());

      double? screenHeight=deviceInfo.screenHeight;
      double? screenWidth=deviceInfo.screenWidth;
      if(deviceInfo.orientation==Orientation.landscape){
        screenWidth=deviceInfo.screenHeight;
        screenHeight=deviceInfo.screenWidth;
      }
      return Scaffold(

        appBar: AppBar(
          elevation: 1,





          actions: [
            _editingIcon(height: screenHeight!,width: screenWidth!),



          ],
        ),


        body:
       product==null?Center(child: myShimmer(color: Theme.of(context).primaryColor),)

           :
       SafeArea(
         child: Stack(
             children: [



               Positioned(
                 top: 0,right: 0,left: 0,bottom: 0,
                 child: SingleChildScrollView(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [

                       SizedBox(height: screenHeight*.010,),
                      // ProductImage(product:product!,localHeight: screenHeight*.6,)

                    AdminProductImage(product:product!,iconsColor: pageColor,localHeight: screenHeight*.6,)//image
                       ,
                       SizedBox(height: screenHeight*.01,),

                   Material(
                     borderRadius: BorderRadius.circular(10),
                     color: Theme.of(context).cardColor,
                     elevation:100,
                     shadowColor: Theme.of(context).primaryColor,
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Column(
                         children: [

                           Container(
                               height:  screenHeight*.05,
                               width: deviceInfo.screenWidth,
                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),),
                               child: PriceAndDate(localHeight:screenHeight*.05 ,duration: duration,product: product!,)
                           ),//price&Date

                           SizedBox(height: screenHeight*.010,),


                           Material(
                             borderRadius: BorderRadius.circular(15),
                             color: Theme.of(context).cardColor,
                             elevation:70,
                             child: Container(
                               height: screenHeight*.044,
                               width: deviceInfo.screenWidth,
                               //color: Colors.white.withOpacity(.2),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 children: [

                                   _views(height: screenHeight*.04),
                                   _likes(height: screenHeight*.04),

                                 ],
                               ),
                             ),
                           ),//likes&likeButton&price
                         ],
                       ),
                     ),
                   ),


                       SizedBox(height: screenHeight*.01,),


                       Material(
                         borderRadius: BorderRadius.circular(20),
                         color: Colors.white,
                         elevation: 100,
                         shadowColor: Theme.of(context).primaryColor,
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: DetailsAndSizes(
                             screenHeight: screenHeight,
                             screenWidth: screenWidth,
                             product: product!,

                           ),
                         ),
                       ),






                       SizedBox(height: MediaQuery.of(context).size.height*.150,),




                     ],
                   ),
                 ),
               )
               ,



               MyFloating(key: _globalKey,myLoc1: myLoc.none,floatingColor: null,)

             ]  ),
       )



      );
    }
  );



}


  }
















Widget _editingIcon({required double height,required double width}){
    return   Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        child: Icon(Icons.settings,
          color: Theme.of(context).primaryColor,
          //size: height*.03,


        ),
        onTap: (){
          showDialog(context: context, builder: (context) {
            return

              Dialog(
                  backgroundColor: Theme.of(context).dialogBackgroundColor.withOpacity(.5),

                 // elevation: 50,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),

                  child: Container(
                    height: 100,
                   // width: 100,

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [

                        Container(
                          width: 150,
                          child: EbottonI(
                            borderColor: Colors.white.withOpacity(0),
                            onpressed: (){
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => EditProductScreen(admin: admin!,product: product!,),));},
                            child: Text('تعديل المنتج',
                              style: TextStyle(color:  Theme.of(context).primaryColor.withOpacity(1)),),

                            icon:  Icon(
                              Icons.edit,
                              color: Theme.of(context).primaryColor,),
                            backgroundcolor:  Theme.of(context).cardColor,
                            borderRadius: 10,
                            elevation: 5,

                          ),
                        ),
                        Container(
                          width: 150,
                          child: EbottonI(
                            borderColor: Colors.white.withOpacity(0),
                            borderRadius: 10,
                            onpressed: (){
                              showDialog(context: context, builder: (context) =>
                                  AlertDialog(
                                    backgroundColor: Theme.of(context).cardColor,
                                    //content: Container(height: 200,width: 200,),
                                    title:  Text('هل أنت متأكد ؟',style: TextStyle(color: Theme.of(context).primaryColor)),
                                    actions: [
                                      Ebotton(onpressed: ()async{
                                        MyIndicator().loading(context);
                                        await Product().removeProduct(
                                          productId: widget.product.productId!,
                                          userId: widget.product.userId!
                                          ,photoLoc: widget.product.photoLoc!,
                                          photoLoc1: widget.product.photoLoc1!,
                                          photoLoc2: widget.product.photoLoc2!,
                                          photoLoc3: widget.product.photoLoc3!,
                                          photoLoc4: widget.product.photoLoc4!,
                                        );
                                        Navigator.pop(context);
                                        Navigator.pushNamedAndRemoveUntil(context, StoreProfileScreen.route, (route) => false);
                                      }
                                          , child: Text('نعم',style: TextStyle(color: Theme.of(context).primaryColor)),
                                      backgroundcolor: Theme.of(context).cardColor,
                                      borderRadius: 10,elevation: 3),


                                      Ebotton(onpressed: (){Navigator.pop(context);}, child:  Text('لا',style: TextStyle(color: Theme.of(context).primaryColor))
                                      ,backgroundcolor: Theme.of(context).cardColor,
                                      borderRadius: 10,elevation: 3),
                                    ],

                                  ) ).then((value) => debugPrint('done'));
                            },
                            child: Text('حذف المنتج',style: TextStyle(color:Theme.of(context).primaryColor),),
                            icon:  Icon(Icons.delete,color: Theme.of(context).primaryColor,),
                            backgroundcolor:  Theme.of(context).cardColor,


                          ),
                        ),
                      ],
                    ),


                  ))




            ;
          })
          ; },

      ),
    );
}


  Widget _share(){
    return
      InkWell(
        onTap: ()async{
          final imageUrl=product!.imageUrl!;
          final url=Uri.parse(imageUrl);
          final response=await http.get(url);
          final bytes=response.bodyBytes;
          final temp=await getTemporaryDirectory();
          final path='${temp.path}/image.jpg';
          File(path).writeAsBytesSync(bytes);

          await Share.shareFiles([path],text: '');


        },
        child: Icon(Icons.share,
            color: Theme.of(context).cardColor.withOpacity(.7),
            ),
      )
    ;
  }





  Widget _likes({required double height}){
    return   InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => PeopleLikes(product: product!,),));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Icon(Icons.favorite_outlined,color: Colors.red),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
               // product!.likes!.toString()
                likes.toString()

                ,
                style:  TextStyle(color:  Theme.of(context).primaryColorDark,
                  fontSize: height*.4


                ),),
            ),





          ],
        ),
      ),
    );
  }


  Widget _views({required double height}){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child:
          Text('مشاهدة', style: TextStyle(

              color: Theme.of(context). primaryColorDark,


              fontSize: height*.4),),
         //Icon(Icons.remove_red_eye,color: Theme.of(context).cardColor.withOpacity(.5),)
        ),
        Text(
         // product!.views.toString()
    views.toString()

          ,
          style: TextStyle(
              color:  Theme.of(context).primaryColorDark,
              fontSize: height*.5

          ),)

      ],
    );
  }














}









class AdminProductImage extends StatefulWidget {
  final Product product;
  final Color iconsColor;
  final double localHeight;
  const AdminProductImage({required this.product,required this.iconsColor,required this.localHeight});

  @override
  _AdminProductImageState createState() => _AdminProductImageState();
}


class _AdminProductImageState extends State<AdminProductImage> {
  int current=0;
  List imagesList=[];

  makeList(){

    List<String> x0=[];
    List<String> x1=[];
    List<String> x2=[];
    List<String> x3=[];
    List<String> x4=[];
    List<String> x5=[];
    setState(() {
      x0.add( widget.product.imageUrl!);
      setState(() {
        x1=x0;
      });
    });
    if( widget.product.imageUrl1!='none')
    {setState(() {x1.add(widget.product.imageUrl1!); x2=x1;});}
    else{setState(() { x2=x1;});}
    if( widget.product.imageUrl2!='none')
    {setState(() {x2.add(widget.product.imageUrl2!); x3=x2;});}
    else{setState(() { x3=x2;});}

    if( widget.product.imageUrl3!='none')
    {setState(() {x3.add(widget.product.imageUrl3!);  x4=x3;});}
    else{setState(() { x4=x3;});}

    if( widget.product.imageUrl3!='none')
    {setState(() {x4.add(widget.product.imageUrl4!); x5=x4;});}
    else{setState(() { x5=x4;});}
    setState(() {
      imagesList=x5;

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
    return  InfoWidget(
        builder: (context,deviceInfo) {
          double? localHeight=widget.localHeight;
          print('localll =$localHeight');
          double? localWidth=deviceInfo.localWidth;
          print('localll =$localWidth');
          double? screenHeight=deviceInfo.screenHeight;
          double? screenWidth=deviceInfo.screenWidth;

          return Material(
            color: Theme.of(context).cardColor,
            elevation: 100,
            borderRadius: BorderRadius.circular(20),
            shadowColor: Theme.of(context).primaryColor,
            child: SizedBox(
              height: widget.localHeight,
              width: screenWidth,
              child: Stack(

                children: [
                  Positioned(
                    top: 0,right: 0,left: 0,bottom: 0,
                    child: PageView.builder(
                      itemCount: imagesList.length,
                      onPageChanged: (s){setState(() {current=s;});},
                      controller: PageController(initialPage: current,),



                      itemBuilder: (context, index) =>  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(

                          onTap: (){Navigator.pushNamed(context, ShowPhoto.route,arguments:imagesList[current] );},
                          child: imagesList.length==0?Text('loading'):
                          Stack(
                            children: [
                              Positioned(
                                child: Container(
                                  height: localHeight,
                                  width:  localWidth,


                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: CachedNetworkImageProvider(imagesList[current]),fit: BoxFit.contain,scale: 100, ),

                                    // borderRadius: BorderRadius.circular(50)
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                // left:0 ,
                                // right: 0,
                                child: Container(
                                  //  color: Colors.black.withOpacity(.1),
                                  width: screenWidth,
                                  height: localHeight*.1,





                                  child:imagesList.length==1
                                      ? SizedBox()
                                      : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: imagesList.map((e) =>


                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                            child: Container(
                                              width:  imagesList.indexOf(e)==current?
                                              localHeight*.1: localHeight*.05,
                                              height:  imagesList.indexOf(e)==current?
                                              localHeight*.1: localHeight*.05,
                                              decoration: BoxDecoration(
                                                // color: Colors.red,
                                                  borderRadius: BorderRadius.circular(10),
                                                  boxShadow: [BoxShadow(color: Colors.black,blurRadius: 10)],

                                                  image: DecorationImage(
                                                    image: CachedNetworkImageProvider(e),fit: BoxFit.contain,
                                                  )
                                                //



                                              ),
                                            ),
                                          )








                                      ).toList()
                                  ),
                                ),
                              ),


                            ],
                          ),
                        ),
                      ),
                    ),
                  ),


                  Positioned(
                    top:  10,
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
                        localHeight!*.08
                        ,
                        backgroundColor: Colors.white.withOpacity(0),
                      )

                          :Container()
                      ,
                    ),
                  ),//saleTop
                ],
              ),
            ),
          );
        }
    );
  }



  Widget _share(BuildContext context){
    return
      InkWell(
        onTap: ()async{
          final imageUrl=imagesList[current]!;
          final url=Uri.parse(imageUrl);
          final response=await http.get(url);
          final bytes=response.bodyBytes;
          final temp=await getTemporaryDirectory();
          final path='${temp.path}/image.jpg';
          File(path).writeAsBytesSync(bytes);

          await Share.shareFiles([path],text: '');
          Navigator.pop(context);


        },
        child: Container(
            width: MediaQuery.of(context).size.width*.5,
            height: 25,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: widget.iconsColor,
                borderRadius: BorderRadius.circular(10)
            ),

            child: Text('مشاركه',style: TextStyle(color: Colors.white,),)

        ),
      )
    ;
  }
}









