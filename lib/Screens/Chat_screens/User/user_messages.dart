import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/massege_Info.dart';
import 'package:adminappp/providers/authProvider.dart';
import 'package:adminappp/providers/fireProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'User_chat.dart';
class UserMessages extends StatefulWidget {
  static const   String route='/UserMessages';
  const UserMessages({Key? key}) : super(key: key);

  @override
  _UserMessagesState createState() => _UserMessagesState();
}

class _UserMessagesState extends State<UserMessages> {
  List<Admin> userChatList=[];


  getChats(BuildContext context)async{
    var myId =Provider.of<FireProvider>(context,listen: false).myId;
    List<Admin> userChatList1=await  Message().getUsersChatList(myUserId: myId!);

    setState(() {
      userChatList=userChatList1.reversed.toList();

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
       title: Text('الرسائل الشخصيه'),
      ),
      body:  ListView
          .builder
        (
        itemCount:  userChatList.length,
        itemExtent: 70,


        itemBuilder: (context, index) => UserChatUnit(admin: userChatList[index],),),
    );
  }
}

class UserChatUnit extends StatefulWidget {
  final Admin admin;
  const UserChatUnit({Key? key, required this.admin}) : super(key: key);

  @override
  _UserChatUnitState createState() => _UserChatUnitState();
}

class _UserChatUnitState extends State<UserChatUnit> {
  bool userIsSeen=false;
  userCheckSeen()async{
    var myId =Provider.of<FireProvider>(context,listen: false).myId;

    bool x=await Message().userCheckIsSeen(myUserId: myId!, adminId: widget.admin.adminId!);
    setState(() {
      userIsSeen=x;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userCheckSeen();
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
                    var myId =Provider.of<FireProvider>(context,listen: false).myId;
                    if(await Message().deleteUserChat(adminId:  widget.admin.adminId!, myUserId: myId!))
                    {Navigator.pushNamed(context, UserMessages.route);}
                  },
                ),
              ),
            )
            ,);
        },
        onTap: (){
          setState(() {
            userIsSeen=true;
          });
          Navigator.push(context, MaterialPageRoute(builder: (context) =>UserChat(adminId:widget.admin.adminId! ,),));
        },
        child: Material(
          color: userIsSeen?Theme.of(context).cardColor:Theme.of(context).primaryColorLight,
          elevation: 3,
          borderRadius: BorderRadius.circular(10),


          child: Row(
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
                      child: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(widget.admin.photoUrl!,),radius: 30,

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(widget.admin.name!,
                      style: TextStyle(
                          color: userIsSeen? Theme.of(context).primaryColor: Theme.of(context).cardColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w800
                      ),


                    ),
                  )
                ],
              ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text( userIsSeen?'':'رساله جديده',style: TextStyle(color: Theme.of(context).primaryColorDark,fontSize: 10),),
             )


            ],
          ),
        ),
      ),
    );
  }
}
