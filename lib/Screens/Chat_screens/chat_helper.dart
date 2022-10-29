



import 'dart:math';

import 'package:adminappp/constants/My_Flush.dart';
import 'package:adminappp/constants/massege_Info.dart';
import 'package:adminappp/constants/productInfo.dart';
import 'package:adminappp/providers/fireProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constantss.dart';

class UserSelectProductDialog extends StatefulWidget {
  final List<Product>products;
  final String adminId;
  const UserSelectProductDialog({Key? key, required this.products, required this.adminId,}) : super(key: key);

  @override
  _UserSelectProductDialogState createState() => _UserSelectProductDialogState();
}

class _UserSelectProductDialogState extends State<UserSelectProductDialog> {
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
                          image: CachedNetworkImageProvider(widget.products[index].imageUrl!),

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
                  Ebotton(
                    child: Text('إرسال',style: TextStyle(color: Theme.of(context).cardColor)),
                    borderRadius: 10,
                    backgroundcolor: Theme.of(context).primaryColor,
                    borderColor: Colors.white.withOpacity(0),
                    onpressed: ()async{
                      int ran=Random().nextInt(10000) ;
                      var myId =Provider.of<FireProvider>(context,listen: false).myId;

                      if(selectedProduct!=null){
                        Navigator.pop(context);
                        await Message().userSendMessage(
                            Message(
                                isProduct: true,
                                productId: selectedProduct!.productId,
                                productPhotoUrl: selectedProduct!.imageUrl,
                                time: FieldValue.serverTimestamp(),
                                text: '',
                                sender: myId,
                                receiver: widget.adminId,
                                messageId: ran
                            ));}
                      else{
                        await  MyFlush().showFlush(context: context, text: 'إختر صوره');}
                    },),

                  Ebotton(
                    onpressed: (){Navigator.pop(context);},


                    child: Text('إغلاق',style: TextStyle(color: Theme.of(context).cardColor),),
                    backgroundcolor: Theme.of(context).primaryColor,
                    borderColor: Colors.white.withOpacity(0),
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














class ChatTextField extends StatefulWidget {
  final TextEditingController textController;
  const ChatTextField({Key? key, required this.textController}) : super(key: key);

  @override
  _ChatTextFieldState createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  double borderWidth = .5;
  Color borderColor = Colors.white.withOpacity(.2);

  double borderRadus = 5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width*.8,
          // height: 40,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(.2),
              border: Border.all(color: Colors.white.withOpacity(.1)),
              borderRadius: BorderRadius.circular(10)
          ),
          child:ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 100,

              //  minHeight: 60
            ),
            child: TextField(
              style: TextStyle(color: Colors.white),
              minLines: 1,
              maxLines: 3,
              controller: widget.textController,

              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom:12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadus),
                    borderSide: BorderSide(color: borderColor, width: borderWidth),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadus),
                    borderSide: BorderSide(color: borderColor, width: borderWidth),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadus),
                    borderSide: BorderSide(color: borderColor, width: borderWidth),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadus),
                    borderSide: BorderSide(color: borderColor, width: borderWidth),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadus),
                    borderSide: BorderSide(color: borderColor, width: borderWidth),
                  )
              )
              ,textAlign: TextAlign.right,
              cursorColor: Colors.white,






            ),
          )



      ),
    );
  }
}