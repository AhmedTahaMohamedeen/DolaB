





import 'package:adminappp/Screens/Chat_screens/User/user_messages.dart';
import 'package:adminappp/Screens/User/user_shopping_cart/ShoppingCart.dart';
import 'package:adminappp/Screens/User/user_profile/userProfile.dart';
import 'package:adminappp/Screens/search_Screens/StoresOnMap.dart';
import 'package:adminappp/constants/userInfo.dart';
import 'package:adminappp/providers/fireProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class MyHomeAppBar extends StatelessWidget {
  const MyHomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(




        floating: true,
        backgroundColor:
        Theme.of(context).
        appBarTheme.backgroundColor
        ,
        shadowColor: Theme.of(context).appBarTheme.shadowColor,
        elevation: 1,
        flexibleSpace:
        Container(
          height: MediaQuery.of(context).size.height*.25,
          width: MediaQuery.of(context).size.width,
          // color: Colors.blue,


          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(


                  child: HomeUser(),

                ),
              ),
              Expanded(
                child: Container(

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AllStoresMap(),
                      SizedBox(width: 5,),
                      HomeShoppingCart(),
                      SizedBox(width: 5,),
                      HomeEmail(),



                    ],
                  ),
                ),
              )

            ],
          ),
        )
      //  .frosted(blur: 1, frostOpacity: .1, frostColor: Colors.white),
    );
  }
}





class HomeUser extends StatefulWidget {
  const HomeUser({Key? key}) : super(key: key);

  @override
  _HomeUserState createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {

  UserInfoo? userInfoo;
  String fName='';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }
  getUserInfo()async{
    var fire=Provider.of<FireProvider>(context,listen: false);
    if(fire.myUserInfo==null){
      fire.getMyUserInfo(context: context).then((value) {
        var user1=fire.myUserInfo;
        var name=user1!.name;


        if(name!.contains(' ')){
          var list=name.split(' ');
          var firstName=list[0];
          setState(() {
            fName=firstName;
          });
        }
        else{
          setState(() {
            fName=name;
          });
        }
        setState(() {userInfoo=user1;});
      }

      );
    }
    else{
      var user1=fire.myUserInfo;
      var name=user1!.name;


      if(name!.contains(' ')){
        var list=name.split(' ');
        var firstName=list[0];
        setState(() {
          fName=firstName;
        });
      }
      else{
        setState(() {
          fName=name;
        });
      }
      setState(() {userInfoo=user1;});
    }



  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context,constraints) {
          var width=constraints.maxWidth;
          var height=constraints.maxHeight;


          return InkWell(
            onTap: (){
              Navigator.pushNamed(context, UserProfileScreen.route);
            },
            child:
            userInfoo==null?Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,))
                :
            Container(
              // color: Colors.red,

              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0,right: 3),
                    child: Container(
                      width: height*.9,

                      height: height*.9,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Theme.of(context).appBarTheme.titleTextStyle!.color!
                              ,width: 1,style: BorderStyle.solid),


                          image:userInfoo!.photo==null?DecorationImage(image: AssetImage('assets/images/user.png'))
                              : DecorationImage(image: CachedNetworkImageProvider(userInfoo!.photo!,),fit: BoxFit.cover)
                      ),
                    ),
                  ),
                  Text('hi ,',style: TextStyle(
                      color: Theme.of(context).appBarTheme.iconTheme!.color!,
                      fontFamily: Theme.of(context).appBarTheme.titleTextStyle!.fontFamily
                      ,fontSize: height*.25),),
                  Container(
                    // width: 100,
                    child: Text(fName, style: TextStyle(
                      color:
                      Theme.of(context).appBarTheme.iconTheme!.color!
                      ,


                      fontSize: height*.25,fontWeight: FontWeight.w800,),
                      overflow: TextOverflow.ellipsis,



                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}



class HomeEmail extends StatelessWidget {
  const HomeEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context,constraints) {
          var width=constraints.maxWidth;
          var height=constraints.maxHeight;


          return InkWell(

              onTap: (){
                Navigator.pushNamed(context, UserMessages.route);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(


                  decoration: BoxDecoration(

                  ),
                  child: Icon(Icons.mail,
                    color: Theme.of(context).appBarTheme.iconTheme!.color!,


                    size: height*.5,),
                ),
              )





          );
        }
    );
  }
}


class HomeShoppingCart extends StatelessWidget {
  const HomeShoppingCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  LayoutBuilder(
        builder: (context,constraints) {

          var height=constraints.maxHeight;


          return InkWell(
            onTap: (){Navigator.pushNamed(context, UserShoppingCart.route);},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Icon(Icons.shopping_cart,color: Theme.of(context).appBarTheme.iconTheme!.color!,size:height*.5 ),
              ),
            ),
          );
        }
    );
  }
}




class AllStoresMap extends StatelessWidget {
  const AllStoresMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context,constraints) {

          var height=constraints.maxHeight;

          return Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: InkWell(
              onTap: (){
                Navigator.pushNamed(context,StoresOnMap.route );
              },
              child: Material(
                shadowColor: Colors.transparent,
                elevation: 1,
                color: Colors.white,
                child: CircleAvatar(
                  backgroundImage:AssetImage('assets/images/storeLocation2.png') ,
                  radius: height*.25,


                ),
              ),
            ),
          );
        }
    );
  }
}
