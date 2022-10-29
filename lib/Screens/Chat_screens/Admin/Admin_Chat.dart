import 'dart:math';

import 'package:adminappp/Screens/Admin/admin_product_view/adminProductView.dart';
import 'package:adminappp/Screens/Chat_screens/User/User_chat.dart';
import 'package:adminappp/Screens/Chat_screens/chat_helper.dart';
import 'package:adminappp/Screens/strangers/stranger_userProfile.dart';
import 'package:adminappp/constants/MyIndicator.dart';
import 'package:adminappp/constants/My_Flush.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/massege_Info.dart';
import 'package:adminappp/constants/productInfo.dart';
import 'package:adminappp/constants/userInfo.dart';
import 'package:adminappp/providers/authProvider.dart';
import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/fireProvider.dart';
class AdminChat extends StatefulWidget {
  final String userId;

  const AdminChat({Key? key, required this.userId}) : super(key: key);
  static const   String route='/AdminChat';

  @override
  _AdminChatState createState() => _AdminChatState();
}

class _AdminChatState extends State<AdminChat> {
  GlobalKey<FormState>myKey=GlobalKey<FormState>();
  GlobalKey _globalKey=GlobalKey();
  String? text;
  List<Message> messages=[] ;
  TextEditingController textController=TextEditingController();
  UserInfoo userInfoo=UserInfoo();

 Future<bool>getUserInfoo()async{
   try{

     UserInfoo user1=await UserInfoo().getUserInfo(widget.userId);
     setState(() {
       userInfoo=user1;
     });
     return true;
   }on Exception {return false;}


  }
  adminSendMessage(BuildContext context)async{
    var myId= Provider.of<FireProvider>(context,listen: false).myId;
    if(textController.text==''){return;}
    var _text=textController.text;
    textController.clear();
    int ran=Random().nextInt(10000) ;

    await Message().adminSendMessage(Message(
        receiver: widget.userId,
        sender: myId!,
        text: _text,
        time: FieldValue.serverTimestamp(),
        productPhotoUrl: '',
        productId: '',
        isProduct: false,
      messageId: ran
      //date: DateTime.now()
    ));
  }
  adminMakeChatSeen()async{
    var myId= Provider.of<FireProvider>(context,listen: false).myId;
  await Message().adminMakeChatSeen(userId: widget.userId, myAdminId:myId! );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserInfoo();
    adminMakeChatSeen();
  }
int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    var myId =Provider.of<FireProvider>(context,listen: false).myId;
    return Scaffold(

      appBar: AppBar(

        title: UserPhotoAndName(),
        actions: [
         selectPhoto()
        ],
      ),




      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child:SingleChildScrollView(


                    reverse: true,
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    primary: true,
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: Message().streamAdminGetMessages(myAdminId:myId!, userId:widget. userId),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          QuerySnapshot<Map<String, dynamic>>? myStream= snapshot.data;

                          messages.clear();
                          var docs=myStream!.docs;
                          for(var doc in docs){
                            var data=doc.data();
                            messages.add(Message.i(data));
                           // messages.sort((a,b)=>b.date!.compareTo(a.date! ));
                          }
                        }






                        return Column(
                          children:messages.map((e) {
                           return Padding(
                              padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 5,top: 5),
                              child: Container(

                                alignment: e.sender==(myId)?Alignment.centerLeft:Alignment.centerRight,
                                child:

                                e.isProduct==false

                                    ?Material(
                                  color:e.sender==(myId)? Theme.of(context).primaryColor:Theme.of(context).primaryColorDark,
                                  elevation: 20,
                                  borderRadius: e.sender==(myId)
                                      ? BorderRadius.only(bottomRight: Radius.circular(20), topLeft: Radius.circular(20), topRight: Radius.circular(20),)
                                      : BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20), bottomRight: Radius.circular(20),)
                                  ,
                                  child: Container(

                                      padding: EdgeInsets.all(10),

                                      decoration: e.sender==(myId)
                                          ?
                                      BoxDecoration(
                                        borderRadius:  BorderRadius.only(bottomRight: Radius.circular(20), topLeft: Radius.circular(20), topRight: Radius.circular(20),),
                                      )
                                          :
                                      BoxDecoration(
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20), bottomRight: Radius.circular(20),),
                                      )
                                      ,

                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(e.text!,style: TextStyle(color: Theme.of(context).cardColor),),
                                      )),
                                )



