import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/followInfo.dart';
import 'package:adminappp/constants/userInfo.dart';
import 'package:adminappp/providers/authProvider.dart';
import 'package:adminappp/providers/fireProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../strangers/stranger_userProfile.dart';
class FollowersScreen extends StatefulWidget {
  static const   String route='/FollowersScreen';

  const FollowersScreen({Key? key}) : super(key: key);

  @override
  _FollowersScreenState createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  List<UserInfoo>usersList=[];
  getFollowers()async{
    var myId=Provider.of<FireProvider>(context,listen: false).myId;
   List<UserInfoo> followers= await Follow().getFollowers(adminId: myId!);
   setState(() {
     usersList=followers;
   });
   //debugPrint('null${followers.toString()}');


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFollowers();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor1,
      appBar: AppBar(
        title: const Text('المتابعين'),
        backgroundColor:backColor1 ,

      ),
      body: Stack(
          children:[
            SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
            // MyFloating()
            ListView.separated(
              separatorBuilder: (context, index) => Divider(color: Colors.black,height: 1,),

              itemCount: usersList.length,
              padding:  EdgeInsets.all(10.0),

              itemBuilder: (context, index)
                  {
                   // debugPrint('ss ${usersList[index].name!}');
                    return
                      InkWell(
                        child: Padding(
                        padding: const EdgeInsets.all(0.0),
                             child: Container(
                              height: 50,
                               //decoration: BoxDecoration(color: Colors.white.withOpacity(.5),),
                               child:Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Row(
                                    children: [
                                      usersList[0].city==null?Text(''): Text('${usersList[index].city!}',style: TextStyle(color: Colors.white),),

                                    ],
                                   ),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.end,
                                     children: [
                                       usersList[0].name==null?Text(''): Text(usersList[index].name!,style: TextStyle(fontSize: 10,color: Colors.white),),
                                       usersList[0].photo==null?Text(''): CircleAvatar(backgroundImage: CachedNetworkImageProvider(usersList[index].photo!),)
                                     ],
                                   ),
                                 ],
                               )



                ),
              ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => StrangerUser(userInfoo:usersList[index] ,),));
                        },
                      );
                  }
            )

          ]
      ),
    /*  floatingActionButton: FloatingActionButton(
        onPressed: ()async{

        },
        child: Text(''),
      ),*/

    );
  }
}
