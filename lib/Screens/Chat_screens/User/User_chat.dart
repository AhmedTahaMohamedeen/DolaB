

import 'dart:math';

import 'package:adminappp/Screens/Chat_screens/chat_helper.dart';
import 'package:adminappp/Screens/User/user_product_view/user_product_view.dart';
import 'package:adminappp/Screens/strangers/stranger_store_profile/stranger_store_profile.dart';
import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/MyIndicator.dart';
import 'package:adminappp/constants/My_Flush.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/massege_Info.dart';
import 'package:adminappp/constants/productInfo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/fireProvider.dart';
class UserChat extends StatefulWidget {
  static const   String route='/newChat';

  final String adminId;

  const UserChat({required this.adminId}) ;

  @override
  _UserChatState createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  GlobalKey<FormState>myKey=GlobalKey<FormState>();


String? text;
  List<Message> messages=[] ;
  Admin admin=Admin();
  TextEditingController textController=TextEditingController();

  Future<bool>getAdminInfo()async{

    try{
      var admin1=await Admin().getAdminData(widget.adminId);
      setState(() {
        admin=admin1;
      });

      return true;
    }
    on Exception {return false;}

  }

  userMakeChatSeen()async{
    var myId = Provider.of<FireProvider>(context, listen: false).myId;
   await Message().userMakeChatSeen(myUserId:myId! , adminId: widget.adminId);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAdminInfo();
    userMakeChatSeen();
  }
  @override
  Widget build(BuildContext context) {
    var myId = Provider.of<FireProvider>(context, listen: false).myId;
    return Scaffold(

      appBar: AppBar(


        title: adminPhotoAndName(),
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
                 // dragStartBehavior: DragStartBehavior.start ,
                  reverse: true,
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  primary: true,
                  child: StreamBuilder< QuerySnapshot<Map<String, dynamic>>>(
                    stream: Message().streamUserGetMessages(adminId: widget.adminId, myUserId: myId!),
                    builder: (context, snapshot) {
                      debugPrint('stream');
                        if(snapshot.hasData) {
                          QuerySnapshot<Map<String, dynamic>>? myStream = snapshot.data;

                          messages.clear();
                          var docs = myStream!.docs;
                          for (var doc in docs) {
                            var data = doc.data();
                            messages.add(Message.i(data));
                           // messages.sort((a,b)=>a.date!.compareTo(b.date! ));
                          }
                        }



                      return Column(



                        children:messages.map((e) =>

                            Padding(
                              padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 5,top: 5),
                              child: Container(

                                alignment: e.sender==(myId)?Alignment.centerLeft:Alignment.centerRight,
                                child:e.isProduct==false
                                    ? Material(
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
                                   // Admin admin=await Admin().getAdminData(widget.adminId);
                                    if(product.productId!=null){
                                           Navigator.push(context, MaterialPageRoute(builder: (context) => UserProductView(product: product,admin: admin,),));}
                                    else{
                                            MyFlush().showFlush(context: context, text: 'product not exist');}
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
                            ),









                        ).toList() ,

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

                  ChatTextField(textController: textController),

                  InkWell(
                    onTap: (){
                     userSendMessage(context);

                    },
                      radius: 50,

                      child: Container(
                        height: 50,width: 50,


                          child: Icon(Icons.send,color: Theme.of(context).cardColor,size: 30,))),
                ],
              ),

            )
          ],
        ),
      )


    );
  }

   Widget selectPhoto(){
    return  Ebotton(
        backgroundcolor: Theme.of(context).primaryColor ,
        borderColor: backColor2,

        onpressed: ()async{

          List<Product> products=await Product().getMyProducts(widget.adminId);

          await  showDialog(
            context: context,
            builder: (context) =>Dialog(
              backgroundColor: backColor1,
              child: UserSelectProductDialog(products: products,adminId:widget.adminId ,),) ,);},


        child: Text('اختر صوره',style: TextStyle(color:Theme.of(context).cardColor,fontSize: 12),));
   }
   Widget adminPhotoAndName(){
    return InkWell(
      onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context) => StrangerStore(admin: admin,),) );},
      child: Row(
        children: [
          admin.photoUrl==null?myShimmer(color: Theme.of(context).primaryColorLight)
              : Material(
            type: MaterialType.circle,
            color: Theme.of(context).cardColor,
            elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(admin.photoUrl! ),
          ),
                ),
              ),




        Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(admin.name==null?'':admin.name.toString(),style: TextStyle(color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.w700),),
          ),
        ],
      ),
    );
   }

  userSendMessage(BuildContext context)async{
    var myId =Provider.of<FireProvider>(context,listen: false).myId;
    int ran=Random().nextInt(10000) ;

    if(textController.text==''){return;}
    var _text=textController.text;
    textController.clear();
    await Message().userSendMessage(Message(
        receiver: widget.adminId,
        sender: myId,
        text: _text,
        time: FieldValue.serverTimestamp(),
        productPhotoUrl: '',
        productId: '',
        isProduct: false,
      messageId: ran
      //date: DateTime.now()
    ));

/*  if(!myKey.currentState!.validate()){return;}
  else {
    myKey.currentState!.save();
    myKey.currentState!.reset();
    await Message().userSendMessage(Message(
        receiver: widget.adminId,
        sender: auth.user!.uid,
        text: textController.text,
      time: FieldValue.serverTimestamp(),
      productPhotoUrl: '',
      productId: '',
      isProduct: false
      //date: DateTime.now()
    ));


  }*/

  }

}




