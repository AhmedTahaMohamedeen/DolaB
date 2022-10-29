import 'package:adminappp/Screens/Admin/admin_store_profile/StoreProfile.dart';
import 'package:adminappp/Screens/search_Screens/store_search/search_store.dart';
import 'package:adminappp/Screens/strangers/stranger_store_profile/stranger_store_profile.dart';
import 'package:adminappp/constants/AdminInfo.dart';
import 'package:adminappp/constants/MyIndicator.dart';
import 'package:adminappp/constants/constantss.dart';
import 'package:adminappp/constants/followInfo.dart';
import 'package:adminappp/constants/userInfo.dart';

import 'package:adminappp/providers/fireProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class FollowingScreen extends StatefulWidget {
  static const  route='/FollowingScreen';
  const FollowingScreen({Key? key}) : super(key: key);

  @override
  _FollowingScreenState createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {


  UserInfoo? userInfo;
  List<Admin>? admins;

  getUserInfo()async{
    var myId=Provider.of<FireProvider>(context,listen: false).myId;
    UserInfoo user=await UserInfoo().getUserInfo(myId!);
    setState(() {
      userInfo=user;
    });

  }
  getFollowing()async{
    var myId=Provider.of<FireProvider>(context,listen: false).myId;
    List<Admin> admins1=await Follow().getFollowing(userId: myId!);
    debugPrint('getFollowing done  func');
    setState(() {
      admins=admins1;
    });

  }




  void initState() {
    super.initState();
    getUserInfo();
    getFollowing();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(title: Text('محلاتى'),),
      body: SafeArea(
        child:admins==null||userInfo==null
            ?myShimmer(color: Theme.of(context).primaryColor)
        : ListView.builder(
          padding: EdgeInsets.all(10),

          itemBuilder: (context, index) => MyFollowingStores(admin: admins![index],)

          ,

          itemCount: admins!.length,


        )
        ,
      ),
    );
  }
}



class MyFollowingStores extends StatefulWidget {

  final Admin admin;

  const MyFollowingStores({Key? key,required this.admin}) : super(key: key);

  @override
  _MyFollowingStoresState createState() => _MyFollowingStoresState();
}

class _MyFollowingStoresState extends State<MyFollowingStores> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {


    if(widget.admin.adminId==Provider.of<FireProvider>(context,listen: false).myId){

      return  Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          color:Theme.of(context).primaryColorLight,
          elevation: 300,
          shadowColor:Theme.of(context).primaryColor ,
          child: Container(

            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
             //   color: Colors.white.withOpacity(.3)
            ),

            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, StoreProfileScreen.route);
                      },
                      child: Row(
                        children: [

                          Material(
                              type: MaterialType.circle,
                              color: Theme.of(context).cardColor,
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: CircleAvatar(backgroundImage: CachedNetworkImageProvider(widget.admin.photoUrl! ),radius: 40),
                              )
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(widget.admin.name!,
                              style: TextStyle(fontSize: 20,color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.w800),),
                          ),
                        ],
                      ),
                    ),



                    // followButton()
                  ],
                ),


                // SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.person,color: Theme.of(context).primaryColor ,)

                    ,
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(widget.admin.followers.toString(),style: TextStyle(fontSize: 10,color: Theme.of(context).primaryColor),),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }


    else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Material(
            borderRadius: BorderRadius.circular(20),
            color:Theme.of(context).cardColor,
          shadowColor: Theme.of(context).primaryColorDark,
          elevation: 500,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),

            ),
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => StrangerStore(admin:widget.admin ,),));

                      },
                      child: Row(
                        children: [
                          Material(
                              type: MaterialType.circle,
                              color: Theme.of(context).cardColor,
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: CircleAvatar(backgroundImage: CachedNetworkImageProvider(widget.admin.photoUrl!, ),radius: 40),
                              )
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(widget.admin.name!,
                              style: TextStyle(fontSize: 20,color:Theme.of(context).primaryColorDark,fontWeight: FontWeight.w800),),
                          ),
                        ],
                      ),
                    ),




                  ],
                ),


                // SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.person,color:Theme.of(context).primaryColor,) ,
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(widget.admin.followers.toString(),style: TextStyle(fontSize: 10,color:Theme.of(context).primaryColor),),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}