                                    :InkWell(
                                  onTap: ()async{
                                     Product product=await Product().getProductInfo(productId: e.productId!);
                                     if(product.productId!=null){
                                       Navigator.push(context, MaterialPageRoute(builder: (context) => AdminProductView(product: product,),));
                                     }
                                     else{
                                       MyFlush().showFlush(context: context, text: 'product not exist');
                                     }



                                  },
                                      child: Material(
                                        color: Colors.white,
                                        elevation: 20,
                                        borderRadius: e.sender==(myId)
                                            ? BorderRadius.only(bottomRight: Radius.circular(30), topLeft: Radius.circular(30), topRight: Radius.circular(30),)
                                            : BorderRadius.only(bottomLeft: Radius.circular(30), topLeft: Radius.circular(30), bottomRight: Radius.circular(30),)
                                        ,

                                        child: Container(
                                  width: 100,height: 100,

                                        padding: EdgeInsets.all(10),

                                        decoration:e.sender==(myId)
                                            ?
                                        BoxDecoration(
                                            color:backColor1,
                                            borderRadius:  BorderRadius.only(bottomRight: Radius.circular(30), topLeft: Radius.circular(30), topRight: Radius.circular(30),),
                                            image: DecorationImage(image: NetworkImage(e.productPhotoUrl!),fit: BoxFit.cover),
                                            gradient:LinearGradient(
                                                begin:  Alignment.bottomLeft,
                                                end: Alignment.topRight,
                                                colors: [
                                                  Theme.of(context).primaryColorDark,
                                                  Theme.of(context).primaryColor,
                                                  Theme.of(context).primaryColor,
                                                  Theme.of(context).primaryColor,
                                                  Theme.of(context).primaryColor,
                                                  Theme.of(context).primaryColor,
                                                  Theme.of(context).primaryColor,
                                                  Theme.of(context).primaryColor,






                                                ]
                                            )
                                        )
                                            :

                                        BoxDecoration(
                                            color: color_b1,
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), topLeft: Radius.circular(30), bottomRight: Radius.circular(30),),
                                            image: DecorationImage(image: NetworkImage(e.productPhotoUrl!),fit: BoxFit.cover),
                                            gradient:LinearGradient(
                                                begin:  Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: [
                                                  Theme.of(context).primaryColor,
                                                  Theme.of(context).primaryColorDark,
                                                  Theme.of(context).primaryColorDark,
                                                  Theme.of(context).primaryColorDark,
                                                  Theme.of(context).primaryColorDark,
                                                  Theme.of(context).primaryColorDark,
                                                  Theme.of(context).primaryColorDark,
                                                  Theme.of(context).primaryColorDark,
                                                  Theme.of(context).primaryColorDark,
                                                  Theme.of(context).primaryColorDark,
                                                  Theme.of(context).primaryColorDark,





                                                ]
                                            )


                                        ),
                                   ),
                                      ),
                                    ),

                              ),
                            );










                          }).toList() ,

                        );
                      }
                    ),
                  )




              ),
            ),


            Container(
              color: Theme.of(context).primaryColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  ChatTextField(textController: textController,
                  //  key: _globalKey
                    ),

                  InkWell(
                      onTap: (){
                        adminSendMessage( context);

                      },
                      radius: 50,

                      child: Container(
                        width: 50,height: 50,


                          child: Icon(Icons.send,color: Theme.of(context).cardColor,size: 30,))),
                ],
              ),

            )
          ],
        ),
      ),
    );
  }

 Widget  UserPhotoAndName(){
    return InkWell(
      onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context) => StrangerUser(userInfoo: userInfoo,),) );},
      child: Row(
        children: [
          userInfoo.photo==null
              ?myShimmer(color: Theme.of(context).primaryColorLight)
              : Material(
            type: MaterialType.circle,
              color: Theme.of(context).cardColor,
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: CircleAvatar(backgroundImage: CachedNetworkImageProvider(userInfoo.photo! ),),
              )
          ),







          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Text(  userInfoo.name==null?'':userInfoo.name.toString(),style: TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.w700),),
          ),
        ],
      ),
    );
 }
 Widget  selectPhoto(){

    return  Ebotton(
        backgroundcolor: Theme.of(context).primaryColor ,
        borderColor: backColor2,

        onpressed: ()async{
          var myId= Provider.of<FireProvider>(context,listen: false).myId;
          List<Product> products=await Product().getMyProducts(myId!);

          await  showDialog(
            context: context,
            builder: (context) =>Dialog(
              backgroundColor: backColor1,
              child:  AdminProductsDialog(products:products,userId: widget.userId,),
            ) ,




          );



        },




        child: Text('اختر صوره',style: TextStyle(color: Theme.of(context).cardColor,fontSize: 12),));
 }


}

