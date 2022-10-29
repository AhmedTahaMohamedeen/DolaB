import 'package:adminappp/Screens/Chat_screens/Admin/Admin_Chat.dart';
import 'package:adminappp/constants/constantss.dart';

import 'package:adminappp/constants/massege_Info.dart';
import 'package:adminappp/constants/userInfo.dart';
import 'package:adminappp/providers/authProvider.dart';
import 'package:adminappp/providers/fireProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminMessages extends StatefulWidget {
  static const   String route='/AdminMessages';

  const AdminMessages({Key? key}) : super(key: key);

  @override
  _AdminMessagesState createState() => _AdminMessagesState();
}

class _AdminMessagesState extends State<AdminMessages> {

  List<UserInfoo> adminChatList=[];

  getChats(BuildContext context)async{
    var myId =Provider.of<FireProvider>(context,listen: false).myId;

   List<UserInfoo> adminChatList1=await  Message().getAdminsChatList(myAdminId:myId!);
   setState(() {

     adminChatList=adminChatList1.reversed.toList();
   });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChats( context);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          title: Text('رسائل المتجر')
      ),
      body:Container(
        child: ListView.builder(
            itemCount:  adminChatList.length,
            itemExtent: 70,



            itemBuilder: (context, index) =>


                AdminChatUnit(userInfoo: adminChatList[index],)


        ),

      ),





    );
  }
}



class AdminChatUnit extends StatefulWidget {
  final UserInfoo userInfoo;
  const AdminChatUnit({Key? key, required this.userInfoo,}) : super(key: key);

  @override
  State<AdminChatUnit> createState() => _AdminChatUnitState();
}

class _AdminChatUnitState extends State<AdminChatUnit> {
  bool adminIsSeen=false;
adminCheckSeen()async{
  var myId =Provider.of<FireProvider>(context,listen: false).myId;
 bool x=await Message().adminCheckIsSeen(userId: widget.userInfoo.uid!, myAdminId: myId!);
 setState(() {
   adminIsSeen=x;
 });

}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    adminCheckSeen();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onLongPress: ()async{
          showDialog(context: context,
            builder: (context) => Dialog(
              child: Container(
                height: 100,width: 250,
                child: Ebotton(
                  child: Text('مسح'),
                  onpressed: ()async{
                    var auth =Provider.of<AuthProvider>(context,listen: false);
                    if(await Message().deleteAdminChat(userId: widget.userInfoo.uid!, myAdminId: auth.user!.uid))
                    {Navigator.pushNamed(context, AdminMessages.route);}
                  },
                ),
              ),
            )
            ,);
        },
        onTap: (){
          setState(() {
            adminIsSeen=true;
          });
          Navigator.push(context, MaterialPageRoute(builder:(context) => AdminChat(userId:widget.userInfoo.uid!),));
        },
        child:


        Material(
          color: adminIsSeen?Theme.of(context).cardColor:Theme.of(context).primaryColorLight,
          elevation: 3,
          borderRadius: BorderRadius.circular(10),

          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Material(
                    type: MaterialType.circle,
                      elevation: 2,
                      color: Theme.of(context).cardColor,

                      child: Padding(
                    padding: const EdgeInsets.all(3.0),
                          child: CircleAvatar(backgroundImage: CachedNetworkImageProvider(widget.userInfoo.photo!),radius: 30,),
                  )),

                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(widget.userInfoo.name! ,
                      style: TextStyle(
                    color: adminIsSeen?  Theme.of(context).primaryColor: Theme.of(context).cardColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800
                    ),),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text( adminIsSeen?'':'رساله جديده',style: TextStyle(color: Theme.of(context).primaryColorDark,fontSize: 10),),
              )


            ],
          ),
        ),
      ),
    );
  }
}