class AdminProductsDialog extends StatefulWidget {
  final List<Product>products;
  final String userId;
  const AdminProductsDialog({Key? key, required this.products, required this.userId}) : super(key: key);

  @override
  _AdminProductsDialogState createState() => _AdminProductsDialogState();
}

class _AdminProductsDialogState extends State<AdminProductsDialog> {
   int? selectedIndex;
   Product? selectedProduct;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*.5,
      height: MediaQuery.of(context).size.height*.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20)
      ),

      child: Column(
        children: [
          Expanded(
            child: Container(

              decoration: BoxDecoration(
                color: Theme.of(context).cardColor

              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 100,
                ),


                itemCount: widget.products.length,

                itemBuilder: (context, index)


                =>InkWell(
                  onTap: (){
                    setState(() {
                      selectedIndex=index;
                      selectedProduct=widget.products[index];
                    });
                  },
                  child: Container(
                    // height: 50,width: 50,
                    decoration: BoxDecoration(
                     border:Border.all(width: 5,color: index==selectedIndex?Theme.of(context).primaryColor:Colors.white.withOpacity(0),),

                        image: DecorationImage(
                            image: NetworkImage(widget.products[index].imageUrl!),

                            //index==selectedIndex?20:.9

                        )
                    ),
                  ),
                )
                ,






              ),
            ),
          ),



          ConstrainedBox(
            constraints:BoxConstraints( maxHeight: 50,minHeight: 50,
              maxWidth: MediaQuery.of(context).size.width,minWidth: MediaQuery.of(context).size.width,) ,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              color: Theme.of(context).cardColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Ebotton( child: Text('إرسال',style: TextStyle(color: Theme.of(context).cardColor)),
                    borderRadius: 10,
                    backgroundcolor: Theme.of(context).primaryColor,
                    borderColor: Colors.white.withOpacity(0),

                    onpressed: ()async{
                      int ran=Random().nextInt(10000) ;

                      var myId= Provider.of<FireProvider>(context,listen: false).myId;

                      if(selectedProduct!=null){
                        Navigator.pop(context);
                        await Message().adminSendMessage(
                            Message(
                                isProduct: true,
                                productId: selectedProduct!.productId,
                                productPhotoUrl: selectedProduct!.imageUrl,
                                time: FieldValue.serverTimestamp(),
                                text: '',
                                sender: myId!,
                                receiver: widget.userId,
                              messageId: ran

                            ));}
                      else{
                       await  MyFlush().showFlush(context: context, text: 'إختر صوره');}
                      },),

                  Ebotton(
                      onpressed: (){Navigator.pop(context);},

                      child: Text('إغلاق',style: TextStyle(color: Theme.of(context).cardColor),),
                    borderColor: Colors.white.withOpacity(0),
                    backgroundcolor: Theme.of(context).primaryColor,
                    borderRadius: 10,

                  ),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}

